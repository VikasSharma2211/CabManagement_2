using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.OleDb;
using System.Diagnostics;
using System.Reflection;
using System.Threading;
using System.Data;
using System.Web.Services;
using Infosys.CabManagement.Model;
using System.Web.Script.Services;
using Infosys.CabManagement.Business;
using System.Runtime.InteropServices;
using System.Globalization;
using System.Collections;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using System.Configuration;

namespace Infosys.CabManagement.UI.Admin
{
    public partial class RosterManagement : System.Web.UI.Page
    {

        static DataTable RosterDt;
        static DataTable RecordForValidateRosterCabDT;
        static DataTable RecordForValidateRosterRouteNameDT;
        static DataTable RecordsForValidCabCapicityDT;
        static DataTable RecordsForValidEmployeeDetailsDT;
        static DataSet RecordForValidateRosterDS;
        static DataTable ErrorDetailDT;
        //static  DataTable InValidRecordDT;
        static OleDbConnection con;
        static string FilePath = string.Empty;
        static string FileName = string.Empty;
        static string Extension = string.Empty;
        static string connstr = string.Empty;
        static string strSQL = string.Empty;
        static string DataSource = string.Empty;
        static string savepath = string.Empty;
        static string tempPath = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }


        #region  Web Methods

        [WebMethod]
        public static string ValidateUploadedRoster(string rosterdetail)
        {
            string isFlag = string.Empty;
            int ValidCounter = 0;
            try
            {
                tempPath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
                savepath = System.Web.Hosting.HostingEnvironment.MapPath(HttpContext.Current.Request.ApplicationPath) + tempPath;//HttpContext.Current.Request.MapPath(tempPath); //System.Web.Hosting.HostingEnvironment.MapPath(tempPath);
                savepath = savepath.Replace(@"\", "\\");
                String[] excelFiles = Directory.GetFiles(savepath, "*.xlsx");
                if (excelFiles.Length != 0)
                {
                    DataSource = excelFiles[0].ToString();
                    connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source='" + DataSource + "';Extended Properties=Excel 12.0";
                    con = new OleDbConnection(connstr);
                    strSQL = "SELECT * FROM [Sheet1$]";
                    OleDbCommand cmd = new OleDbCommand(strSQL, con);

                    DataColumn column = new DataColumn();                                // Add Row ID  Column of Int Type
                    column.DataType = System.Type.GetType("System.Int32");
                    column.AutoIncrement = true;
                    column.AutoIncrementSeed = 1;
                    column.AutoIncrementStep = 1;
                    column.ColumnName = "Row";

                    DataColumn columnCabNovalid = new DataColumn();                       // Add CabNo Column of Bool Type
                    columnCabNovalid.DataType = System.Type.GetType("System.Boolean");
                    columnCabNovalid.DefaultValue = false;
                    columnCabNovalid.ColumnName = "CabNoValid";

                    DataColumn columnRouteNamevalid = new DataColumn();                // Add Route Name Column of Bool Type
                    columnRouteNamevalid.DataType = System.Type.GetType("System.Boolean");
                    columnRouteNamevalid.DefaultValue = false;
                    columnRouteNamevalid.ColumnName = "RouteNameValid";

                    DataColumn columnCabCapacityvalid = new DataColumn();          // Add CabCapacityValid Column of Bool Type
                    columnCabCapacityvalid.DataType = System.Type.GetType("System.Boolean");
                    columnCabCapacityvalid.DefaultValue = false;
                    columnCabCapacityvalid.ColumnName = "CabCapacityValid";

                    DataColumn columnCabPropertyvalid = new DataColumn();       // Add CabPropertyValid Column of Bool Type
                    columnCabPropertyvalid.DataType = System.Type.GetType("System.Boolean");
                    columnCabPropertyvalid.DefaultValue = false;
                    columnCabPropertyvalid.ColumnName = "CabPropertyValid";

                    DataColumn columnEmployeNumberValid = new DataColumn(); // Add EmployeNoValid Column of Bool Type
                    columnEmployeNumberValid.DataType = System.Type.GetType("System.Boolean");
                    columnEmployeNumberValid.DefaultValue = false;
                    columnEmployeNumberValid.ColumnName = "EmployeNoValid";

                    DataColumn columnCabCapacity = new DataColumn(); // Add EmployeNoValid Column of Bool Type
                    columnCabCapacity.DataType = System.Type.GetType("System.String");
                    columnCabCapacity.DefaultValue = false;
                    columnCabCapacity.ColumnName = "CabCapacity";


                    RosterDt = new DataTable();
                    RosterDt.Columns.Add(column);                          // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnCabNovalid);               // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnRouteNamevalid);          // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnCabCapacityvalid);       // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnCabPropertyvalid);      // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnEmployeNumberValid);   // Add the column to a  DataTable.
                    RosterDt.Columns.Add(columnCabCapacity);
           
 
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                    da.Fill(RosterDt);                                // Filled Data From Roster Excel Sheet

                    DataTable dtCloned = RosterDt.Clone();
                    dtCloned.Columns[10].DataType = typeof(System.String);
                    dtCloned.Columns[9].DataType = typeof(System.String);
                    dtCloned.Columns[19].DataType = typeof(System.String);
                    foreach (DataRow row in RosterDt.Rows)
                    {
                        dtCloned.ImportRow(row);
                    }
                    RosterDt.Clear();
                    RosterDt = dtCloned.Copy();

                    // sort data table according to cabNo

                    //RosterDt.DefaultView.Sort = "CabNo";
                    //RosterDt = RosterDt.DefaultView.ToTable();

                    //List<DataTable> ListRosterDt = RosterDt.AsEnumerable()
                    //  .GroupBy(row => row.Field<string>("CabNo"))
                    // .Select(g => g.CopyToDataTable())
                    //         .ToList();

                    RecordForValidateRosterCabDT = new DataTable();
                    RecordForValidateRosterRouteNameDT = new DataTable();
                    RecordsForValidCabCapicityDT = new DataTable();
                    RecordForValidateRosterDS = new DataSet();
                    RecordForValidateRosterDS = GetRecordForValidateRoster();                  // Fill Data From Database For Validate Roster Data
                    RecordForValidateRosterCabDT = RecordForValidateRosterDS.Tables[0];
                    RecordForValidateRosterRouteNameDT = RecordForValidateRosterDS.Tables[1];
                    RecordsForValidCabCapicityDT = RecordForValidateRosterDS.Tables[2];
                    RecordsForValidEmployeeDetailsDT = RecordForValidateRosterDS.Tables[3]; 

                    if (RosterDt.Rows.Count != 0)
                    {
                        for (int i = 0; i < RosterDt.Rows.Count; i++)
                        {
                            //cab no validitycheck
                            string Cabno = RosterDt.Rows[i][7].ToString();
                            string count_record = RecordForValidateRosterCabDT.Select("CabNo like '%" + Cabno + "%'").Count().ToString();   // Count the Filter 
                            if (count_record == null || count_record == "" || count_record == "0")                                         // Check Count zero or not
                            {
                                RosterDt.Rows[i][1] = false;
                                ValidCounter++;
                            }
                            else
                            {
                                RosterDt.Rows[i][1] = true;
                            }

                            //Route no validitycheck
                            string RouteName = RosterDt.Rows[i][8].ToString();
                            RouteName = RouteName.Trim();

                            string cnt_rcd = RecordForValidateRosterRouteNameDT.Select("RouteName like '%" + RouteName + "%'").Count().ToString(); // Count the Filter 
                            if (cnt_rcd == null || cnt_rcd == "" || cnt_rcd == "0")                                                               // Check Count zero or not
                            {
                                RosterDt.Rows[i][2] = false;
                                ValidCounter++;
                            }
                            else
                            {
                                RosterDt.Rows[i][2] = true;
                            }

                            //CabCapacity validitycheck
                            string CabCapacity= RosterDt.Rows[i][6].ToString();
                            var rows = from row in RecordsForValidCabCapicityDT.AsEnumerable()
                                       where row.Field<string>("CabCapacity").Trim() == CabCapacity
                                       select row;
                            DataTable dtt = new DataTable();
                            if (rows == null || rows.Count() == 0)
                            {
                                RosterDt.Rows[i][6] = "0";
                            }
                            else
                            {
                                dtt = rows.CopyToDataTable();

                                string CabCount = RosterDt.Select("CabNo like '%" + Cabno + "%'").Count().ToString();
                                if (int.Parse(CabCount) <= int.Parse(dtt.Rows[0][0].ToString()))
                                {
                                    RosterDt.Rows[i][3] = true;
                                    RosterDt.Rows[i][6] = CabCount;
                                }
                                else
                                {
                                    RosterDt.Rows[i][3] = false;
                                    RosterDt.Rows[i][6] = CabCount;
                                    ValidCounter++;
                                }
                                //CabProperty validitycheck
                                if (dtt.Rows[0][2].ToString() == "True")
                                {

                                    RosterDt.Rows[i][4] = true;
                                }
                                else
                                {
                                    RosterDt.Rows[i][4] = false;
                                    ValidCounter++;

                                }
                            } 
                        
                            //employeenumber validity check(one employee is assigned to only one cab)
                            int num;
                            if (int.TryParse(RosterDt.Rows[i][10].ToString(), out num))
                            {

                                ////bool validEmpFlag = false;
                                //Common.getDirectoryContacts();

                                int numberOfRecords = RosterDt.AsEnumerable().Where(x => x.Field<string>("Employee Number") == RosterDt.Rows[i][10].ToString()).ToList().Count;

                                if (numberOfRecords != 1)
                                {
                                    RosterDt.Rows[i][5] = false;
                                    ValidCounter++;

                                }
                                else
                                {
                                    RosterDt.Rows[i][5] = true;

                                }
                                int empNo = int.Parse(RosterDt.Rows[i][10].ToString());

                                string Emp_record = RecordsForValidEmployeeDetailsDT.Select("EmployeeNumber like '%" + empNo + "%'").Count().ToString();   // Count the Filter 
                                if (Emp_record == null || Emp_record == "" || Emp_record == "0")                                         // Check Count zero or not
                                {
                                    RosterDt.Rows[i][5] = false;
                                    ValidCounter++;
                                }
                                else
                                {
                                    RosterDt.Rows[i][5] = true;
                                }

                                //validEmpFlag = Common.checkEmployeeValidation(EmpNo, ConfigurationManager.AppSettings["LDAP_Path"]);
                      
                               
                            }
                            else
                            {
                                RosterDt.Rows[i][5] = false;
                                ValidCounter++;
                            }


                            string gender = RosterDt.Rows[i][12].ToString();
                            

                            if (gender != null && gender != ""&&(gender=="M"||gender=="F"))
                          {


                          }
                          else
                          {

                              ValidCounter++;
                          }
                            //date check..need to do format check if required

                            if (RosterDt.Rows[i][9].ToString() == null || RosterDt.Rows[i][9].ToString() == "")
                            {
                                RosterDt.Rows[i][9] = "";
                                ValidCounter++;       
                            }
                            else 
                            {
                               
                                //var dateformat=checkdateformat(RosterDt.Rows[i][9].ToString());
                                //if(!dateformat){

                                //    ValidCounter++;   
                                //}
                            
                            
                            }
                            //// Address check..
                            if (RosterDt.Rows[i][13].ToString() != null && RosterDt.Rows[i][13].ToString() != "" && (RosterDt.Rows[i][13].ToString().Length<50))
                            {
                            }
                            else
                            {

                                ValidCounter++;
                            }              


                            //Time check..need to do format check if required

                            if (RosterDt.Rows[i][19].ToString() == null || RosterDt.Rows[i][19].ToString() == "")
                            {
                                RosterDt.Rows[i][19] = "";
                                ValidCounter++;
                            }

                          
                           
                        }
                        if (ValidCounter == 0 && RosterDt.Rows.Count != 0)
                        {
                            isFlag = "Valid";
                        }
                        else
                        {
                            isFlag = "PartialValid";
                        }
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }

                    }
                    else
                    {
                        isFlag = "InValid";
                        RosterDt.Clear();
                    }
                }
            }
            catch (Exception ex)
            {
                Common.WriteError(ex);

            }
            finally
            {
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
                File.Delete(DataSource);
            }

            return isFlag;
        }

        [WebMethod]
        public static List<Roster> GetInvalidData()
        {
            List<Roster> lstRoster = null;
            try
            {
                lstRoster = RosterDt.AsEnumerable().Select(RosterDetail => new Roster
            {
                Cabno = RosterDetail["CabNo"].ToString(),
                RouteName = RosterDetail["RouteName"].ToString(),
                CabnoValid = Convert.ToBoolean(RosterDetail["CabNoValid"].ToString()),
                RouteNameValid = Convert.ToBoolean(RosterDetail["RouteNameValid"].ToString()),
                CabCapacityValid = Convert.ToBoolean(RosterDetail["CabCapacityValid"].ToString()),
                CabPropertyValid = Convert.ToBoolean(RosterDetail["CabPropertyValid"].ToString()),
                EmployeNoValid = Convert.ToBoolean(RosterDetail["EmployeNoValid"].ToString()),
                CabCapacity=RosterDetail["CabCapacity"].ToString(),
                //RousterDate = Convert.ToDateTime(RosterDetail["Date"]).ToShortDateString(),(input > 0) ? "positive" : "negative";
                RousterDate = (RosterDetail["Date"] != "") ? Convert.ToDateTime(RosterDetail["Date"]).ToShortDateString() : RosterDetail["Date"].ToString(),
                EmployeeNo = RosterDetail["Employee Number"].ToString(),
                EmployeeName = RosterDetail["Employee Name"].ToString(),
                EmployeeGender = RosterDetail["Gender"].ToString(),
                Address = RosterDetail["Address"].ToString(),
                Landmark = RosterDetail["Landmark Name"].ToString(),
                Contact = RosterDetail["Contact"].ToString(),
                //PickupTime =Convert.ToDateTime(RosterDetail["Pickup Time"]).TimeOfDay.ToString(),
                PickupTime = (RosterDetail["Pickup Time"] != "") ? Convert.ToDateTime(RosterDetail["Pickup Time"]).TimeOfDay.ToString() : RosterDetail["Pickup Time"].ToString(),
                PickUpOrder= RosterDetail["Pickup order"].ToString(),
                ShiftTime = (RosterDetail["Shift Timings"] != "") ? Convert.ToDateTime(RosterDetail["Shift Timings"]).TimeOfDay.ToString(): RosterDetail["Shift Timings"].ToString(),
                Vendor = RosterDetail["Vendor"].ToString(),
                CabType = RosterDetail["Type"].ToString(),
                Signature = RosterDetail["Signature"].ToString()
          
            }).ToList();

            }

            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
            return lstRoster;

        }
      
        [WebMethod]
        public static List<Roster> GetErrorDetail()
        {
            List<Roster> lstRoster = null;
            try
            {
                var data = from c in RosterDt.AsEnumerable()
                           where (c.Field<bool>("CabnoValid") == false ||
                           c.Field<bool>("RouteNameValid") == false ||
                           c.Field<bool>("CabCapacityValid") == false ||
                           c.Field<bool>("CabPropertyValid") == false ||
                           c.Field<bool>("EmployeNoValid") == false)
                           select c;
                    ErrorDetailDT = new DataTable();
                    ErrorDetailDT = data.CopyToDataTable();
                
               
                lstRoster = ErrorDetailDT.AsEnumerable().Select(ErrorDetail => new Roster
                {
                    Cabno = ErrorDetail["CabNo"].ToString(),
                    RouteName = ErrorDetail["RouteNO"].ToString(),
                    CabnoValid = Convert.ToBoolean(ErrorDetail["CabNoValid"].ToString()),
                    RouteNameValid = Convert.ToBoolean(ErrorDetail["RouteNameValid"].ToString()),
                    CabCapacityValid = Convert.ToBoolean(ErrorDetail["CabCapacityValid"].ToString()),
                    CabPropertyValid = Convert.ToBoolean(ErrorDetail["CabPropertyValid"].ToString()),
                    EmployeNoValid = Convert.ToBoolean(ErrorDetail["EmployeNoValid"].ToString())

                }).ToList();
            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
           
            return lstRoster;
        }

        [WebMethod]
        public static Object InsertRoasterManagement(string rosterdetail)
        {
            bool insertFlag = false;
            //bool UpdateFlag = false;
            string roosterNumber = string.Empty;
            ArrayList roosterNumberlist = new ArrayList();
          
            IEnumerable<dynamic> intersectResult = null;

            List<Roster> RosterDetails = null;

            RoasterManagementBLL objRoasterManagementBLL = null;
            RoasterManagement objRoasterManagement = null; 
            try
            {
                objRoasterManagementBLL = new RoasterManagementBLL();
                objRoasterManagement = new RoasterManagement();
                objRoasterManagement.PreFix = System.DateTime.Now.ToString("yyMMdd");
                bool CreateRosterNoFlag=false;

                RosterDetails = objRoasterManagementBLL.GetRoasterDetail(objRoasterManagement.PreFix);


                int commonRow = 0;
               DataTable dt = new DataTable();
               dt = RosterDt.Copy();

               if (RosterDetails != null)
               {
                   var query1 = dt.AsEnumerable().Select(a => new
                   {
                       CabNo = a["CabNo"].ToString(),
                       ShiftTime = Convert.ToDateTime(a["Shift Timings"]).TimeOfDay.ToString(),
                       RoosterDate = Convert.ToDateTime(a["Date"]).ToShortDateString(),
                 

                   });


                   var query2 = RosterDetails.AsEnumerable().Select(b => new
                   {
                       CabNo = b.Cabno,
                       ShiftTime = b.ShiftTime,
                       RoosterDate = Convert.ToDateTime(b.RousterDate).ToShortDateString()
                   });

                   intersectResult = query1.Intersect(query2);//existing row

            

                   commonRow = intersectResult.Count();
               }


    
                   if (commonRow == 0)//there is no duplicate record in database
                   {
                      
                       var distinctCabs = dt.AsEnumerable().Select(a => new
                       {
                           CabNo = a["CabNo"].ToString(),
                           ShiftTime = Convert.ToDateTime(a["Shift Timings"]).TimeOfDay.ToString(),
                           RoosterDate = Convert.ToDateTime(a["Date"]).ToShortDateString()

                       }).Distinct();


                       
                           foreach (var c in distinctCabs)
                           {
                               CreateRosterNoFlag = CreateRosterNo(objRoasterManagement.PreFix, out roosterNumber);

                               //roosterNumberlist.Add(roosterNumber);

                               if (CreateRosterNoFlag == true)//insert
                               {
                                   
                                roosterNumberlist.Add(roosterNumber);

                               objRoasterManagement.RosterDetailDT = new DataTable();


                               var rows = from row in dt.AsEnumerable()
                                          where row.Field<string>("CabNo").Trim() == c.CabNo
                                          && row.Field<DateTime>("Shift Timings").TimeOfDay == Convert.ToDateTime(c.ShiftTime).TimeOfDay 
                                          && Convert.ToDateTime(row.Field<string>("Date")).ToShortDateString()== Convert.ToDateTime(c.RoosterDate).ToShortDateString()
                                            select row;
                               objRoasterManagement.RosterDetailDT = rows.CopyToDataTable();


                               insertFlag = objRoasterManagementBLL.InsertRoasterDetail(objRoasterManagement);
                           }
                       }
                   }
 

            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
            finally
            {
                objRoasterManagementBLL = null;
            }


            var result = new { Flag = insertFlag, roosternumber = roosterNumberlist, commonrow = intersectResult };
            return result;
        }
      
//        [WebMethod]
//        public static List<Roster> GetRoosterHistory()     
//{        
    
     
          
//            List<Roster> RosterDetails = null;

//            RoasterManagementBLL objRoasterManagementBLL = null;
//            RoasterManagement objRoasterManagement = null;
//            try
//            {
//                objRoasterManagementBLL = new RoasterManagementBLL();
//                objRoasterManagement = new RoasterManagement();
//                objRoasterManagement.PreFix = System.DateTime.Now.ToString("yyMMdd");
 
//                RosterDetails = objRoasterManagementBLL.GetRoasterDetail(objRoasterManagement.PreFix);

//            }


//            catch (Exception ex)
//            {
//                Common.WriteError(ex);
//            }
//            finally
//            {
//                objRoasterManagementBLL = null;
//            }
//            return RosterDetails;
//    }


        #endregion
        public static DataSet GetRecordForValidateRoster()
        {
            DataSet recodDS = new DataSet();
            RosterBLL objRosterBLL = null;
            try
            {
                objRosterBLL = new RosterBLL();
                recodDS = objRosterBLL.GetReocrdForValidateRoster();

            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
            finally
            {
                objRosterBLL = null;
            }
            return recodDS;
        }

        private String[] GetExcelSheetNames(string excelFile)
        {
            OleDbConnection objConn = null;
            System.Data.DataTable dt = null;

            try
            {
                // Connection String. Change the excel file to the file you

                // will search.

                String connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + excelFile + ";Extended Properties=Excel 12.0";
                // Create connection object by using the preceding connection string.

                objConn = new OleDbConnection(connString);
                // Open connection with the database.

                objConn.Open();
                // Get the data table containg the schema guid.

                dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                if (dt == null)
                {
                    return null;
                }

                String[] excelSheets = new String[dt.Rows.Count];
                int i = 0;

                // Add the sheet name to the string array.

                foreach (DataRow row in dt.Rows)
                {
                    excelSheets[i] = row["TABLE_NAME"].ToString();
                    i++;
                }

                // Loop through all of the sheets if you want too...

                for (int j = 0; j < excelSheets.Length; j++)
                {
                    // Query each excel sheet.

                }

                return excelSheets;
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                // Clean up.

                if (objConn != null)
                {
                    objConn.Close();
                    objConn.Dispose();
                }
                if (dt != null)
                {
                    dt.Dispose();
                }
            }
        }

        private static bool CreateRosterNo(string Prifix, out string roosternumber)
        {
            bool isFlag = false;
            RoasterManagementBLL objRoasterManagementBLL = null;
            string roosterno = string.Empty;
            try
            {
                objRoasterManagementBLL = new RoasterManagementBLL();
                isFlag=objRoasterManagementBLL.CreateRoasterNo(Prifix, out roosterno);
                //isFlag = true;
            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
      
            }
            finally
            {
                objRoasterManagementBLL = null;
            }
            roosternumber = roosterno;
            return isFlag;

        }

        public static void ConvrtPDF(DataSet ds, List<string> roosterNumbers, string PreFix)
        {

            if (ds == null)
            {

                return;
            }

            Document pdfDoc = new Document(PageSize._11X17, 10f, 10f, 100f, 0f);
            try
            {
                PdfWriter.GetInstance(pdfDoc, System.Web.HttpContext.Current.Response.OutputStream);
                pdfDoc.Open();
                Chunk c = new Chunk("" + System.Web.HttpContext.Current.Session["CompanyName"] + "", FontFactory.GetFont("Verdana", 11));
                Paragraph p = new Paragraph();
                p.Alignment = Element.ALIGN_CENTER;
                p.Add(c);
                pdfDoc.Add(p);

                Font font8 = FontFactory.GetFont("ARIAL", 7);


                for (int i = 0; i < ds.Tables.Count; i++)
                {
                    DataTable dt = ds.Tables[i];

                    if (dt != null)
                    {
                        //Craete instance of the pdf table and set the number of column in that table  
                        PdfPTable PdfTable = new PdfPTable(dt.Columns.Count);


                        PdfTable.DefaultCell.Padding = 3;
                        PdfTable.WidthPercentage = 100; // percentage
                        PdfTable.DefaultCell.BorderWidth = 2;
                        PdfTable.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;

                        foreach (DataColumn column in dt.Columns)
                        {
                            PdfTable.AddCell(FormatHeaderPhrase(column.ColumnName));
                        }
                        PdfTable.HeaderRows = 1; // this is the end of the table header
                        PdfTable.DefaultCell.BorderWidth = 1;

                        PdfPCell PdfPCell = null;
                        for (int rows = 0; rows < dt.Rows.Count; rows++)
                        {
                            for (int column = 0; column < dt.Columns.Count; column++)
                            {


                                //PdfPCell = new PdfPCell(new Phrase(new Chunk(dt.Rows[rows][column].ToString(), font8)));
                                PdfPCell = new PdfPCell(FormatPhrase(dt.Rows[rows][column].ToString()));
                                PdfTable.AddCell(PdfPCell);
                            }
                        }
                        PdfTable.SpacingBefore = 15f; // Give some space after the text or it may overlap the table    

                        //int j = i + 1;

                        var roosternumber = roosterNumbers[i];
                        Paragraph heading = new Paragraph("ROSTER NUMBER:" + roosternumber, FontFactory.GetFont(FontFactory.TIMES, 10, iTextSharp.text.Font.NORMAL));

                        pdfDoc.Add(heading);

                        pdfDoc.Add(PdfTable); // add pdf table to the document  


                        pdfDoc.NewPage();


                    }

                }

                pdfDoc.Close();
                HttpContext.Current.Response.ContentType = "application/pdf";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + PreFix + "Rooster.pdf");
                System.Web.HttpContext.Current.Response.Write(pdfDoc);
                HttpContext.Current.Response.Flush();
        
            }
            catch (DocumentException de)
            {
                System.Web.HttpContext.Current.Response.Write(de.Message);
            }
            catch (IOException ioEx)
            {
                System.Web.HttpContext.Current.Response.Write(ioEx.Message);
            }
            catch (Exception ex)
            {
                System.Web.HttpContext.Current.Response.Write(ex.Message);
            }
        }

        private static Phrase FormatPhrase(string value)
        {
            return new Phrase(value, FontFactory.GetFont(FontFactory.TIMES, 8));
        }

        private static Phrase FormatHeaderPhrase(string value)
        {
            return new Phrase(value, FontFactory.GetFont(FontFactory.TIMES, 8, iTextSharp.text.Font.BOLD, new iTextSharp.text.BaseColor(0, 0, 255)));
        }

        public static void GetRoosterWiseRecords(List<string> roosterNumbers)
        {
            List<Roster> RosterDetails = null;
            RoasterManagementBLL objRoasterManagementBLL = null;
            string PreFix = System.DateTime.Now.ToString("yyMMdd");

            try
            {
                objRoasterManagementBLL = new RoasterManagementBLL();
                RosterDetails = objRoasterManagementBLL.GetRoasterDetail(PreFix);
                DataSet ds = new DataSet();
                foreach (var rooster in roosterNumbers)
                {

                    var rostertable = RosterDetails
                        .Where(p => p.RoosterNumber == rooster)
                        .Select(p => new
                        {
                            p.RousterDate,
                            p.EmployeeNo,
                            p.EmployeeName,
                            p.Address,
                            p.PickUpOrder,
                            p.PickupTime,
                            p.ShiftTime,
                            p.Cabno,
                            p.CabType,
                            p.Vendor,
                            p.Signature
                        }).ToList();

                    Utility utility = new Utility();
                    DataTable dt = utility.ToDataTable(rostertable);

                    dt.TableName = "Roster-" + rooster;
                    ds.Tables.Add(dt);

                }



                ConvrtPDF(ds, roosterNumbers, PreFix);


                //isFlag = true;
            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
            finally
            {
                objRoasterManagementBLL = null;
            }
            //return RosterDetails;
        }

        protected void RoosterPdf_Click(object sender, EventArgs e)
        {
            //string content = Request.Form["hdnRooster"];          
            //List<string> roosterNumber = content.Split(',').ToList();
            //GetRoosterWiseRecords(roosterNumber);

            printpdf();
        }

        void printpdf()
        {

               Document pdfDoc = new Document(PageSize._11X17, 10f, 10f, 100f, 0f);
               try
               {
                   var roosternumber = 0;
                   PdfWriter.GetInstance(pdfDoc, System.Web.HttpContext.Current.Response.OutputStream);
                   pdfDoc.Open();
                   Chunk c = new Chunk("" + System.Web.HttpContext.Current.Session["CompanyName"] + "", FontFactory.GetFont("Verdana", 11));
                   Paragraph p = new Paragraph();
                   p.Alignment = Element.ALIGN_CENTER;
                   p.Add(c);
                   pdfDoc.Add(p);

                   Font font8 = FontFactory.GetFont("ARIAL", 7);

                   List<DataTable> ListRosterDt = RosterDt.AsEnumerable()
                      .GroupBy(row => row.Field<string>("CabNo"))
                     .Select(g => g.CopyToDataTable())
                             .ToList();
                   foreach (DataTable item in ListRosterDt)
                   {
                       int temp = item.Rows.Count;
                       for (int i = temp-1; i >=0; i--)
                       {
                           if ((Convert.ToBoolean(item.Rows[i][1]) == false) || (Convert.ToBoolean(item.Rows[i][2]) == false) || (Convert.ToBoolean(item.Rows[i][3]) == false) || (Convert.ToBoolean(item.Rows[i][4]) == false) || (Convert.ToBoolean(item.Rows[i][5]) == false))
                       {
                           item.Rows.RemoveAt(i);
                       }
                       }
                       roosternumber++;
                       DataTable newTable = item.Copy();
                       for (int i = 6; i >= 0; i--)
                       {
                           item.Columns.RemoveAt(i);
                       }

                       DataTable dt = item;
                       if (dt != null)
                       {
                           //Craete instance of the pdf table and set the number of column in that table  
                           PdfPTable PdfTable = new PdfPTable(dt.Columns.Count);


                           PdfTable.DefaultCell.Padding = 3;
                           PdfTable.WidthPercentage = 100; // percentage
                           PdfTable.DefaultCell.BorderWidth = 2;
                           PdfTable.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;

                           foreach (DataColumn column in dt.Columns)
                           {
                               PdfTable.AddCell(FormatHeaderPhrase(column.ColumnName));
                           }
                           PdfTable.HeaderRows = 1; // this is the end of the table header
                           PdfTable.DefaultCell.BorderWidth = 1;

                           PdfPCell PdfPCell = null;
                           for (int rows = 0; rows < dt.Rows.Count; rows++)
                           {
                               for (int column = 0; column < dt.Columns.Count; column++)
                               {


                                   //PdfPCell = new PdfPCell(new Phrase(new Chunk(dt.Rows[rows][column].ToString(), font8)));
                                   PdfPCell = new PdfPCell(FormatPhrase(dt.Rows[rows][column].ToString()));
                                   PdfTable.AddCell(PdfPCell);
                               }
                           }
                           PdfTable.SpacingBefore = 15f; // Give some space after the text or it may overlap the table    

                           //int j = i + 1;
                         
                           Paragraph heading = new Paragraph("ROSTER NUMBER:" + roosternumber, FontFactory.GetFont(FontFactory.TIMES, 10, iTextSharp.text.Font.NORMAL));

                           pdfDoc.Add(heading);

                           pdfDoc.Add(PdfTable); // add pdf table to the document  
                           pdfDoc.NewPage();
                       }
                   }
                   }
               finally
               {

                   pdfDoc.Close();
                   HttpContext.Current.Response.ContentType = "application/pdf";
                   HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + "Rooster.pdf");
                   System.Web.HttpContext.Current.Response.Write(pdfDoc);
                   HttpContext.Current.Response.Flush();
               }       
        }
    }
}
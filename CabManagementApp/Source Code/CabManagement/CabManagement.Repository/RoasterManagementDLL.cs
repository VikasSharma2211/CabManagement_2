using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Repository.SqlHelper;
using System.Configuration;
using Infosys.CabManagement.Model;
using System.Data;
using System.Data.SqlClient;
namespace Infosys.CabManagement.Repository
{
    public class RoasterManagementDLL : IDisposable
    {
        SqlHelper.SqlHelper ObjSqlHelper;
        public DataTable asp;
        
         /// <summary>
        /// Set connection string
        /// </summary>
        public RoasterManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to Insert Roaster
        /// </summary>
        /// <returns></returns>

        public bool InsertRosterDetail(RoasterManagement RoasterManagement)
        {
            bool isFlag = false;
            try
            {
                ObjSqlHelper = new SqlHelper.SqlHelper();
                string proc_name = ConstantsDLL.USP_INSERTROASTERDETAIL;
                SqlParameter[] param = new SqlParameter[1];
   
                DataTable dt = new DataTable();
                dt=RoasterManagement.RosterDetailDT;
                dt.Columns.Remove("Row");
                dt.Columns.Remove("CabNoValid");
                dt.Columns.Remove("RouteNameValid");
                dt.Columns.Remove("Signature");
                dt.Columns.Remove("CabCapacityValid");
                dt.Columns.Remove("CabPropertyValid");
                dt.Columns.Remove("EmployeNoValid");
                dt.Columns.Remove("CabCapacity");
                param[0] = new SqlParameter("@TableVar", dt);
                ObjSqlHelper.ExecNonQueryProc(proc_name, param);

                isFlag=true;
            }
            catch(Exception ex)
            {
                isFlag = false;
                throw;
            }
            return isFlag;

        }

        public bool CreateRoaster(string Prifix,out string roosternumber)
        {
            bool isFlag = false;
            try
            {
                ObjSqlHelper = new SqlHelper.SqlHelper();
                string proc_name = ConstantsDLL.USP_CREATEROASTERNO;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Prefix", Prifix);
                param[1] = new SqlParameter("@RoosterNumber", SqlDbType.NVarChar, 20);

                
                param[1].Direction = ParameterDirection.Output;



                ObjSqlHelper.ExecNonQueryProc(proc_name, param);

                roosternumber = param[1].Value.ToString();

                if (roosternumber != null && roosternumber !="")
                isFlag = true;
            }
            catch(Exception ex)
            {
                isFlag = false;
                throw;
            }
            return isFlag;
        }


        public bool UpdateRosterDetail(RoasterManagement RoasterManagement)
        {
            bool isFlag = false;
            try
            {
                ObjSqlHelper = new SqlHelper.SqlHelper();
                string proc_name = ConstantsDLL.USP_UPDATEROASTERDETAIL;
                SqlParameter[] param = new SqlParameter[1];
                //param[0] = new SqlParameter("@PreFix", RoasterManagement.PreFix);
                //param[0] = new SqlParameter("@Client", RoasterManagement.Client);
                //param[1] = new SqlParameter("@ProjectCode", RoasterManagement.ProjectCode);
                //param[2] = new SqlParameter("@PickupDropDate", RoasterManagement.PickupDropDate);
                //param[3] = new SqlParameter("@TotalEmployee", RoasterManagement.TotalEmployee);
                //param[4] = new SqlParameter("@RouteName", RoasterManagement.RouteName);
                //param[5] = new SqlParameter("@LandmarkName", RoasterManagement.LandmarkName);
                //param[6] = new SqlParameter("@TypeOfPickupDrop", RoasterManagement.TypeOfPickupDrop);
                //param[7] = new SqlParameter("@ShiftTimings", RoasterManagement.ShiftTimings);
                //param[8] = new SqlParameter("@CabType", RoasterManagement.CabType);
                //param[9] = new SqlParameter("@Vendor", RoasterManagement.Vendor);
                //param[10] = new SqlParameter("@EndUser", RoasterManagement.EndUser);
                //param[11] = new SqlParameter("@Guard", RoasterManagement.Guard);
                //param[12] = new SqlParameter("@CabNo", RoasterManagement.CabNo);

                DataTable dt = new DataTable();
                dt = RoasterManagement.RosterDetailDT;
                dt.Columns.Remove("Row");
                dt.Columns.Remove("CabNoValid");
                dt.Columns.Remove("RouteNameValid");
                dt.Columns.Remove("Signature");
                dt.Columns.Remove("CabCapacityValid");
                dt.Columns.Remove("CabPropertyValid");
                dt.Columns.Remove("EmployeNoValid");
                dt.Columns.Remove("CabCapacity");
                param[0] = new SqlParameter("@TableVar", dt);
                ObjSqlHelper.ExecNonQueryProc(proc_name, param);

                isFlag = true;
            }
            catch (Exception ex)
            {
                isFlag = false;
                throw;
            }
            return isFlag;

        }

       #region IDisposable Members
       public void Dispose()
       {
           //Dispose(true);
           GC.SuppressFinalize(this);
       }

       #endregion
//method to get rooster details on the basis of some parameter
       public List<Roster> GetRoasterDetail(string Prefix)
       {

           List<Roster> Roosterdetails = null;

           try
           {

               string proc_name = ConstantsDLL.USP_GETROOSTERDETAIL;
               SqlParameter[] param = new SqlParameter[1];


               param[0] = (Prefix == string.Empty) ? new SqlParameter("@Prefix", null) : new SqlParameter("@Prefix", Prefix);

               using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
               {
                   using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                   {
                       if (ds != null)
                       {
                           if (ds.Tables[0].Rows.Count > 0)
                           {
                               DataTable dtRoosterDetails = ds.Tables[0];
                               Roosterdetails = dtRoosterDetails.AsEnumerable().Select(RosterDetails => new Roster
                               {

                                   EmployeeNo = RosterDetails["EmployeeNumber"].ToString(),
                                   ShiftTime = RosterDetails["ShiftTimings"].ToString(),
                                   Cabno = RosterDetails["CabNo"].ToString(),
                                   RoosterNumber = RosterDetails["RosterNo"].ToString(),
                                   RousterDate = Convert.ToDateTime(RosterDetails["PickupDropDate"]).ToShortDateString(),
                                   EmployeeName = RosterDetails["EmployeeName"].ToString(),
                                   EmployeeGender = RosterDetails["Gender"].ToString(),
                                   Address = RosterDetails["Address"].ToString(),
                                   Landmark = RosterDetails["LandmarkName"].ToString(),
                                   Contact = RosterDetails["Contact"].ToString(),
                                   PickUpOrder = RosterDetails["Pickupdroporder"].ToString(),
                                   PickupTime = RosterDetails["PickupDropTime"].ToString(),
                                   Vendor = RosterDetails["Vendor"].ToString(),
                                   CabType = RosterDetails["CabType"].ToString()


                               }).ToList();

                           }
                       }

                   }

               }



           }
           
     catch(Exception ex){
         throw;


     }
           return Roosterdetails;

       }

       public DataSet GetRoosterWiseRecords(List<string> roosterNumbers)
       {

           var roosternumbers = string.Join(",", roosterNumbers);
           DataSet Roosterdetails = null;
           string proc_name = ConstantsDLL.USP_GETROOSTERWISERECORDS;
           SqlParameter[] param = new SqlParameter[1];


           param[0] = (roosternumbers == string.Empty) ? new SqlParameter("@Prefix", null) : new SqlParameter("@roosternumbers", roosternumbers);

           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, roosternumbers))
               {
                   if (ds != null)
                   {

                       }
                   }

               }
               return Roosterdetails;
           }

       public  List<Roster> GetReprintValues(string cabNumber, string date, string shiftTime)
       {
           Roster rst = new Roster();
           List<Roster> Roosterdetails = new List<Roster>();
           Roosterdetails = null;
           try {                               
            string conString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
            SqlConnection conn = new SqlConnection(conString);

            if (shiftTime == "" && cabNumber == "")
            {
                SqlDataAdapter dapt = new SqlDataAdapter("usp_RePrintDataByDate", conn);
                dapt.SelectCommand.CommandType = CommandType.StoredProcedure;              
                dapt.SelectCommand.Parameters.AddWithValue("@GivenDate", date);
                DataTable dt = new DataTable();
               // dt.Columns[1]
                dapt.Fill(dt);
               
           asp =   dt.DefaultView.ToTable(true,"RosterNo");

                //foreach(DataRow drow in asp.Rows)
                //{
                //    string value = drow[0].ToString();
                //}


           //    // dapt.Fill(dt);
           //GridView1.DataSource = dataTable;
           //GridView1.DataMember = "emp";
           //GridView1.DataBind();

                Roosterdetails = dt.AsEnumerable().Select(RosterDetails => new Roster
                {

                    EmployeeNo = RosterDetails["EmployeeNumber"].ToString(),
                    //ShiftTime = Convert.ToDateTime(RosterDetails["ShiftTimings"]).TimeOfDay.ToString(),
                    Cabno = RosterDetails["CabNo"].ToString(),
                    RoosterNumber = RosterDetails["RosterNo"].ToString(),
                    RousterDate = RosterDetails["PickupDropDate"].ToString(),
                    EmployeeName = RosterDetails["EmployeeName"].ToString(),
                    EmployeeGender = RosterDetails["Gender"].ToString(),
                    Address = RosterDetails["Address"].ToString(),
                    Landmark = RosterDetails["LandmarkName"].ToString(),
                    Contact = RosterDetails["Contact"].ToString(),
                    PickUpOrder = RosterDetails["Pickupdroporder"].ToString(),
                    PickupTime = RosterDetails["PickupDropTime"].ToString(),
                    Vendor = RosterDetails["Vendor"].ToString(),
                    CabType = RosterDetails["CabType"].ToString(),
                    //asp =   dt.DefaultView.ToTable(true,"RosterNo")
                }).ToList();
                conn.Close();
                return Roosterdetails;
            }
               
               
               if (cabNumber == "")
            {
                SqlDataAdapter dapt = new SqlDataAdapter("usp_RePrintDataDateShift", conn);                
                dapt.SelectCommand.CommandType = CommandType.StoredProcedure;
                dapt.SelectCommand.Parameters.AddWithValue("@ShiftTime", shiftTime);
                dapt.SelectCommand.Parameters.AddWithValue("@GivenDate", date);
                conn.Open();               
                DataTable dt = new DataTable();
                dapt.Fill(dt);
                Roosterdetails = dt.AsEnumerable().Select(RosterDetails => new Roster
                {
                    EmployeeNo = RosterDetails["EmployeeNumber"].ToString(),
                    //ShiftTime = Convert.ToDateTime(RosterDetails["ShiftTimings"]).TimeOfDay.ToString(),
                    Cabno = RosterDetails["CabNo"].ToString(),
                    RoosterNumber = RosterDetails["RosterNo"].ToString(),
                    RousterDate = RosterDetails["PickupDropDate"].ToString(),
                    EmployeeName = RosterDetails["EmployeeName"].ToString(),
                    EmployeeGender = RosterDetails["Gender"].ToString(),
                    Address = RosterDetails["Address"].ToString(),
                    Landmark = RosterDetails["LandmarkName"].ToString(),
                    Contact = RosterDetails["Contact"].ToString(),
                    PickUpOrder = RosterDetails["Pickupdroporder"].ToString(),
                    PickupTime = RosterDetails["PickupDropTime"].ToString(),
                    Vendor = RosterDetails["Vendor"].ToString(),
                    CabType = RosterDetails["CabType"].ToString()
                }).ToList();
                conn.Close();
                return Roosterdetails;
            }
            if (shiftTime == "")
            {                
                SqlDataAdapter dapt = new SqlDataAdapter("usp_RePrintDataDateCab", conn);
                dapt.SelectCommand .CommandType = CommandType.StoredProcedure;
                dapt.SelectCommand.Parameters.AddWithValue("@CabNumber", cabNumber);
                dapt.SelectCommand.Parameters.AddWithValue("@GivenDate", date);                                         
                DataTable dt = new DataTable();
                dapt.Fill(dt);                              
                    Roosterdetails = dt.AsEnumerable().Select(RosterDetails => new Roster
                    {

                        EmployeeNo = RosterDetails["EmployeeNumber"].ToString(),
                        //ShiftTime = Convert.ToDateTime(RosterDetails["ShiftTimings"]).TimeOfDay.ToString(),
                        Cabno = RosterDetails["CabNo"].ToString(),
                        RoosterNumber = RosterDetails["RosterNo"].ToString(),
                        RousterDate = RosterDetails["PickupDropDate"].ToString(),
                        EmployeeName = RosterDetails["EmployeeName"].ToString(),
                        EmployeeGender = RosterDetails["Gender"].ToString(),
                        Address = RosterDetails["Address"].ToString(),
                        Landmark = RosterDetails["LandmarkName"].ToString(),
                        Contact = RosterDetails["Contact"].ToString(),
                        PickUpOrder = RosterDetails["Pickupdroporder"].ToString(),
                        PickupTime = RosterDetails["PickupDropTime"].ToString(),
                        Vendor = RosterDetails["Vendor"].ToString(),
                        CabType = RosterDetails["CabType"].ToString()
                    }).ToList();
                    conn.Close();
                    return Roosterdetails;                                       
            }                             
                if (shiftTime != "" && cabNumber != "")
                {
                    SqlDataAdapter dapt = new SqlDataAdapter("usp_RePrintDataDateCab", conn);
                    SqlCommand cmd = new SqlCommand("usp_RePrintDataDateShiftCab", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CabNumber", cabNumber);
                    cmd.Parameters.AddWithValue("@GivenDate", date);
                    cmd.Parameters.AddWithValue("@ShiftTime", shiftTime);
                    conn.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    if (dr.Read())
                    {
                        dt.Load(dr);
                    }


                   
    //                string RosterNoo = "";
    //                DataTable dtt = new DataTable();
    //                dtt.Columns.Add(RosterNoo, string);
    //                foreach (DataRow dr in dt.Select("", ))
    //{
    //    if (LastValue == null || !(ColumnEqual(LastValue,dr[Ro])))
    //    {
    //        LastValue = dr[FieldName];
    //       dt.Rows.Add(new object[] { LastValue });
    //    }
    //}




                    Roosterdetails = dt.AsEnumerable().Select(RosterDetails => new Roster
                    {

                        EmployeeNo = RosterDetails["EmployeeNumber"].ToString(),
                        //ShiftTime = Convert.ToDateTime(RosterDetails["ShiftTimings"]).TimeOfDay.ToString(),
                        Cabno = RosterDetails["CabNo"].ToString(),
                        RoosterNumber = RosterDetails["RosterNo"].ToString(),
                        RousterDate = RosterDetails["PickupDropDate"].ToString(),
                        EmployeeName = RosterDetails["EmployeeName"].ToString(),
                        EmployeeGender = RosterDetails["Gender"].ToString(),
                        Address = RosterDetails["Address"].ToString(),
                        Landmark = RosterDetails["LandmarkName"].ToString(),
                        Contact = RosterDetails["Contact"].ToString(),
                        PickUpOrder = RosterDetails["Pickupdroporder"].ToString(),
                        PickupTime = RosterDetails["PickupDropTime"].ToString(),
                        Vendor = RosterDetails["Vendor"].ToString(),
                        CabType = RosterDetails["CabType"].ToString()


                    }).ToList();                
                }
                conn.Close();                                           
               return Roosterdetails;
               

            }                                                                                       
           catch{
           }

           return Roosterdetails;
       }

      
    }
    
}

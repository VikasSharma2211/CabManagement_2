using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Business;
using Infosys.CabManagement.UI;
using System.Web.Services;
using System.Data;
//using Infosys.CabManagement.UI.App_Code;


namespace Infosys.CabManagement.UI.Admin
{
    public partial class CabManagement : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                Int32 RoleId;
                string UserName = string.Empty;
                if (Session["RoleId"] == null)
                {
                    Common objCommon = new Common();
                    UserName = objCommon.GetCurrentUserName();
                    using (RoleManagementBLL objRoleManagementBLL = new RoleManagementBLL())
                    {
                        RoleId = objRoleManagementBLL.GetRoleId(UserName);
                        Session["RoleId"] = RoleId;
                    }
                }
                else
                {
                    RoleId = Convert.ToInt32(Session["RoleId"]);
                }
                switch (RoleId)
                {
                    case 1:
                        break;
                    case 2:
                        break;
                    case 3:
                        break;
                    default:
                        Response.Redirect("~/Error.aspx");
                        break;
                }

            }
        }
        #region Web Methods
        
        [WebMethod]
        public static List<CabType> GetCabType()
        {
            List<CabType> lstcabtype = null;
            CabManagementBLL objCabManagementBLL = null;
            try
            {
                objCabManagementBLL = new CabManagementBLL();
                lstcabtype = objCabManagementBLL.GetCABTYPE(true);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabManagementBLL = null;
            }

            return lstcabtype;
        }

        [WebMethod]
        public static List<Vendor> GetVendorList(int DCID)
        {
            List<Vendor> lstVendor = null;
            VendorManagementBLL objVendorManagementBLL = null;
            try
            {
                objVendorManagementBLL = new VendorManagementBLL();
                lstVendor = objVendorManagementBLL.GetVendorList(null, true,DCID);
            }
            catch (Exception ex)
            {
                
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objVendorManagementBLL = null;
            }
            return lstVendor;
        }
        [WebMethod]
        public static List<DC> GetDCList()
        {
            List<DC> lstVendor = null;
            DCManagementBLL objVendorManagementBLL = null;
            try
            {
                objVendorManagementBLL = new DCManagementBLL();
                lstVendor = objVendorManagementBLL.GetDCDetail();
            }
            catch (Exception ex)
            {

                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objVendorManagementBLL = null;
            }
            return lstVendor;
        }

               
        [WebMethod]

        public static List<CabCapacity> GetCabCapacity()
        {
            List<CabCapacity> lstcabcapacity = null;
            CabManagementBLL objCabManagementBLL = null;
            try
            {
                objCabManagementBLL = new CabManagementBLL();
                lstcabcapacity = objCabManagementBLL.GetCABCAPCITY();                
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally { objCabManagementBLL = null; }

            return lstcabcapacity;
        }

        [WebMethod]

        public static List<CabProperty> GetCabProperty()
        {
            List<CabProperty> lstcabproperty = null;
            CabManagementBLL objCabManagementBLL = null;
            try
            {
                objCabManagementBLL = new CabManagementBLL();
                lstcabproperty = objCabManagementBLL.GetCabproperty(null,true);                
            }

            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objCabManagementBLL = null;
                
            }

            return lstcabproperty;
        }

        [WebMethod]
        public static Int32  InsertCabDetail(CabManagementt  cabManagement)
        {           
            CabManagementBLL objCabManagementBLL = null;
            Int32 Result=0;
          
            try
            {
                Common objCommon = new Common();
                objCabManagementBLL = new CabManagementBLL();
                cabManagement.CreatedBy = objCommon.GetCurrentUserName();

                Result = objCabManagementBLL.InsertCabDetail(cabManagement);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            { 
                objCabManagementBLL = null;
            }
            return Result;  
                    
        }

        [WebMethod]
        public static List<CabManagementt> GetActiveCabDetail()
        {
            
            List<CabManagementt> lstcabdetail = null;
            CabManagementBLL objcabmanagement = null;
            try
            {
                objcabmanagement = new CabManagementBLL();
                lstcabdetail = objcabmanagement.GetCabDetail(null,true);                
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
                
            }
            finally
            {
                objcabmanagement = null;
            }
            return lstcabdetail;
        }

        [WebMethod]
        public static List<CabManagementt> GetInActiveCabDetail()
        {
            List<CabManagementt> lstcabdetail = null;
            CabManagementBLL objcabmanagement = null;
            try
            {
                objcabmanagement = new CabManagementBLL();
                lstcabdetail = objcabmanagement.GetCabDetail(null,false);
                
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objcabmanagement = null;
            }
            return lstcabdetail;
        }

        [WebMethod]
        public static bool DeleteSelectedCab(string CabId, string Comment,bool IsActive)
        {

            bool isFlag = false;
            CabManagementBLL objCabManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                objCabManagementBLL = new CabManagementBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objCabManagementBLL.ActiveInactiveCabDetail(CabId, IsActive, Comment, ModifiedBy);
                
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objCabManagementBLL = null;
            
            }
            return isFlag;
        }

        [WebMethod]
        public static  bool UpdateCabDetail(CabManagementt cabManagement)
        {
            bool isFlag = false;
            CabManagementBLL objCabManagementBLL = null;
            
            try
            {
                Common objCommon = new Common();
                objCabManagementBLL = new CabManagementBLL();
                cabManagement.ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objCabManagementBLL.UpdateCabDetail(cabManagement);
                
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
             }
            finally
            {
                objCabManagementBLL = null;
            }
            return isFlag; 
        }

        [WebMethod]
        public static List<CabProperty> GetCabVerificationDetail(string CabId, string Comment)
        {
            List<CabProperty> lstCabVerificationDetail = null;
            CabManagementBLL objCabManagementBLL = null;
            try
            {
                objCabManagementBLL = new CabManagementBLL();
                lstCabVerificationDetail = objCabManagementBLL.GetCabVerificationDetail(CabId);
                
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objCabManagementBLL = null;

            }
            return lstCabVerificationDetail;
        }


        
        //public static DriverListWithNameCode GetDriverList()
        //{
        //    DriverListWithNameCode objDriverListWithNameCode = new DriverListWithNameCode();
        //    List<string> lstDrivers=null;
        //    List<DriverDetail> lstDriverDetailsDetail = null;
        //    DriverDetailsBLL objDriverDetailBLL = null;
        //    try
        //    {
        //        objDriverDetailBLL = new DriverDetailsBLL();
        //        lstDriverDetailsDetail = objDriverDetailBLL.GetDriverList(string.Empty,true);
        //        lstDrivers = (from driver in lstDriverDetailsDetail
        //                     select driver.DriverName +" - "+driver.DriverCode).ToList();
        //        objDriverListWithNameCode.lstDriverName = lstDriverDetailsDetail.Select(t=>t.DriverName).ToList();
        //        objDriverListWithNameCode.lstDriverNameCode = lstDrivers;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the error to a text file in the Error folder
        //        Common.WriteError(ex);
        //    }
        //    finally
        //    {
        //        objDriverDetailBLL = null;
        //        lstDrivers = null;
        //    }
        //    return objDriverListWithNameCode;
        //}
            [WebMethod]
        public static List<DriverDetail> GetDriverList(int DCID)
        {
            List<DriverDetail> lstDriverDetail = null;
            DriverDetailsBLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsBLL();
                lstDriverDetail = objDriverDetail.GetDriverList(DCID, true);


            }

            catch (Exception ex)
            {
                Common.WriteError(ex);
            }


            finally
            {
                objDriverDetail = null;
            }
            return lstDriverDetail;


        }
      

       #endregion
    }

}
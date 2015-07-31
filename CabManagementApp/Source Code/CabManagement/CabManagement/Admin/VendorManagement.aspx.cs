using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Infosys.CabManagement.Business;
using Infosys.CabManagement.Model;
using System.Web.Script.Services;

namespace Infosys.CabManagement.UI
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
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
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
        }

        #region Web Methods
                      
        [WebMethod]
        public static List<Vendor> GetActiveVendorList()
        {
            List<Vendor> lstVendor = null;
            VendorManagementBLL objVendorManagementBLL=null;
            try
            {             
            objVendorManagementBLL = new VendorManagementBLL();
            lstVendor = objVendorManagementBLL.GetVendorList(null, true);            
            }
            catch(Exception ex)
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
        public static List<Vendor> GetInActiveVendorList()
        {
            List<Vendor> lstVendor = null;
            VendorManagementBLL objVendorManagementBLL = null;
            try
            {
                objVendorManagementBLL = new VendorManagementBLL();
                lstVendor = objVendorManagementBLL.GetVendorList(null, false);
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
        public static Int32 AddNewVendor(Vendor vendor)
        {
            int isFlag = 0;
            Common objCommon = new Common();
            VendorManagementBLL objVendorManagementBLL = null;
            try
            {
                objVendorManagementBLL = new VendorManagementBLL();
                vendor.CreatedBy = objCommon.GetCurrentUserName();
                isFlag=objVendorManagementBLL.InsertVendor(vendor);
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
            return isFlag;
        }

         [WebMethod]
        public static List<DC> GetDCList()
        {
            List<DC> lstDC = null;
            VendorManagementBLL objVendorManagementBLL = null;
            try
            {             
            objVendorManagementBLL = new VendorManagementBLL();
            lstDC = objVendorManagementBLL.GetDCList();            
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objVendorManagementBLL = null;
            }
            return lstDC;
        }

         [WebMethod]
         public static bool DeleteSelectedVendor(string vendorIds,string Comment,bool IsActive)
         {
             bool isFlag = false;
             VendorManagementBLL objVendorManagementBLL = null;
             try
             {
                 Common objCommon = new Common();
                 objVendorManagementBLL = new VendorManagementBLL();
                 string ModifiedBy =objCommon.GetCurrentUserName();
                 isFlag = objVendorManagementBLL.Active_InactiveVendor(vendorIds, IsActive, Comment, ModifiedBy);
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
             return isFlag;
         }

         [WebMethod]
         public static Int32 UpdateVendor(Vendor vendor)
         {
             Int32 isFlag =0;
             VendorManagementBLL objVendorManagementBLL = null;
             try
             {
                 Common objCommon = new Common();
                 objVendorManagementBLL = new VendorManagementBLL();
                 vendor.ModifiedBy =objCommon.GetCurrentUserName();
                 isFlag = objVendorManagementBLL.UpdateVendor(vendor);
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
             return isFlag;
         }
       
      
        #endregion
    }
}
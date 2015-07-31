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

namespace Infosys.CabManagement.UI.Admin
{
    public partial class DCManagement : System.Web.UI.Page
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
                        case 4:
                            break;
                        case 5:
                            break;
                        case 6:
                            break;
                        default:
                            Response.Redirect("~/Error.aspx");
                            break;
                    }

                }
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
        }

        #region Web Methods

        [WebMethod]
        public static List<DC> GetDCType()
        {
            List<DC> lstroletype = null;
            DCManagementBLL objRoleManagementBLL = null;
            try
            {
                objRoleManagementBLL = new DCManagementBLL();
                lstroletype = objRoleManagementBLL.GetDCType();

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objRoleManagementBLL = null;
            }
            return lstroletype;
        }

        [WebMethod]
        public static List<DC> GetDCDetail()
        {
            List<DC> lstroledetail = null;
            DCManagementBLL objRoleManagementBLL = null;
            try
            {
                objRoleManagementBLL = new DCManagementBLL();
                lstroledetail = objRoleManagementBLL.GetDCDetail();

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objRoleManagementBLL = null;
            }
            return lstroledetail;
        }

        [WebMethod]
        public static string InsertDC(string DCName, int IsActive)
        {
            DCManagementBLL objRoleManagementBLL = null;
            string outResult = string.Empty;
           // bool isFlag = false;
            try
            {
                DC dc = new DC();
                dc.DCName = DCName;
                dc.IsActive = IsActive;
                objRoleManagementBLL = new DCManagementBLL();
                dc.CreatedBy = GetCurrentUserName();
                outResult = objRoleManagementBLL.InsertDC(dc);

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objRoleManagementBLL = null;
            }

            return outResult;

        }

        [WebMethod]
        public static string UpdateDC(DC roledetail)
        {
            string isFlag = string.Empty;
            DCManagementBLL objRoleManagementBLL = null;
          //  bool isFlag = false;
            try
            {
                objRoleManagementBLL = new DCManagementBLL();
                roledetail.ModifiedBy = GetCurrentUserName();

                isFlag = objRoleManagementBLL.UpdateDC(roledetail);

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objRoleManagementBLL = null;
            }

            return isFlag;

        }

        [WebMethod]
        public static bool DeleteDC(string DCId, string Comment)
        {
            DCManagementBLL objRoleManagementBLL = null;
            bool isFlag = false;
            try
            {
                objRoleManagementBLL = new DCManagementBLL();

                string ModifiedBy = GetCurrentUserName();

                isFlag = objRoleManagementBLL.DeleteDC(DCId, false, ModifiedBy);

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objRoleManagementBLL = null;
            }
            return isFlag;


        }

        public static string GetCurrentUserName()
        {

          
          //  UserName = System.Web.HttpContext.Current.User.Identity.Name.Substring(11);
          ////  UserName = System.Security.Principal.WindowsIdentity.GetCurrent().Name.Substring(System.Security.Principal.WindowsIdentity.GetCurrent().Name.LastIndexOf("\\") + 1);
          //  return UserName;
              string UserName = null;
             UserName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            //string UserName = System.Web.HttpContext.Current.User.Identity.Name.Substring(11);
            UserName = UserName.Substring(UserName.LastIndexOf("\\") + 1);
            return UserName;
        }

        #endregion
    }
}
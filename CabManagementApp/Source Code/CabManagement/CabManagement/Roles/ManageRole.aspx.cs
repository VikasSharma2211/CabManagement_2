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


namespace Infosys.CabManagement.UI.Roles
{
    public partial class ManageRole : System.Web.UI.Page
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
        public static List<RoleType> GetRoleType()
        {
            List<RoleType> lstroletype = null;
            RoleManagementBLL objRoleManagementBLL = null;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();
                lstroletype = objRoleManagementBLL.GetRoleType();
                
            }
           catch(Exception ex)
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

        //[WebMethod]
        //public static List<RoleDetail> GetInActiveRole()
        //{
        //    List<RoleDetail> lstinactiverole = null;
        //    RoleManagementBLL objRoleManagementBLL = null;
        //    try
        //    {
        //        objRoleManagementBLL = new RoleManagementBLL();
        //        lstinactiverole = objRoleManagementBLL.GetInActiveRole();

        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the error to a text file in the Error folder                
        //        Common.WriteError(ex);
        //    }
        //    finally
        //    {
        //        objRoleManagementBLL = null;
        //    }
        //    return lstinactiverole;
        //}

        [WebMethod]
        public static List<RoleDetail> GetRoleDeatil()
        {
            List<RoleDetail> lstroledetail = null;
            RoleManagementBLL objRoleManagementBLL = null;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();
                lstroledetail = objRoleManagementBLL.GetRoleDetail();
                
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
        public static int InsertRole(RoleDetail Roledetail)
        {
            RoleManagementBLL objRoleManagementBLL = null;
            int isFlag = 0;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();
                Roledetail.CreatedBy = GetCurrentUserName();
                isFlag = objRoleManagementBLL.InsertRole(Roledetail);
                
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
        public static bool UpdateRole(RoleDetail roledetail)
        {
            RoleManagementBLL objRoleManagementBLL = null;
            bool isFlag = false;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();
                roledetail.ModifiedBy=GetCurrentUserName();

                isFlag = objRoleManagementBLL.UpdateRole(roledetail);
               
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
        public static bool DeleteRole(string RoleId, string Comment)
        {
            RoleManagementBLL objRoleManagementBLL = null;
            bool isFlag = false;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();

                string ModifiedBy = GetCurrentUserName();

                isFlag = objRoleManagementBLL.DeleteRole(RoleId, false, ModifiedBy);
               
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

            string UserName = null;
            UserName = System.Web.HttpContext.Current.User.Identity.Name.Substring(11);
            //UserName = System.Security.Principal.WindowsIdentity.GetCurrent().Name.Substring(System.Security.Principal.WindowsIdentity.GetCurrent().Name.LastIndexOf("\\") + 1);
            return UserName;
        }
      


        #endregion
    }
}
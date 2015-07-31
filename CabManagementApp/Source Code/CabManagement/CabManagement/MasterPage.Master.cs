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



namespace Infosys.CabManagement.UI
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {   // Page.ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "alert('MyButton clicked!');", true);

                string UserName = string.Empty;
                Int32 RoleId;
                try
                {
                    Common objCommon = new Common();
                    UserName = objCommon.GetCurrentUserName();
                    //UserName = System.Web.HttpContext.Current.User.Identity.Name.Substring(11);
                    

                    if (UserName == null || UserName == string.Empty)
                    { Response.Redirect("~/Error.aspx"); }

                    if (Session["RoleId"] == null)
                    {
                        RoleId = GetRoleId(UserName);
                        Session["RoleId"] = RoleId;
                    }
                    else
                    {
                        RoleId = Convert.ToInt32(Session["RoleId"]);
                    }
                    switch (RoleId)
                    {
                        case 1:                  //superadmin      
                            break;
                        case 2:                 //DC Admin
                            lirolemanagement.Visible = false;
                            break;
                        case 3:                 //Manager
                            lirolemanagement.Visible = false;
                            break;
                        case 4:                 //Associate
                            lirolemanagement.Visible = false;
                            liVendorManagement.Visible = false;
                            break;
                        case 5:                 //Report Viewer
                            lirolemanagement.Visible = false;
                            liadmin.Visible = false;
                            break;
                        case 6:                 //Report Viewer
                            lirolemanagement.Visible = false;
                            liadmin.Visible = false;
                            break;
                        default:
                            Response.Redirect("~/Error.aspx");
                            break;
                    }

                    
                }
                catch (Exception ex)
                {
                    throw;
                }
            }
        }

        public Int32 GetRoleId(string RoleName)
        {

            Int32 RoleId;

            RoleManagementBLL objRoleManagementBLL = null;
            try
            {
                objRoleManagementBLL = new RoleManagementBLL();
                RoleId = objRoleManagementBLL.GetRoleId(RoleName);
                return RoleId;
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objRoleManagementBLL = null;
            }
        }

        //protected void Button1_Click(object sender, EventArgs e)
        //{
           
        //}

        
      

    }
}
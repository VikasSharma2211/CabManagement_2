using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Business;

namespace Infosys.CabManagement.UI.Admin
{
    public partial class RouteMaster : System.Web.UI.Page
    {
        RouteMasterBLL ObjBllRouteMaster;
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

        /// <summary>
        /// Getting DC List
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static List<DC> GetDCList()
        {
            var DClist = new List<DC>();
            try
            {
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();                
                DClist = ObjBllRouteMaster.GetDCList();
                
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return DClist;
        }

        /// <summary>
        /// Inserting New Routes
        /// </summary>
        /// <param name="ObjRouteMaster"></param>
        /// <returns></returns>
        [WebMethod]
        public static bool AddNewRoute(Model.RouteMaster ObjRouteMaster)
        {
            bool isFlag = false;
            try
            {
                Common objCommon = new Common();
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
                ObjRouteMaster.CreatedBy = objCommon.GetCurrentUserName();
                Int32 rVal = ObjBllRouteMaster.InsertRouteMaster(ObjRouteMaster);
                if (rVal > 0)
                {
                    return (isFlag = true);
                }              
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return isFlag;
        }

        /// <summary>
        /// Adding New Drop Points According to the routes.
        /// </summary>
        /// <param name="ObjRouteMaster"></param>
        /// <returns></returns>

        [WebMethod]
        public static int AddNewDropPoint(Model.RouteMaster ObjRouteMaster)
        {
            int rVal = 0;
            try
            {
                Common objCommon = new Common();
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
                ObjRouteMaster.CreatedBy = objCommon.GetCurrentUserName();
                rVal = ObjBllRouteMaster.InsertDropPoint(ObjRouteMaster);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return rVal;
        }
        //update the existing route


        [WebMethod]
        public static Int32 UpdateDropPoint(Model.RouteMaster ObjRouteMaster)
        {
            Int32 isFlag = 0;
            try
            {
                Common objCommon = new Common();
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
                ObjRouteMaster.CreatedBy = objCommon.GetCurrentUserName();
                Int32 rVal = ObjBllRouteMaster.UpdateRouteMaster(ObjRouteMaster);
                isFlag = rVal;
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return isFlag;
        }

        [WebMethod]
        public static bool DeleteRoutes(Model.RouteMaster ObjRouteMaster)
        {
            bool isFlag = false;
            try
            {
                Common objCommon = new Common();
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
                ObjRouteMaster.ModifiedBy = objCommon.GetCurrentUserName();
                Int32 rVal = ObjBllRouteMaster.DeleteRouteMaster(ObjRouteMaster);
                if (rVal > 0)
                {
                    return (isFlag = true);
                }
                else if (rVal == -1)
                { return (isFlag = true); }
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return isFlag;
        }
        /// <summary>
        /// Fetching all the routes that is created for particular DC
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static List<Model.RouteMaster> GetAllActiveRoutesList()
        {
            var list = new List<Model.RouteMaster>();
            try
            {
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();                
                list = ObjBllRouteMaster.GetAllRoute(null, null, true);               
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return list;
        }

        [WebMethod]
        public static List<Model.RouteMaster> GetAllInactiveRoutesList()
        {
            var list = new List<Model.RouteMaster>();
            try
            {
                RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
                
                list = ObjBllRouteMaster.GetAllRoute(null, null, false);               
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return list;
        }
        /// <summary>
        /// Fetching selected Route According to particular DC
        /// </summary>
        /// <param name="ObjRouteMaster"></param>
        /// <returns></returns>
        [WebMethod]
        public static List<Model.RouteMaster> GetSelectedroute(Model.RouteMaster ObjRouteMaster)
        {
            RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
            var list = new List<Model.RouteMaster>();
            try
            {
                list = ObjBllRouteMaster.GetSelectedroute(ObjRouteMaster);
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return list;
        }
        [WebMethod]
        public static List<Model.RouteMaster> GetSelectedrouteAccordingToDC(Model.RouteMaster ObjRouteMaster)
        {
            RouteMasterBLL ObjBllRouteMaster = new RouteMasterBLL();
            var list = new List<Model.RouteMaster>();
            try
            {
                list = ObjBllRouteMaster.GetSelectedrouteAccordingToDC(ObjRouteMaster);
               
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return list;
        }
    }
}
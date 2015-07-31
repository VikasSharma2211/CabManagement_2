using Infosys.CabManagement.Business;
using Infosys.CabManagement.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.DirectoryServices;
using System.Data;
using System.Data.SqlClient;

namespace Infosys.CabManagement.UI.Admin
{
    public partial class PenaltyFine : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<DC> GetAllDC()
        {
            List<DC> lstRoute = null;
            RouteMasterBLL objRouteMasterBLL = null;
            RouteMaster routeMaster = new RouteMaster();
            //   int DCId = 1;//
            try
            {

                objRouteMasterBLL = new RouteMasterBLL();
                lstRoute = objRouteMasterBLL.GetSelectedDC();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                objRouteMasterBLL = null;
            }
            return lstRoute;
        }
        [WebMethod]
        public static List<CabManagementt> GetAllCabListByDC(string DCID)
        {
            List<CabManagementt> lstRoute = null;
            CabManagementBLL objCabManagementBLL = null;
            CabManagementt cabManagement = new CabManagementt();
            try
            {
                objCabManagementBLL = new CabManagementBLL();
                lstRoute = objCabManagementBLL.GetAllCabListByDC(DCID);
            }
            catch (Exception ex)
            {

            }
            finally
            {
                objCabManagementBLL = null;
            }
            return lstRoute;
        }

        [WebMethod]
        public static bool PenaltyOnCab(Penalty PenaltyImpose)
        {
            bool flag = false;
            Common objCommon = new Common();
            CabManagementBLL objCabManagementBLL = new CabManagementBLL();
            try
            {
                flag = objCabManagementBLL.PenaltyOnCab(PenaltyImpose);
              
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
            return flag;
        }
    }
}
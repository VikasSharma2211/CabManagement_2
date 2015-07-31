using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Infosys.CabManagement.Business;
using Infosys.CabManagement.Model;
using System.Web.Script.Services;

namespace Infosys.CabManagement.UI
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Web Methods

        [WebMethod]
        public static List<CabProperty> GetActiveCabPropertyList()
        {
            List<CabProperty> lstCabProperty = null;
            PropertyManagementBLL objCabPropertyManagementBLL = null;
            try
            {
                objCabPropertyManagementBLL = new PropertyManagementBLL();
                lstCabProperty = objCabPropertyManagementBLL.GetCabPropertyList(null, true);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabPropertyManagementBLL = null;
            }
            return lstCabProperty;
        }

        [WebMethod]
        public static List<CabProperty> GetInActiveCabPropertyList()
        {
            List<CabProperty> lstCabProperty = null;
            PropertyManagementBLL objCabPropertyManagementBLL = null;
            try
            {
                objCabPropertyManagementBLL = new PropertyManagementBLL();
                lstCabProperty = objCabPropertyManagementBLL.GetCabPropertyList(null, false);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabPropertyManagementBLL = null;
            }
            return lstCabProperty;
        }


        [WebMethod]
        public static Int32 AddNewCabProperty(CabProperty CabProperty)
        {
            int isFlag = 0;
            Common objCommon = new Common();
            PropertyManagementBLL objCabPropertyManagementBLL = null;
            try
            {
                objCabPropertyManagementBLL = new PropertyManagementBLL();
                CabProperty.CreatedBy = objCommon.GetCurrentUserName();
                isFlag = objCabPropertyManagementBLL.InsertCabProperty(CabProperty);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabPropertyManagementBLL = null;
            }
            return isFlag;
        }

       

        [WebMethod]
        public static bool DeleteSelectedCabProperty(string CabPropertyIds, bool IsActive)
        {
            bool isFlag = false;
            PropertyManagementBLL objCabPropertyManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                objCabPropertyManagementBLL = new PropertyManagementBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objCabPropertyManagementBLL.Active_InactiveCabProperty(CabPropertyIds, IsActive, ModifiedBy);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabPropertyManagementBLL = null;
            }
            return isFlag;
        }

        [WebMethod]
        public static bool UpdateCabProperty(CabProperty CabProperty)
        {
            bool isFlag = false;
            PropertyManagementBLL objCabPropertyManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                objCabPropertyManagementBLL = new PropertyManagementBLL();
                CabProperty.ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objCabPropertyManagementBLL.UpdateCabProperty(CabProperty);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objCabPropertyManagementBLL = null;
            }
            return isFlag;
        }


        #endregion
    }
}
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

namespace Infosys.CabManagement.UI.Admin
{
    public partial class DriverDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {




        }

        #region  Web Methods
        [WebMethod]
        public static List<DriverDetail> GetDriverList()
        {
            List<DriverDetail> lstDriverDetail = null;
            DriverDetailsBLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsBLL();
                lstDriverDetail = objDriverDetail.GetDriverList(null, true);

                
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
        public static int InsertDriverDetail(DriverDetail DriverDetail)
        {
            DriverDetailsBLL objDriverDetailBLL = null;
            int outResult = 0;
            try
            {
                objDriverDetailBLL = new DriverDetailsBLL();
                Common objCommon = new Common();
                DriverDetail.CreatedBy = objCommon.GetCurrentUserName();
                DriverDetail.IsActive = true;
                outResult = objDriverDetailBLL.InsertDriverDetail(DriverDetail);

            }
            catch(Exception ex)
            {
                Common.WriteError(ex);
            }
            finally
            {
                objDriverDetailBLL = null;
            }

            return outResult;

        }

        [WebMethod]
        public static Int32 UpdateDriver(DriverDetail DriverDetail)
        {
            DriverDetailsBLL objDriverDetailBLL = null;
            Int32 outResult = 0;
            try
            {
                objDriverDetailBLL = new DriverDetailsBLL();
                Common objCommon = new Common();
                DriverDetail.ModifyBy = objCommon.GetCurrentUserName();
                //DriverDetail.IsActive = true;
                outResult = objDriverDetailBLL.UpdateDriverDetail(DriverDetail);

            }
            catch (Exception ex)
            {
                Common.WriteError(ex);
            }
            finally
            {
                objDriverDetailBLL = null;
            }

            return outResult;



        }



        [WebMethod]
        public static List<DriverDetail> GetActiveDriverList()
        {
            List<DriverDetail> lstDriverDetail = null;
            DriverDetailsBLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsBLL();
                lstDriverDetail = objDriverDetail.GetDriverList(null, true);


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
        [WebMethod]
        public static List<DriverDetail> GetInActiveDriverList()
        {
            List<DriverDetail> lstDriverDetail = null;
            DriverDetailsBLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsBLL();
                lstDriverDetail = objDriverDetail.GetDriverList(null, false);


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

        [WebMethod]
        public static bool DeleteSelectedDriver(string  DriverId, string Comment, bool IsActive)
        {

            bool isFlag = false;
            DriverDetailsBLL objDriverDetailBLL = null;
            try
            {
                Common objCommon = new Common();
                objDriverDetailBLL = new DriverDetailsBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objDriverDetailBLL.ActiveInactiveDriver(DriverId, IsActive, ModifiedBy);

            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder
                Common.WriteError(ex);
            }
            finally
            {
                objDriverDetailBLL = null;

            }
            return isFlag;
        }


        #endregion



    }}
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

namespace Infosys.CabManagement.UI
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchRecord();
            }
        }

        public void FetchRecord()
        {
            OnDemandRequest ondobj = null;
            DataSet Records = null;
            OnDemandRequestBLL obj = null;
            try
            {
                obj = new OnDemandRequestBLL();
                Common objCommon = new Common();
                string EmailId = objCommon.GetCurrentUserName();// +"@infosys.com";
                Records = new DataSet();

                Records = obj.GetFetchRecords(EmailId);

                ondobj = new OnDemandRequest();
                if (Records.Tables[0].Rows.Count > 0)
                {


                    ondobj.BookingType = Records.Tables[0].Rows[0]["BookingType"].ToString();
                    ondobj.Gender = Records.Tables[0].Rows[0]["Gender"].ToString();
                    ondobj.RouteName =( Records.Tables[0].Rows[0]["routename"].ToString().Trim());
                    ondobj.Address = Records.Tables[0].Rows[0]["Address"].ToString();
                    ondobj.RouteId = Convert.ToInt32(Records.Tables[0].Rows[0]["Routeid"].ToString());


                }
                var script = "$('#txtAddress').val('" + ondobj.Address + "');";
                if (ondobj.Gender == "FEMALE")
                {

                    script += "$('#Femaleid').prop('checked', true);";
                }
                else
                {
                    script += "$('#maleid').prop('checked', true);";
                }

               //script += " $('#ddlRoute').val('" + ondobj.RouteId + "');";
                // $('#ddlPickUpTime').append($("<option></option>").val('" + ondobj.RouteName + "').html('" + ondobj.RouteName + "'));
               

                if (ondobj.BookingType == "LogIn")
                {
                    script += "$('#rdbtnlogin').prop('checked', true);";
                    script += "$('.spnBookType').text('PickUp');";
                    script += "$('.spnBookType1').text('PickUp');";
                  

                }
                else
                {
                    script += "$('#rdbtnlogout').prop('checked', true);";
                    script += "$('.spnBookType').text('Drop');";
                    script += "$('.spnBookType1').text('Drop');";
                }

                ClientScript.RegisterStartupScript(typeof(string), "textvaluesetter", script, true);



            }
            catch (Exception)
            {
            }

        }

        [WebMethod]
        public static List<RouteMaster> GetAllRoutesListByDC(int DCID)
        {
            List<RouteMaster> lstRoute = null;
            RouteMasterBLL objRouteMasterBLL = null;
            RouteMaster routeMaster = new RouteMaster();
           // int DCId = 1;//
            try
            {
                routeMaster.DCID = DCID;
                objRouteMasterBLL = new RouteMasterBLL();
                lstRoute = objRouteMasterBLL.GetSelectedroute(routeMaster);
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
        public static List<RouteMaster> GetAllPointsByRoutes(string RouteName)
        {
            List<RouteMaster> lstRoute = null;
            RouteMasterBLL objRouteMasterBLL = null;
            RouteMaster routeMaster = new RouteMaster();
            try
            {
                objRouteMasterBLL = new RouteMasterBLL();
                lstRoute = objRouteMasterBLL.GetAllPointsByRoute(RouteName);
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
        public static List<Shift> GetShiftsByDC(string ShiftType, string RequestType)
        {
            List<Shift> lstShift = null;
            ShiftManagementBLL objShiftManagementBLL = null;
            try
            {
                int DCId = 1;
               // string requestType = "";
                objShiftManagementBLL = new ShiftManagementBLL();
                lstShift = objShiftManagementBLL.GetShiftListByDC(DCId, ShiftType, RequestType);
            }
            catch (Exception ex)
            {

            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return lstShift;
        }

        [WebMethod]
        public static bool SaveOndemandRequest(OnDemandRequest OnDemandCabBooking)
        {
            bool IsFLag = false;
            try
            {
                OnDemandRequestBLL objOnDemand = null;

                try
                {
                    Common objCommon = new Common();
                    objOnDemand = new OnDemandRequestBLL();
                    OnDemandCabBooking.CreatedBy = objCommon.GetCurrentUserName();
                    OnDemandCabBooking.EmailId = objCommon.GetCurrentUserName();// +"@infosys.com";
                    IsFLag = objOnDemand.InsertOnDemandCabDetail(OnDemandCabBooking);
                }
                catch (Exception ex)
                {
                    // Log the error to a text file in the Error folder
                    Common.WriteError(ex);
                }
                finally
                {
                    objOnDemand = null;
                }
                return IsFLag;
            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return IsFLag;
        }

        [WebMethod]
        public static Dictionary<string, string> GetLogUsrDetails()
        {
            Dictionary<string, string> usrDetails = null;
            try
            {
                string userName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
                if (userName.Contains('\\'))
                {
                    userName = userName.Split('\\')[1];
                }
                usrDetails = Common.GetUserDetails(userName, ConfigurationManager.AppSettings["LDAP_Path"]);
            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return usrDetails;
        }

        [WebMethod]
        public static int CheckRecord(int routeId,DateTime requestedDate)
        {
            OnDemandRequest ondobj = null;
            DataSet Records = null;
            OnDemandRequestBLL obj = null;
            int value = 0;
            try
            {
                obj = new OnDemandRequestBLL();
                Common objCommon = new Common();
                string EmailId = objCommon.GetCurrentUserName();// +"@infosys.com";
                Records = new DataSet();

                Records = obj.GetCheckRecords(EmailId,routeId,requestedDate);

                if (Records.Tables[0].Rows.Count > 0 && Records.Tables[0]!=null)
                     value= Convert.ToInt32(Records.Tables[0].Rows[0]["Record"].ToString());
                           

            }
            catch (Exception)
            {
               // return 0;
            }
                return value;

            

        }


    }
}
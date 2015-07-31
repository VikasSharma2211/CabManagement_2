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
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<OnDemandRequest> MyRequestUsers()
        {
            List<OnDemandRequest> lstUsersDetail = null;
            OnDemandRequestBLL objUserDetail = null;
            try
            {
                objUserDetail = new OnDemandRequestBLL();
                Common objCommon = new Common();
                lstUsersDetail = objUserDetail.GetMyRequest(objCommon.GetCurrentUserName(), false);


            }

            catch (Exception ex)
            {
                Common.WriteError(ex);
            }


            finally
            {
                objUserDetail = null;
            }
            return lstUsersDetail;


        }

        [WebMethod]
        public static bool UpdateRequest(OnDemandRequest Request)
        {
            bool isFlag = false;
            OnDemandRequestBLL objMyRequestBLL = null;
            try
            {
                Common objCommon = new Common();
                objMyRequestBLL = new OnDemandRequestBLL();
                Request.ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objMyRequestBLL.UpdateRequest(Request);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objMyRequestBLL = null;
            }
            return isFlag;
        }

         [WebMethod]
        public static bool CancelRequest(string RequestId)
        {
            bool isFlag = false;
            OnDemandRequestBLL objMyRequestBLL = null;
            try
            {
               
                objMyRequestBLL = new OnDemandRequestBLL();

                isFlag = objMyRequestBLL.CancelRequest(Convert.ToInt32(RequestId));
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objMyRequestBLL = null;
            }
            return isFlag;
        }


        
     

    }
}
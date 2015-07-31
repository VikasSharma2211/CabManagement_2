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
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        [WebMethod]
        public static List<OnDemandRequest> GetUserList()
        {
            List<OnDemandRequest> lstUsersDetail = null;
            OnDemandRequestBLL objUserDetail = null;
            try
            {
                objUserDetail = new OnDemandRequestBLL();
                Common objCommon = new Common();
                lstUsersDetail = objUserDetail.GetUserDetails(objCommon.GetCurrentUserName(), false);


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
        public static bool RejectRequestUsers(string UserId, string Comment)
        {

            bool isFlag = false;
            OnDemandRequestBLL objDriverDetailBLL = null;
            try
            {
                Common objCommon = new Common();
                objDriverDetailBLL = new OnDemandRequestBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objDriverDetailBLL.RejectUserRequest(UserId, ModifiedBy,Comment);

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
        [WebMethod]
               public static bool ApproveUserRequest(string UserId, string Comment)
               {

                   bool isFlag = false;
                   OnDemandRequestBLL objDriverDetailBLL = null;
                   try
                   {
                       Common objCommon = new Common();
                       objDriverDetailBLL = new OnDemandRequestBLL();
                       string ModifiedBy = objCommon.GetCurrentUserName();
                       isFlag = objDriverDetailBLL.ApproveUserRequest(UserId, ModifiedBy, Comment);

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
               [WebMethod]
               public static List<OnDemandRequest> GetRejectedUserList()
               {
                   List<OnDemandRequest> lstUsersDetail = null;
                   OnDemandRequestBLL objUserDetail = null;
                   try
                   {
                       objUserDetail = new OnDemandRequestBLL();
                       Common objCommon = new Common();
                       lstUsersDetail = objUserDetail.GetRejectedUserDetails(objCommon.GetCurrentUserName());


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
        public static List<OnDemandRequest> GetActiveUserList()
        {
            List<OnDemandRequest> lstUsersDetail = null;
            OnDemandRequestBLL objUserDetail = null;
            try
            {
                objUserDetail = new OnDemandRequestBLL();
                Common objCommon = new Common();
                lstUsersDetail = objUserDetail.GetActiveUserDetails(objCommon.GetCurrentUserName());


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
        public static bool PendingRequestUsers(string UserId, string Comment, bool IsActive)
        {

            bool isFlag = false;
            OnDemandRequestBLL objDriverDetailBLL = null;
            try
            {
                Common objCommon = new Common();
                objDriverDetailBLL = new OnDemandRequestBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objDriverDetailBLL.ActiveInactiveUser(UserId, IsActive, ModifiedBy);

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

    }
}





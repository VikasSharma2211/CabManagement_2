using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;
using System.Data;

namespace Infosys.CabManagement.Business
{
    public class OnDemandRequestBLL : IDisposable
    {
        public bool InsertOnDemandCabDetail(OnDemandRequest ondemandDetails)
        {

            OnDemandRequestDLL ObjOnDemanddll = null;
            ObjOnDemanddll = new OnDemandRequestDLL();
            //Boolean is_Save = false;
            //  DateTime tempdate = ondemandDetails.RequestedDate;
            //if (ondemandDetails.ReoccuringRequest == "Yes")
            //{
            //    DateTime tempdate =Convert.ToDateTime(ondemandDetails.RequestedDate);
            //    while (tempdate <= ondemandDetails.toDate)
            //    {
            //        ondemandDetails.RequestedDate = tempdate.ToString();
            //        is_Save = (ObjOnDemanddll.InsertRequest(ondemandDetails));
            //        tempdate = tempdate.AddDays(1);

            //    }
            //    return is_Save;
            //}

            return (ObjOnDemanddll.InsertRequest(ondemandDetails));
        }


        #region IDisposable Members

        public void Dispose()
        {
            //Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion
        public List<OnDemandRequest> GetUserDetails(string UserCode, bool? IsActive)
        {
            List<OnDemandRequest> lstDriverDetail = null;
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.GetUserDetails(UserCode, IsActive);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }
        
        public bool ActiveInactiveUser(string UserID, bool ActiveInactive, string ModifiedBy)
        {
            bool isFlag = false;
            OnDemandRequestDLL objDriverDetailDLL = null;
            try
            {
                objDriverDetailDLL = new OnDemandRequestDLL();

                isFlag = objDriverDetailDLL.ActiveInactiveUser(UserID, ActiveInactive, ModifiedBy);

                return isFlag;
            }
            catch (Exception e)
            {

                throw;
            }
            finally
            {
                objDriverDetailDLL = null;
            }

        }
        public bool ApproveUserRequest(string UserId, string ModifiedBy, string Comment)
        {
            bool isFlag = false;
            OnDemandRequestDLL objDriverDetailDLL = null;
            try
            {
                objDriverDetailDLL = new OnDemandRequestDLL();

                isFlag = objDriverDetailDLL.ApproveUserRequest(UserId, ModifiedBy, Comment);

                return isFlag;
            }
            catch (Exception e)
            {

                throw;
            }
            finally
            {
                objDriverDetailDLL = null;
            }

        }
        public List<OnDemandRequest> GetActiveUserDetails(string Emailid)
        {
            List<OnDemandRequest> lstDriverDetail = null;
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.GetActiveUserDetails(Emailid);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }

        public List<OnDemandRequest> GetMyRequest(string UserCode, bool? IsActive)
        {
            List<OnDemandRequest> lstDriverDetail = null;
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.GetMyAllRequests(UserCode, IsActive);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }
        public DataSet GetFetchRecords(string EmailId)
        {
            DataSet lstDriverDetail = new DataSet();
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.GetRecords(EmailId);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }

        public DataSet GetCheckRecords(string EmailId, int RouteId, DateTime RequestedDate)
        {
            DataSet lstDriverDetail = new DataSet();
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.CheckRecords(EmailId, RouteId, RequestedDate);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }



    
        public bool RejectUserRequest(string UserId, string ModifiedBy, string Comment)
        {
            bool isFlag = false;
            OnDemandRequestDLL objDriverDetailDLL = null;
            try
            {
                objDriverDetailDLL = new OnDemandRequestDLL();

                isFlag = objDriverDetailDLL.RejectUserReq(UserId, ModifiedBy, Comment);

                return isFlag;
            }
            catch (Exception e)
            {

                throw;
            }
            finally
            {
                objDriverDetailDLL = null;
            }

        }

        public List<OnDemandRequest> GetRejectedUserDetails(string Emailid)
        {
            List<OnDemandRequest> lstDriverDetail = null;
            try
            {
                using (OnDemandRequestDLL userDetailDLL = new OnDemandRequestDLL())
                {
                    lstDriverDetail = userDetailDLL.GetRejectedUserDetails(Emailid);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }

        public bool UpdateRequest(OnDemandRequest Request)
        {
            bool isFlag = false;
            try
            {
                using (OnDemandRequestDLL MyRequestDLL = new OnDemandRequestDLL())
                {
                    isFlag = MyRequestDLL.UpdateRequest(Request);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }        
        }

        public bool CancelRequest(int RequestId)
        {
            bool isFlag = false;
            try
            {
                using (OnDemandRequestDLL MyRequestDLL = new OnDemandRequestDLL())
                {
                    isFlag = MyRequestDLL.CancelRequest(RequestId);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }    
        }
    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Repository.SqlHelper;
using Infosys.CabManagement.Model;
using System.Data;
using System.Data.SqlClient;

namespace Infosys.CabManagement.Repository
{
    public class OnDemandRequestDLL:IDisposable
    {
        /// <summary>
        /// Set connection string
        /// </summary>
        public OnDemandRequestDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to insert the details for creating new request
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public bool InsertRequest(OnDemandRequest request)
        {
            string proc_name = ConstantsDLL.USP_INSERTNEWREQUEST;
            SqlParameter[] param = new SqlParameter[15];
            param[0] = new SqlParameter("@RequestType", request.RequestType);
            param[1] = new SqlParameter("@ReoccuringRequestId", request.ReoccuringRequest);
            param[2] = new SqlParameter("@ToDate", request.toDate);

            param[3] = new SqlParameter("@EmailId", request.EmailId);
            param[4] = new SqlParameter("@BookingType", request.BookingType);
            param[5] = new SqlParameter("@Gender", request.Gender);
            param[6] = new SqlParameter("@RouteId", request.RouteId);
            param[7] = new SqlParameter("@RequestedDate", request.RequestedDate);

            param[8] = new SqlParameter("@RequestedTime", System.Data.SqlDbType.Time,50);
            param[8].Value = request.RequestedTime;
            param[9] = new SqlParameter("@Address", request.Address);
            param[10] = new SqlParameter("@Mobile", request.Mobile);
            param[11] = new SqlParameter("@RequestRemarks", request.RequestRemarks);
            param[12] = new SqlParameter("@CreatedBy", request.CreatedBy);
            param[13] = new SqlParameter("@DCID", request.DCID);
            param[14] = new SqlParameter("@Approver", request.Approver);
    
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
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

            List<OnDemandRequest> lstCabdetail = null;
            string proc_name = ConstantsDLL.USP_GetUserDetails;
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@UserCode", UserCode);
            param[1] = new SqlParameter("@IsActive", IsActive);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABDETAIL = ds.Tables[0];
                            lstCabdetail = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new OnDemandRequest
                            {
                                OndemandRequestId = Convert.ToInt32(Cabdetail["OndemandRequestId"].ToString()),
                                EmailId = Cabdetail["EmailId"].ToString(),
                                BookingType = Cabdetail["BookingType"].ToString(),
                                Gender = Cabdetail["Gender"].ToString(),
                                RouteId =Convert.ToInt32(Cabdetail["RouteId"].ToString()),
                                RequestedDate = Cabdetail["RequestedDate"].ToString(),
                                RequestedTime =Cabdetail["RequestedTime"].ToString(),
                                Address = Cabdetail["Address"].ToString(),
                                RequestRemarks = Cabdetail["RequestRemarks"].ToString(),
                                IsApprovedStatus = Convert.ToInt32(Cabdetail["isapprovedstatus"]),
                               

                            }).ToList();
                        }
                    }
                }
            }
            return lstCabdetail;
        }

        public bool ActiveInactiveUser(string UserID, bool ActiveInactive, string ModifiedBy)
        {


            string proc_name = ConstantsDLL.USP_ACTIVEINACTIVEUSER;

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@OndemandRequestID", UserID);
            param[1] = new SqlParameter("@IsActive", ActiveInactive);


            param[2] = new SqlParameter("@ModifiedBy", ModifiedBy);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;






        }

        public List<OnDemandRequest> GetActiveUserDetails(string Emailid)
        {
            List<OnDemandRequest> lstCabdetail = null;
            string proc_name = ConstantsDLL.USP_GetActiveUserDetails;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@UserCode", Emailid);
           

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABDETAIL = ds.Tables[0];
                            lstCabdetail = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new OnDemandRequest
                            {
                                OndemandRequestId = Convert.ToInt32(Cabdetail["OndemandRequestId"].ToString()),
                                EmailId = Cabdetail["EmailId"].ToString(),
                                BookingType = Cabdetail["BookingType"].ToString(),
                                Gender = Cabdetail["Gender"].ToString(),
                                RouteId = Convert.ToInt32(Cabdetail["RouteId"].ToString()),
                                RequestedDate = Convert.ToDateTime(Cabdetail["RequestedDate"]).ToString("MMM dd,yyyy"),
                                RequestedTime = Cabdetail["RequestedTime"].ToString(),
                                Address = Cabdetail["Address"].ToString(),
                                RequestRemarks = Cabdetail["RequestRemarks"].ToString(),
                                IsApprovedStatus = Convert.ToInt32(Cabdetail["isapprovedstatus"]) ,


                            }).ToList();
                        }
                    }
                }
            }
            return lstCabdetail;
        }

        public List<OnDemandRequest> GetMyAllRequests(string UserCode, bool? IsActive)
        {
            List<OnDemandRequest> lstCabdetail = null;
            string proc_name = ConstantsDLL.USP_GetMyRequest;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@UserCode", UserCode);
         
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABDETAIL = ds.Tables[0];
                            lstCabdetail = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new OnDemandRequest
                            {
                                OndemandRequestId = Convert.ToInt32(Cabdetail["OndemandRequestId"].ToString()),
                                EmailId = Cabdetail["EmailId"].ToString(),
                                BookingType = Cabdetail["BookingType"].ToString(),
                                RequestType = Cabdetail["RequestType"].ToString(),
                                Gender = Cabdetail["Gender"].ToString(),
                               RouteName = Cabdetail["RouteName"].ToString(),
                                RequestedDate = Cabdetail["RequestedDate"].ToString(),
                                RequestedTime = Cabdetail["RequestedTime"].ToString(),
                                Address = Cabdetail["Address"].ToString(),
                                RequestRemarks = Cabdetail["RequestRemarks"].ToString(),

                                IsApprovedStatus = Convert.ToInt32(Cabdetail["isapprovedstatus"]),


                            }).ToList();
                        }
                    }
                }
            }
            return lstCabdetail;
        }

        public DataSet GetRecords(string EmailId)
        {
            DataSet lstCabdetail = null;
            string proc_name = ConstantsDLL.usp_GetLatestRecords;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@UserCode", EmailId);
       //string Query = "select * from OnDemandRequests where OndemandRequestId=(select max(OndemandRequestId) from OnDemandRequests where EmailId='" + EmailId + "')";
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {

                lstCabdetail = db.ExecDataSetProc(proc_name,param);


            }
            return lstCabdetail;
        }

        public DataSet CheckRecords(string EmailId, int RouteId, DateTime RequestedDate)
        {
            DataSet lstCabdetail = null;
            string proc_name = ConstantsDLL.usp_CheckRecords;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@UserCode", EmailId);
            param[1] = new SqlParameter("@RouteId", RouteId);
            param[2] = new SqlParameter("@RequestedDate", RequestedDate);
            //string Query = "select * from OnDemandRequests where OndemandRequestId=(select max(OndemandRequestId) from OnDemandRequests where EmailId='" + EmailId + "')";
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {

                lstCabdetail = db.ExecDataSetProc(proc_name, param);


            }
            return lstCabdetail;
        }

        public bool RejectUserReq(string UserId, string ModifiedBy, string Comment)
        {
            string proc_name = ConstantsDLL.USP_REJECTUSERREQUEST;

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@OndemandRequestID", UserId);
            param[1] = new SqlParameter("@ModifiedBy", ModifiedBy);


            param[2] = new SqlParameter("@Comment", Comment);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }
        public bool ApproveUserRequest(string UserId, string ModifiedBy, string Comment)
        {
            string proc_name = ConstantsDLL.USP_APPROVEUSERREQUEST;

            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@OndemandRequestID", UserId);
            param[1] = new SqlParameter("@ModifiedBy", ModifiedBy);


            param[2] = new SqlParameter("@Comment", Comment);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

        public List<OnDemandRequest> GetRejectedUserDetails(string Emailid)
        {
            List<OnDemandRequest> lstCabdetail = null;
            string proc_name = ConstantsDLL.USP_GetRejectedUserDetails;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@UserCode", Emailid);


            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABDETAIL = ds.Tables[0];
                            lstCabdetail = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new OnDemandRequest
                            {
                                OndemandRequestId = Convert.ToInt32(Cabdetail["OndemandRequestId"].ToString()),
                                EmailId = Cabdetail["EmailId"].ToString(),
                                BookingType = Cabdetail["BookingType"].ToString(),
                                Gender = Cabdetail["Gender"].ToString(),
                                RouteId = Convert.ToInt32(Cabdetail["RouteId"].ToString()),
                                RequestedDate = Convert.ToDateTime(Cabdetail["RequestedDate"]).ToString("MMM dd,yyyy"),
                                RequestedTime = Cabdetail["RequestedTime"].ToString(),
                                Address = Cabdetail["Address"].ToString(),
                                RequestRemarks = Cabdetail["RequestRemarks"].ToString(),
                                IsApprovedStatus = Convert.ToInt32(Cabdetail["isapprovedstatus"]),


                            }).ToList();
                        }
                    }
                }
            }
            return lstCabdetail;

        }

        public bool UpdateRequest(OnDemandRequest Request)
        {
            string proc_name = ConstantsDLL.USP_UPDATEONDEMANDREQUEST;
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@OnDemandID", Request.OndemandRequestId);
            param[1] = new SqlParameter("@Approver", Request.Approver);
            param[2] = new SqlParameter("@Address", Request.Address);
         //   param[3] = new SqlParameter("@RequestedDate", Request.RequestedDate);

            param[3] = new SqlParameter("@RequestedDate", System.Data.SqlDbType.Date, 50);
            param[3].Value =Convert.ToDateTime(Request.RequestedDate);

            param[4] = new SqlParameter("@RequestedTime", Request.RequestedTime);
            param[5] = new SqlParameter("@ApproverRemarks", Request.RequestRemarks);
            param[6] = new SqlParameter("@RequestType", Request.RequestType);
           // param[7] = new SqlParameter("@RouteName", Request.RouteName);
            param[7] = new SqlParameter("@BookingType", Request.BookingType);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

        public bool CancelRequest(int RequestId)
        {
            string proc_name = ConstantsDLL.USP_CANCELONDEMANDREQUEST;
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@OnDemandID", RequestId);
          
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Repository.SqlHelper;
using System.Configuration;
using Infosys.CabManagement.Model;
using System.Data;
using System.Data.SqlClient;

namespace Infosys.CabManagement.Repository
{
    public class DriverDetailsDLL : IDisposable
    {
         SqlHelper.SqlHelper ObjSqlHelper;
        /// <summary>
        /// Set connection string
        /// </summary>
         public DriverDetailsDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }



        /// <summary>
        /// Method to Get List of Driver DETAIL
        /// </summary>
        /// <returns></returns>
        /// 

        public List<DriverDetail> GetDriverDetails(int DCID, bool ? IsActive)
        {
            List<DriverDetail> lstdriverdetails = null;
            string proc_name = ConstantsDLL.usp_GetDriverDetailsAccToDC;
            SqlParameter[] param = new SqlParameter[2];
            //if(DriverCode==string.Empty)
            //{
            //    param[0] = new SqlParameter("@DriverCode", null);
            //}
            //else
            //{
            //    param[0] = new SqlParameter("@DriverCode", DriverCode);
            //}
            
            param[0] = new SqlParameter("@DCID", DCID);
            param[1] = new SqlParameter("@IsActive", IsActive);
            



            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbDriverDetails = ds.Tables[0];
                            lstdriverdetails = tbDriverDetails.AsEnumerable().Select(DriverDetails => new DriverDetail
                            {
                                DriverId =Convert.ToInt32( DriverDetails["DriverId"].ToString()),
                                DriverCode = DriverDetails["DriverCode"].ToString(),
                                DriverName = DriverDetails["DriverName"].ToString(),
                                DCName= DriverDetails["DCName"].ToString(),
                                //EmpanelDate = (Convert.ToDateTime(DriverDetails["EmpanelDate"])).ToString("MMM dd,yyyy"),
                                //CreatedBy = DriverDetails["CreatedBy"].ToString(),
                                //ModifyDate = (Convert.ToDateTime(DriverDetails["ModifyDate"])).ToString("MMM dd,yyyy"),
                                //ModifyBy = DriverDetails["ModifyBy"].ToString(),
                                IsActive =Convert.ToBoolean(DriverDetails["IsActive"].ToString())
                                
                            }).ToList();
                        
                        }
                    }
                
                }
                return lstdriverdetails;
            
            }





        }

        public List<DriverDetail> GetDriverDetails(string DriverCode, bool? IsActive)
        {
            List<DriverDetail> lstdriverdetails = null;
            string proc_name = ConstantsDLL.USP_GetDriverDetails;
            SqlParameter[] param = new SqlParameter[2];
            if (DriverCode == string.Empty)
            {
                param[0] = new SqlParameter("@DriverCode", null);
            }
            else
            {
                param[0] = new SqlParameter("@DriverCode", DriverCode);
            }

            param[1] = new SqlParameter("@IsActive", IsActive);
        



            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbDriverDetails = ds.Tables[0];
                            lstdriverdetails = tbDriverDetails.AsEnumerable().Select(DriverDetails => new DriverDetail
                            {
                                DriverId = Convert.ToInt32(DriverDetails["DriverId"].ToString()),
                                DriverCode = DriverDetails["DriverCode"].ToString(),
                                DriverName = DriverDetails["DriverName"].ToString(),
                                DCName = DriverDetails["DCName"].ToString(),
                                EmpanelDate = (Convert.ToDateTime(DriverDetails["EmpanelDate"])).ToString("MMM dd,yyyy"),
                                CreatedBy = DriverDetails["CreatedBy"].ToString(),
                                //ModifyDate = (Convert.ToDateTime(DriverDetails["ModifyDate"])).ToString("MMM dd,yyyy"),
                                //ModifyBy = DriverDetails["ModifyBy"].ToString(),
                                IsActive = Convert.ToBoolean(DriverDetails["IsActive"].ToString())

                            }).ToList();

                        }
                    }

                }
                return lstdriverdetails;

            }





        }

        /// <summary>
        /// Method to Insert Driver DETAIL
        /// </summary>
        /// <returns></returns>
        /// 

        public Int32 InsertDriverDetail(DriverDetail DriverDetail)
        {
            
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            
            {
                new SqlParameter("@DriverName",SqlDbType.VarChar),
                new SqlParameter("@DriverCode", SqlDbType.Int), 
                new SqlParameter("@DCID", SqlDbType.Int),
                new SqlParameter("@EmpanelDate", SqlDbType.DateTime),    
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@IsActive", SqlDbType.Bit),
                new SqlParameter("@Rval", SqlDbType.Int), 
            };
            oPara[0].Value = DriverDetail.DriverName;
            oPara[0].Size = 155;
            oPara[1].Value = DriverDetail.DriverCode;
            oPara[1].Size = 155;
            oPara[2].Value = DriverDetail.DCID;
            oPara[2].Size = 255;
            oPara[3].Value = DriverDetail.EmpanelDate;
            oPara[2].Size = 255;
            oPara[4].Value = DriverDetail.CreatedBy;
            oPara[4].Size = 255;
            oPara[5].Value = DriverDetail.IsActive;
            oPara[5].Size = 255;
            oPara[6].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_InsertDriverDetails, oPara);
            return Convert.ToInt32(oPara[6].Value);
        
        }


        /// <summary>
        /// Method to Update Driver DETAIL
        /// </summary>
        /// <returns></returns>
        /// 
        public Int32 UpdateDriverDetail(DriverDetail DriverDetail)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            
            {
                new SqlParameter("@DriverId",SqlDbType.Int),
                new SqlParameter("@DriverName",SqlDbType.VarChar),
                new SqlParameter("@DriverCode", SqlDbType.Int), 
                new SqlParameter("@DCID", SqlDbType.Int),
                new SqlParameter("@EmpanelDate", SqlDbType.VarChar),    
                new SqlParameter("@ModifBy", SqlDbType.VarChar),
                new SqlParameter("@IsActive", SqlDbType.Bit),
                new SqlParameter("@Rval", SqlDbType.Int), 
            };
            oPara[0].Value = DriverDetail.DriverId;
            oPara[0].Size = 155;
            oPara[1].Value = DriverDetail.DriverName;
            oPara[1].Size = 155;
            oPara[2].Value = DriverDetail.DriverCode;
            oPara[2].Size = 155;
            oPara[3].Value = DriverDetail.DCID;
            oPara[3].Size = 255;
            oPara[4].Value = DriverDetail.EmpanelDate;
            oPara[4].Size = 255;
            oPara[5].Value = DriverDetail.ModifyBy;
            oPara[5].Size = 255;
            oPara[6].Value = DriverDetail.IsActive;
            oPara[6].Size = 255;
            oPara[7].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_UpdateDriverDetail, oPara);
            return Convert.ToInt32(oPara[7].Value);


        }

        /// <summary>
        /// Method to make ActiveInActive Driver
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public bool ActiveInactiveDriverDeatil(string DriverId, bool ActiveInactive, string ModifiedBy)
        {
            string proc_name = ConstantsDLL.USP_ActiveInactiveDriver;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@DriverId", DriverId);
            param[1] = new SqlParameter("@IsActive", ActiveInactive);
            param[2] = new SqlParameter("@ModifiedBy", ModifiedBy);
           

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
    }
}

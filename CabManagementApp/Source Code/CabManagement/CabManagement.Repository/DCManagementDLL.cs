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
    public class DCManagementDLL:IDisposable
    {
        SqlHelper.SqlHelper ObjSqlHelper;
        /// <summary>
        /// Set connection string
        /// </summary>
        public DCManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to get DC list 
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<DC> GetDCList()
        {
            List<DC> lstDC = null;
            string proc_name = ConstantsDLL.USP_GETDCLIST;
            
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, null))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbDCs = ds.Tables[0];
                            lstDC = tbDCs.AsEnumerable().Select(vendor => new DC
                            {
                                DCID = Convert.ToInt32(vendor["DCID"]),
                                DCName = Convert.ToString(vendor["DCName"]),
                                IsActive = Convert.ToInt32(vendor["IsActive"]),
                                CreatedDate = Convert.ToString(vendor["CreatedDate"]),
                                CreatedBy = Convert.ToString(vendor["CreatedBy"]),
                                ModifiedDate = Convert.ToString(vendor["ModifiedDate"]),
                                ModifiedBy = Convert.ToString(vendor["ModifiedBy"])

                            }).ToList();
                        }
                    }
                }
            }

            return lstDC;
        }

        #region IDisposable Members

        public void Dispose()
        {
            //Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion

        public List<DC> GetDCType()
        {
            throw new NotImplementedException();
        }

        public string UpdateDC(DC roledetail)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_UPDATEDC;
            SqlParameter[] param = new SqlParameter[5];

            param[0] = new SqlParameter("@DCId", roledetail.DCID);
            param[1] = new SqlParameter("@IsActive", roledetail.IsActive);
            param[2] = new SqlParameter("@ModifyBy", roledetail.ModifiedBy);
            param[3] = new SqlParameter("@DCName", roledetail.DCName);
            string Result = "";
            param[4] = new SqlParameter("@Result", SqlDbType.VarChar, 50, Result);
            param[4].Direction = ParameterDirection.Output;

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
          //  ObjSqlHelper.ExecNonQueryProc(proc_name, param);

            {
                db.ExecNonQueryProc(proc_name, param);
            }
            Result = Convert.ToString(param[4].Value);
            return Result;

           // return true;
        }

        public string InsertDC(DC roledetail)
        {
            string outResult = string.Empty;
            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_INSERTDC;
            SqlParameter[] param = new SqlParameter[4];

        
            param[0] = new SqlParameter("@DCName", roledetail.DCName);
            param[1] = new SqlParameter("@IsActive", roledetail.IsActive);
            param[2] = new SqlParameter("@CreatedBy", roledetail.CreatedBy);
            param[3] = new SqlParameter("@Result", outResult);
            param[3].Direction = ParameterDirection.Output;
            ObjSqlHelper.ExecNonQueryProc(proc_name, param);
            outResult = Convert.ToString(param[3].Value);

           // ObjSqlHelper.ExecNonQueryProc(proc_name, param);

            return outResult;
        }

        public bool DeleteDC(string DCId, bool IsActive, string Modifiedby)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_DELETEDC;
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@DCId", DCId);
            param[1] = new SqlParameter("@IsActive", IsActive);
            param[2] = new SqlParameter("@ModifyBy", Modifiedby);


            ObjSqlHelper.ExecNonQueryProc(proc_name, param);

            return true;
        }

        public int GetRoleid(string DCName)
        {
            throw new NotImplementedException();
        }
    }
}

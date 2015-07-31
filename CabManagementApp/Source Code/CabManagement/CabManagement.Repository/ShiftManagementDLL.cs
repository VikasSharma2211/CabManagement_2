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
    public class ShiftManagementDLL:IDisposable
    {
       public ShiftManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;           
        }
                
      
          public string  InsertShift(Shift shift)
        {
            string proc_name = ConstantsDLL.USP_INSERTSHIFTINFO;
         
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@ShiftType",shift.ShiftType);
            param[1] = new SqlParameter("@ShiftCategory", shift.ShiftCategory);
            param[2] = new SqlParameter("@ShiftTime", shift.ShiftTime);
            param[3] = new SqlParameter("@DCID",shift.DCID);
    
            param[4] = new SqlParameter("@CreatedBy", shift.CreatedBy);
            string Result = "";
            param[5] = new SqlParameter("@Result",SqlDbType.VarChar,50, Result);
            param[5].Direction = ParameterDirection.Output;
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            Result = Convert.ToString(param[5].Value);
            return Result;
           
        }   
    
        
        public string UpdateShift(Shift shift)
        {
            string proc_name = ConstantsDLL.USP_UPDATESHIFTINFO;
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@ShiftId", shift.ShiftId);
            param[1] = new SqlParameter("@ShiftCategory", shift.ShiftCategory);
            param[2] = new SqlParameter("@ShiftType",shift.ShiftType);
            param[3] = new SqlParameter("@ShiftTime",shift.ShiftTime);
            param[4] = new SqlParameter("@DCID", shift.DCID);            
            param[5] = new SqlParameter("@ModifiedBy",shift.ModifiedBy);
            string Result = "";
            param[6] = new SqlParameter("@Result", SqlDbType.VarChar, 50, Result);
            param[6].Direction = ParameterDirection.Output;

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            Result = Convert.ToString(param[6].Value);
            return Result;
        }

        public List<Shift> GetShiftList(Shift objShift)
        {
            List<Shift> lstShift = null;
            string proc_name = ConstantsDLL.USP_GETSHIFTINFO;
            SqlParameter[] param = new SqlParameter[4];
            if(objShift.ShiftId==0)
            {
                param[0] = new SqlParameter("@ShiftId", null);
            }
            else
            {
                param[0] = new SqlParameter("@ShiftId", objShift.ShiftId);
            }
            
            param[1] = new SqlParameter("@ShiftType", objShift.ShiftType);
            param[2] = new SqlParameter("@ShiftCategory", objShift.ShiftCategory);
            param[3] = new SqlParameter("@IsActive", objShift.IsActive);
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {

                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                    {
                        if (ds != null)
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                DataTable tbShift = ds.Tables[0];
                                lstShift = tbShift.AsEnumerable().Select(shift => new Shift
                                {
                                    ShiftId = Convert.ToInt32(shift["ShiftId"]),
                                    ShiftType = Convert.ToString(shift["ShiftType"]),
                                    ShiftCategory = Convert.ToString(shift["ShiftCategory"]),
                                    ShiftTime =DateTime.Parse(shift["ShiftTime"].ToString()).ToString("HH:mm"),
                                    DcName = Convert.ToString(shift["DCName"]),
                                    IsActive=Convert.ToBoolean(shift["IsActive"])
                                }).ToList();
                            }
                        }
                    }

            }
            return lstShift;
        }

        public bool Active_InactiveShift(string ShiftIds, bool IsActive, string ModifiedBy)
        {
            
            string proc_name = ConstantsDLL.USP_ACTIVEINACTIVESHIFT;
            
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@ShiftIds", ShiftIds);
            param[1] = new SqlParameter("@IsActive",IsActive);
           
            
            param[2] = new SqlParameter("@ModifiedBy",ModifiedBy);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

        public List<Shift> GetShiftListByDC(int DCId, string ShiftType, string RequestType)
        {
            List<Shift> lstShift = null;
            string proc_name = ConstantsDLL.USP_GETSHIFTDETAILBYDC;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@DCID", DCId);
            param[1] = new SqlParameter("@ShiftType", ShiftType);
            param[2] = new SqlParameter("@RequestType", RequestType);
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {

                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbShift = ds.Tables[0];
                            lstShift = tbShift.AsEnumerable().Select(shift => new Shift
                            {
                                ShiftId = Convert.ToInt32(shift["ShiftId"]),
                                ShiftCategory = Convert.ToString(shift["ShiftCategory"]),   //corrected by piyush
                                ShiftType = Convert.ToString(shift["ShiftType"]),
                                ShiftTime = DateTime.Parse(shift["ShiftTime"].ToString()).ToString("HH:mm"),
                             }).ToList();
                        }
                    }
                }

            }
            return lstShift;
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
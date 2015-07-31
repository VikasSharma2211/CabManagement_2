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
    public class VendorManagementDLL:IDisposable
    {
        SqlHelper.SqlHelper ObjSqlHelper;
        /// <summary>
        /// Set connection string
        /// </summary>
        public VendorManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to insert the details for creating new vendor
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public int InsertVendor(Vendor vendor)
        {
            //string proc_name = ConstantsDLL.USP_INSERTVENDOR;
            ObjSqlHelper = new SqlHelper.SqlHelper(); 
            SqlParameter[] param = 
        { 
             new SqlParameter("@VendorName",SqlDbType.VarChar),
             new SqlParameter("@Address",SqlDbType.VarChar),
             new SqlParameter("@City", SqlDbType.VarChar),
             new SqlParameter("@EmpanelDate",SqlDbType.Date),
             new SqlParameter("@DCID", SqlDbType.Int),
             new SqlParameter("@Comment",SqlDbType.VarChar),
             new SqlParameter("@CreatedBy",SqlDbType.VarChar),
             new SqlParameter("@rVal",SqlDbType.Int)
        };
            param[0].Value = vendor.VendorName;
            param[0].Size = 255;
            param[1].Value = vendor.Address;
            param[1].Size = 155;
            param[2].Value = vendor.City;
            param[2].Size = 255;
            param[3].Value = vendor.EmpanelDate;
            param[3].Size = 255;
            param[4].Value = vendor.DCID;
            param[4].Size = 155;
            param[5].Value = vendor.Comment;
            param[5].Size = 255;
            param[6].Value = vendor.CreatedBy;
            param[6].Size = 255;            
            param[7].Direction = ParameterDirection.ReturnValue;

            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_INSERTVENDOR, param);
            //using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            //{
            //    db.ExecNonQueryProc(proc_name, param);
            //}            
            //return true;
            return Convert.ToInt32(param[7].Value);
        }   
    
        /// <summary>
        /// Method to make modification in vendor
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public Int32 UpdateVendor(Vendor vendor)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            { 
                new SqlParameter("@VendorID", SqlDbType.Int), 
                new SqlParameter("@VendorName", SqlDbType.VarChar), 
                new SqlParameter("@Address", SqlDbType.VarChar),
                new SqlParameter("@City", SqlDbType.VarChar),
                new SqlParameter("@EmpanelDate",SqlDbType.VarChar),
                new SqlParameter("@DCID", SqlDbType.Int),
                new SqlParameter("Comment",SqlDbType.VarChar),
                new SqlParameter("ModifiedBy",SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };
            oPara[0].Value = vendor.VendorID;
            oPara[0].Size = 155;
            oPara[1].Value = vendor.VendorName.Trim();
            oPara[1].Size = 155;
            oPara[2].Value = vendor.Address;
            oPara[2].Size = 255;
            oPara[3].Value = vendor.City;
            oPara[3].Size=255;
            oPara[4].Value = vendor.EmpanelDate;
            oPara[4].Size = 255;
            oPara[5].Value = vendor.DCID;
            oPara[5].Size = 255;
            oPara[6].Value = vendor.Comment;
            oPara[6].Size = 255;
            oPara[7].Value = vendor.ModifiedBy;
            oPara[7].Size = 255;

            oPara[8].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_UPDATEVENDOR, oPara);
            return Convert.ToInt32(oPara[8].Value);
        }
            

        /// <summary>
        /// Method to active or deactivate the vendor with comment option
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <param name="IsActiveComment"></param>
        /// <param name="ModifiedBy"></param>
        /// <returns></returns>
        public bool Active_InactiveVendor(string VendorIds,bool IsActive,string IsActiveComment,string ModifiedBy)
        {
            string proc_name = ConstantsDLL.USP_ACTIVEINACTIVEVENDOR;
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@VendorIDs",VendorIds);
            param[1] = new SqlParameter("@IsActive",IsActive);
            param[2] = new SqlParameter("@IsActiveComment", IsActiveComment);
            param[3] = new SqlParameter("@ModifiedBy", ModifiedBy);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

        /// <summary>
        /// Method to get vendor list by their status
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<Vendor> GetVendorList(Int32? VendorId, bool? IsActive)
        {
            List<Vendor> lstVendor = null;
            string proc_name = ConstantsDLL.USP_GETVENDORLIST;
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@VendorID", VendorId);
            param[1] = new SqlParameter("@IsActive", IsActive);
            
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if(ds.Tables[0].Rows.Count>0)
                        {
                        DataTable tbVendor = ds.Tables[0];
                        lstVendor = tbVendor.AsEnumerable().Select(vendor => new Vendor
                        {
                            VendorID = Convert.ToInt32(vendor["VendorID"]),
                            VendorName = Convert.ToString(vendor["VendorName"]),
                            Address = Convert.ToString(vendor["Address"]),
                            City = Convert.ToString(vendor["City"]),
                            EmpanelDate = (Convert.ToDateTime(vendor["EmpanelDate"])).ToString("MMM dd,yyyy"),
                            DCName = Convert.ToString(vendor["DCName"]),
                            Comment = Convert.ToString(vendor["Comment"]),
                            CreatedBy = Convert.ToString(vendor["CreatedBy"]),
                            CreatedDate = Convert.ToDateTime(vendor["CreatedDate"]),
                            IsActive = Convert.ToBoolean(vendor["IsActive"])
                        }).ToList();
                        }
                    }                   
                }
            }

            return lstVendor;
        }

        public List<Vendor> GetVendorList(Int32? VendorId, bool? IsActive,int DCID)
        {
            List<Vendor> lstVendor = null;
            string proc_name = ConstantsDLL.USP_GETVENDORLISTACCTODC;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@VendorID", VendorId);
            param[1] = new SqlParameter("@IsActive", IsActive);
            param[2] = new SqlParameter("@DCID", DCID);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, param))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbVendor = ds.Tables[0];
                            lstVendor = tbVendor.AsEnumerable().Select(vendor => new Vendor
                            {
                                VendorID = Convert.ToInt32(vendor["VendorID"]),
                                VendorName = Convert.ToString(vendor["VendorName"]),
                                IsActive = Convert.ToBoolean(vendor["IsActive"])
                            }).ToList();
                        }
                    }
                }
            }

            return lstVendor;
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

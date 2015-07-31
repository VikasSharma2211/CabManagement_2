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
using System.ComponentModel;
using System.Globalization;

namespace Infosys.CabManagement.Repository
{
    public class RoleManagementDLL : IDisposable
    {

       SqlHelper.SqlHelper ObjSqlHelper;
        /// <summary>
        /// Set connection string
        /// </summary>
       public RoleManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }
       /// <summary>
       /// Method to get RoleType
       /// </summary>
       /// <param name="RoleId"></param>
       /// <param name="RoleName"></param>
       /// <returns></returns>
       public List<RoleType> GetRoleType()
       {
           List<RoleType> lstroletype = null;
           string proc_name = ConstantsDLL.USP_GETROLETYPE;

           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, null))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbRoleType = ds.Tables[0];
                           lstroletype = tbRoleType.AsEnumerable().Select(roletype => new RoleType
                           {
                               RoleTypeId = Convert.ToInt32(roletype["RoleTypeId"]),
                               RoleTypes = Convert.ToString(roletype["RoleType"])
                           }).ToList();
                       }
                   }
               }
           }

           return lstroletype;
       }


       /// <summary>
       /// Method to get RoleDetail
       /// </summary>
       /// <returns></returns>

       public List<RoleDetail> GetRoleDetail()
       {
           List<RoleDetail> lstroledetail = null;
           string proc_name = ConstantsDLL.USP_GETROLEDETAIL;

           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, null))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbRoleDeatil = ds.Tables[0];
                           lstroledetail = tbRoleDeatil.AsEnumerable().Select(roledetail => new RoleDetail
                           {
                               RoleId = Convert.ToInt32(roledetail["RoleId"]),
                               RoleName = Convert.ToString(roledetail["RoleName"]),
                               RoleAccess = Convert.ToString(roledetail["RoleAccess"]),
                               CreatedDate = Convert.ToString(roledetail["CreatedDate"]),
                               CreatedBy = Convert.ToString(roledetail["CreatedBy"]),
                               ModifiedDate = Convert.ToString(roledetail["ModifiedDate"]),
                               ModifiedBy = Convert.ToString(roledetail["ModifiedBy"]),
                               IsActive = Convert.ToBoolean(roledetail["IsActive"])
                           }).ToList();
                       }
                   }
               }
           }

           return lstroledetail;
       }


       /// <summary>
       /// Method to insert RoleDetail
       /// </summary>
       /// <returns></returns>
        public Int32 InsertRole(RoleDetail roledetail)
       {
           ObjSqlHelper = new SqlHelper.SqlHelper();
           
           SqlParameter[] param = 
            { 
                new SqlParameter("@RoleName",SqlDbType.VarChar), 
                new SqlParameter("@RoleAccess", SqlDbType.VarChar), 
                new SqlParameter("@IsActive", SqlDbType.Bit),
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };

           param[0].Value = roledetail.RoleName;
           param[0].Size = 255;
           param[1].Value = roledetail.RoleAccess;
           param[1].Size = 155;
           param[2].Value = roledetail.IsActive;
           param[2].Size = 255;
           param[3].Value = roledetail.CreatedBy;
           param[3].Size = 155;
           param[4].Direction = ParameterDirection.ReturnValue;
           
           //string proc_name = ConstantsDLL.USP_INSERTROLE;
           //SqlParameter[] param = new SqlParameter[4];

           //param[0] = new SqlParameter("@RoleName", roledetail.RoleName);
           //param[1] = new SqlParameter("@RoleAccess", roledetail.RoleAccess);
           //param[2] = new SqlParameter("@IsActive", roledetail.IsActive);
           //param[3] = new SqlParameter("@CreatedBy", roledetail.CreatedBy);

           //ObjSqlHelper.ExecNonQueryProc(proc_name, param);
           ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_INSERTROLE, param);
           return Convert.ToInt32(param[4].Value);

       }

        /// <summary>
        /// Method to ActiveInactive RoleDetail
        /// </summary>
        /// <returns></returns>

        public bool UpdateRole(RoleDetail roledetail)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_UPDATEROLE;
            SqlParameter[] param = new SqlParameter[5];

            param[0] = new SqlParameter("@RoleId", roledetail.RoleId);
            param[1] = new SqlParameter("@IsActive", roledetail.IsActive);
            param[2] = new SqlParameter("@ModifyBy", roledetail.ModifiedBy);
            param[3] = new SqlParameter("@RoleName", roledetail.RoleName);
            param[4] = new SqlParameter("@RoleAccess", roledetail.RoleAccess);
            ObjSqlHelper.ExecNonQueryProc(proc_name, param);

            return true;


           
        }



        /// <summary>
        /// Method to Delete RoleDetail
        /// </summary>
        /// <returns></returns>

        public bool DeleteRole(string RoleId, bool IsActive, string Modifiedby)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_ACTIVEINACTIVEROLE;
            SqlParameter[] param = new SqlParameter[3];

            param[0] = new SqlParameter("@RoleId", RoleId);
            param[1] = new SqlParameter("@IsActive", IsActive);
            param[2] = new SqlParameter("@ModifyBy", Modifiedby);
           

            ObjSqlHelper.ExecNonQueryProc(proc_name, param);

            return true;
        }


        /// <summary>
        /// Method to Get RoleAcess Id
        /// </summary>
        /// <returns></returns>

        public Int32 GetRoleid(string RoleName)
        {
            Int32 RoleId=0;

            ObjSqlHelper = new SqlHelper.SqlHelper();


            string proc_name = ConstantsDLL.USP_GETROLEID;
            SqlParameter[] param = new SqlParameter[2];

            param[0] = new SqlParameter("@RoleName", RoleName);
            param[1] = new SqlParameter("@RoleId", RoleId);
            param[1].Direction = ParameterDirection.Output;

            ObjSqlHelper.ExecNonQueryProc(proc_name, param);
            RoleId = Convert.ToInt32((param[1].Value));
            return RoleId;

       

          
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

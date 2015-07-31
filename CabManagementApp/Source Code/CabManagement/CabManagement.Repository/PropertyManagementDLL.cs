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
    public class PropertyManagementDLL : IDisposable
    {
        SqlHelper.SqlHelper ObjSqlHelper;
         /// <summary>
        /// Set connection string
        /// </summary>
        public PropertyManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

       public Int32 InsertCabProperty(CabProperty property)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper(); 
            SqlParameter[] param = 
            { 
                new SqlParameter("@PropertyName",SqlDbType.VarChar), 
                new SqlParameter("@IsCompulsory", SqlDbType.Bit), 
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };

            param[0].Value = property.PropertyName;
            param[0].Size = 255;
            param[1].Value = property.IsCompulsory;
            param[1].Size = 155;
            param[2].Value = property.CreatedBy;
            param[2].Size = 255;
            param[3].Direction = ParameterDirection.ReturnValue;
            //param[0] = new SqlParameter("@PropertyName",property.PropertyName);
            //param[1] = new SqlParameter("@IsCompulsory", property.IsCompulsory);
            //param[2] = new SqlParameter("@CreatedBy", property.CreatedBy);
           
           ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_INSERTPROPERTY, param);
           //string proc_name = ConstantsDLL.USP_INSERTPROPERTY;
           // using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           // {
           //     db.ExecNonQueryProc(proc_name, param);
           // }
            return Convert.ToInt32(param[3].Value);
        }

       public bool UpdateCabProperty(CabProperty property)
        {
            string proc_name = ConstantsDLL.USP_UPDATEPROPERTY;
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@PropertyID", property.PropertyId);
            param[1] = new SqlParameter("@PropertyName", property.PropertyName);
            param[2] = new SqlParameter("@IsCompulsory", property.IsCompulsory);
            param[3] = new SqlParameter("@ModifiedBy", property.ModifiedBy);
            
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

       public bool Active_InactiveProperty(string PropertyIDs, bool IsActive, string ModifiedBy)
        {
            string proc_name = ConstantsDLL.USP_ACTIVEINACTIVEPROPERTY;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@PropertyIDs", @PropertyIDs);
            param[1] = new SqlParameter("@IsActive", IsActive);
            param[2] = new SqlParameter("@ModifiedBy", ModifiedBy);

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                db.ExecNonQueryProc(proc_name, param);
            }
            return true;
        }

       /// <summary>
       /// Method to get CabProperty
       /// </summary>
       public List<CabProperty> GetCabProperty(int? PropertyId, bool? IsActive)
       {
           List<CabProperty> lstgetcabproperty = null;
           string proc_name = ConstantsDLL.USP_GETCABPROPERTY;

           SqlParameter[] param = new SqlParameter[2];
           param[0] = new SqlParameter("@PropertyId", PropertyId);
           param[1] = new SqlParameter("@IsActive", IsActive);
           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, param))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbCabProperty = ds.Tables[0];
                           lstgetcabproperty = tbCabProperty.AsEnumerable().Select(cabProperty => new CabProperty
                           {
                               PropertyId = Convert.ToInt32(cabProperty["PropertyId"]),
                               PropertyName = Convert.ToString(cabProperty["PropertyName"]),
                               IsCompulsory = Convert.ToBoolean(cabProperty["IsCompulsory"]),
                               IsActive = Convert.ToBoolean(cabProperty["IsActive"]),
                               CreatedBy = Convert.ToString(cabProperty["CreatedBy"])
                           }).ToList();

                       }

                   }

               }
           }

           return lstgetcabproperty;

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

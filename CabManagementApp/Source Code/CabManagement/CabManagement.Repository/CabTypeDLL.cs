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
     public class CabTypeDLL:IDisposable
    {

          /// <summary>
        /// Set connection string
        /// </summary>
         public CabTypeDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to get CabType
        /// </summary>
        /// <param name="CabName"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
         public List<CabType> CABTYPELIST( bool? IsActive)
        {
            List<CabType> lstcabtype = null;
            string proc_name = ConstantsDLL.USP_GETCABTYPE;
            
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, null))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABTYPE = ds.Tables[0];
                            lstcabtype = tbCABTYPE.AsEnumerable().Select(Cabtype => new CabType 
                            {

                                CABNAME = Convert.ToString(Cabtype["CABNAME"])
                                
                            }).ToList();
                        }
                    }
                }
            }

            return lstcabtype;
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

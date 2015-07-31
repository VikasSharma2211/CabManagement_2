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
 public  class  CabCapacityDLL:IDisposable
    {
           /// <summary>
        /// Set connection string
        /// </summary>
        public CabCapacityDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to get CabCapacity
        /// </summary>
       
        /// <returns></returns>

        public List<CabCapacity > CABTYPELIST()
        {
            List<CabCapacity > lstcabcapacity = null;
            string proc_name = ConstantsDLL.usp_GETCABCAPACITY ;

            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, null))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABCPC = ds.Tables[0];
                            lstcabcapacity = tbCABCPC.AsEnumerable().Select(CabCpcty => new CabCapacity
                            {

                                capacity = Convert.ToString(CabCpcty["cabcapacity"])

                            }).ToList();
                        }
                    }
                }
            }

            return lstcabcapacity;
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

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
   public  class CabPropertyDLL:IDisposable
    {
        /// <summary>
        /// Set connection string
        /// </summary>
       public CabPropertyDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to get CabProperty
        /// </summary>

       public List<CabProperty> GetCabProperty()
       {
           List<CabProperty> lstgetcabproperty = null;
           string proc_name = ConstantsDLL.USP_GETCABPROPERTY;
           using(SqlHelper.SqlHelper db=new SqlHelper.SqlHelper() )
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, null))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbCabProperty = ds.Tables[0];
                           lstgetcabproperty = tbCabProperty.AsEnumerable().Select(cabProperty => new CabProperty {

                               PropertyId = Convert.ToInt32(cabProperty["PropertyId"]),
                               PropertyName = Convert.ToString(cabProperty["PropertyName"]),
                               IsCompulsory=Convert.ToBoolean(cabProperty["IsCompulsory"])
                           
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

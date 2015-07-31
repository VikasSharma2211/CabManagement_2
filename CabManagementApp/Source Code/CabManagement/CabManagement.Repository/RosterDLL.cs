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
   public class RosterDLL : IDisposable
    {   
        
         /// <summary>
        /// Set connection string
        /// </summary>
       public RosterDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

       /// <summary>
       /// Method to get Backend Record For Validate Roster
       /// </summary>
       /// <returns></returns>

       public DataSet  RecordForValidateRoster()
       {
           DataSet RecordForValidateDS = new DataSet();
           string proc_name = ConstantsDLL.USP_GETRECORDFORROSTER;

           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, null))
               {
                   if (ds != null)
                   {
                       
                           RecordForValidateDS = ds;
                       
                   }
               }
           
           
           }

           return RecordForValidateDS;

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

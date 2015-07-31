using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;
using System.Data;

namespace Infosys.CabManagement.Business
{
    public class RosterBLL : IDisposable
    {
        /// <summary>
        /// To Get REcord For Validate Roster
        /// </summary>
       /// <returns></returns>
        public DataSet GetReocrdForValidateRoster()
        {

            DataSet recordDS;
            RosterDLL objRosterDLL = null;
            try
            {
                recordDS = new DataSet();
                objRosterDLL = new RosterDLL();
                recordDS = objRosterDLL.RecordForValidateRoster();

            }
            catch(Exception ex)
            { 
                throw;
            }
            finally
            {
                objRosterDLL = null;

            }
            return recordDS;

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

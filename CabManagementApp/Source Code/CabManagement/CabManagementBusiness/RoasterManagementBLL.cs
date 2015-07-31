using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class RoasterManagementBLL:IDisposable
    {
        public bool InsertRoasterDetail(RoasterManagement RoasterManagement)
        {
            bool isFlag = false;
            RoasterManagementDLL objRoasterManagementDLL = null;
            try
            {
                objRoasterManagementDLL = new RoasterManagementDLL();
                isFlag = objRoasterManagementDLL.InsertRosterDetail(RoasterManagement);
            }
            catch(Exception ex)
            {
                throw;
            }
            finally
            {
                objRoasterManagementDLL = null;
            }
            return isFlag;
        }

        public bool CreateRoasterNo(string Prifix, out string roosternumber)
        {
            bool isFlag = false;
            RoasterManagementDLL objRoasterManagementDLL = null;
            string roosternumberr = string.Empty;
            try
            {
                objRoasterManagementDLL = new RoasterManagementDLL();
              
                isFlag = objRoasterManagementDLL.CreateRoaster(Prifix, out roosternumberr);

            }
            catch(Exception ex)
            {
                objRoasterManagementDLL = null;
                throw ex;

            }
            roosternumber = roosternumberr;
            return isFlag;
        }


        #region IDisposable Members

        public void Dispose()
        {
            //Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion

        public List<Roster> GetRoasterDetail(string Prefix)
        {
            RoasterManagementDLL objRoasterManagementDLL = null;

            List<Roster> RosterDetail = null;
            try
            {
                objRoasterManagementDLL = new RoasterManagementDLL();

            RosterDetail= objRoasterManagementDLL.GetRoasterDetail(Prefix);
  

            }
            
            catch (Exception ex)
            {
                objRoasterManagementDLL = null;
            }

            return RosterDetail;

        }

        public bool UpdateRoasterDetail(RoasterManagement RoasterManagement)
        {
            bool isFlag = false;
            RoasterManagementDLL objRoasterManagementDLL = null;
            try
            {
                objRoasterManagementDLL = new RoasterManagementDLL();
                isFlag = objRoasterManagementDLL.UpdateRosterDetail(RoasterManagement);
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                objRoasterManagementDLL = null;
            }
            return isFlag;
        }

        public void GetRoosterWiseRecords(List<string> roosterNumbers)
        {
            
            RoasterManagementDLL objRoasterManagementDLL = null;
            try
            {
                objRoasterManagementDLL = new RoasterManagementDLL();
                objRoasterManagementDLL.GetRoosterWiseRecords(roosterNumbers);
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                objRoasterManagementDLL = null;
            }
        }
    }
}

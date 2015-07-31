using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class DriverDetailsBLL : IDisposable
    { 
        
        /// <summary>
        /// To Get Driver list by their status
        /// </summary>
        /// <param name="DriverCode"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>

        public List<DriverDetail > GetDriverList(int DCID, bool? IsActive)
        {
            List<DriverDetail> lstDriverDetail = null;
            try
            {
                using (DriverDetailsDLL driverDetailDLL = new DriverDetailsDLL())
                {
                    lstDriverDetail = driverDetailDLL.GetDriverDetails(DCID, IsActive);
                }
                return lstDriverDetail;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To Insert Driver list
        /// </summary>
        /// <param name="DriverCode"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<DriverDetail> GetDriverList(string DriverCode, bool? IsActive)
        {
            List<DriverDetail> lstDriverDetail = null;
            try
            {
                using (DriverDetailsDLL driverDetailDLL = new DriverDetailsDLL())
                {
                    lstDriverDetail = driverDetailDLL.GetDriverDetails(DriverCode, IsActive);
                }
                return lstDriverDetail;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Int32 InsertDriverDetail(DriverDetail DriverDetail)
        {
            int outResult = 0;
            DriverDetailsDLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsDLL();
                outResult = objDriverDetail.InsertDriverDetail(DriverDetail);
            }
            catch
            {
                throw;
            }
            return outResult;
        }

        /// <summary>
        /// To Update  Driver 
        /// </summary>
        /// <param name="DriverCode"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>

        public Int32 UpdateDriverDetail(DriverDetail DriverDetail)
        {
            Int32 outResult = 0;
            DriverDetailsDLL objDriverDetail = null;
            try
            {
                objDriverDetail = new DriverDetailsDLL();
                outResult = objDriverDetail.UpdateDriverDetail(DriverDetail);
            }
            catch
            {
                throw;
            }
            return outResult;



        }


        public bool ActiveInactiveDriver(string DriverId, bool ActiveInactive, string ModifiedBy)
        {
            bool isFlag = false;
            DriverDetailsDLL objDriverDetailDLL = null;
            try
            {
                objDriverDetailDLL = new DriverDetailsDLL();

                isFlag = objDriverDetailDLL.ActiveInactiveDriverDeatil(DriverId, ActiveInactive, ModifiedBy);

                return isFlag;
            }
            catch (Exception e)
            {

                throw;
            }
            finally
            {
                objDriverDetailDLL = null;
            }

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

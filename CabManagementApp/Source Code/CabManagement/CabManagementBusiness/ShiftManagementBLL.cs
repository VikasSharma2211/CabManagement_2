using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class ShiftManagementBLL : IDisposable
    {
        /// <summary>
        /// To insert a new shift
        /// </summary>
        /// <param name="shift"></param>
        /// <returns></returns>
        public string InsertShift(Shift shift)
        {
            string  OutResult ="";
            try
            {
                using (ShiftManagementDLL shiftManagementDLL = new ShiftManagementDLL())
                {
                    OutResult = shiftManagementDLL.InsertShift(shift);
                }
                return OutResult;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// to update details in shift
        /// </summary>
        /// <param name="shift"></param>
        /// <returns></returns>
        public string UpdateShift(Shift shift)
        {
            string isFlag = string.Empty;
            try
            {
                using (ShiftManagementDLL shiftManagementDLL = new ShiftManagementDLL())
                {
                    isFlag = shiftManagementDLL.UpdateShift(shift);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To active or inactive the shift
        /// </summary>
        /// <param name="ShiftId"></param>
        /// <param name="IsActive"></param>
        /// <param name="ModifiedBy"></param>
        /// <returns></returns>
        public bool Active_InactiveShift(string ShiftIds, bool IsActive, string ModifiedBy)
        {
            bool isFlag = false;
            try
            {
                using (ShiftManagementDLL shiftManagementDLL = new ShiftManagementDLL())
                {
                    isFlag = shiftManagementDLL.Active_InactiveShift(ShiftIds, IsActive, ModifiedBy);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To Get shift list 
        /// </summary>
        /// <returns></returns>
        public List<Shift> GetShiftList(Shift objShift)
        {
            List<Shift> lstShift = null;
            try
            {
                using (ShiftManagementDLL shiftManagementDLL = new ShiftManagementDLL())
                {
                    lstShift = shiftManagementDLL.GetShiftList(objShift);
                }
                return lstShift;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To Get shift list 
        /// </summary>
        /// <returns></returns>
        public List<Shift> GetShiftListByDC(int DCId,string ShiftType,string RequestType)
        {
            List<Shift> lstShift = null;
            try
            {
                using (ShiftManagementDLL shiftManagementDLL = new ShiftManagementDLL())
                {
                    lstShift = shiftManagementDLL.GetShiftListByDC(DCId,ShiftType,RequestType);
                }
                return lstShift;
            }
            catch
            {
                throw;
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




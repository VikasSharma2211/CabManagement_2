using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class VendorManagementBLL : IDisposable
    {
        /// <summary>
        /// To insert a new vendor
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public Int32 InsertVendor(Vendor vendor)
        {
            int isFlag = 0;
            try
            {                
                using (VendorManagementDLL vendorManagementDLL = new VendorManagementDLL())
                {
                    isFlag = vendorManagementDLL.InsertVendor(vendor);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }           
        }

        /// <summary>
        /// to update details in vendor
        /// </summary>
        /// <param name="vendor"></param>
        /// <returns></returns>
        public Int32 UpdateVendor(Vendor vendor)
        {
            Int32 isFlag = 0;
            try
            {
                using (VendorManagementDLL vendorManagementDLL = new VendorManagementDLL())
                {
                    isFlag = vendorManagementDLL.UpdateVendor(vendor);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }            
        }

        /// <summary>
        /// To active or inactive the vendor
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <param name="IsActiveComment"></param>
        /// <param name="ModifiedBy"></param>
        /// <returns></returns>
        public bool Active_InactiveVendor(string VendorIds, bool IsActive, string IsActiveComment, string ModifiedBy)
        {
            bool isFlag = false;
            try
            {
                using (VendorManagementDLL vendorManagementDLL = new VendorManagementDLL())
                {
                    isFlag = vendorManagementDLL.Active_InactiveVendor(VendorIds,IsActive,IsActiveComment,ModifiedBy);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }            
        }

        /// <summary>
        /// To Get vendor list by their status
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<Vendor> GetVendorList(Int32? VendorId, bool? IsActive)
        {
            List<Vendor> lstVendor = null;
            try
            {
                using (VendorManagementDLL vendorManagementDLL = new VendorManagementDLL())
                {
                    lstVendor = vendorManagementDLL.GetVendorList(VendorId, IsActive);
                }
                return lstVendor;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// To Get vendor list by their status
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<Vendor> GetVendorList(Int32? VendorId, bool? IsActive,int DCID)
        {
            List<Vendor> lstVendor = null;
            try
            {
                using (VendorManagementDLL vendorManagementDLL = new VendorManagementDLL())
                {
                    lstVendor = vendorManagementDLL.GetVendorList(VendorId, IsActive,DCID);
                }
                return lstVendor;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// Method to get all DC list
        /// </summary>
        /// <param name="VendorId"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
        public List<DC> GetDCList()
        {
            List<DC> lstDC = null;
            try
            {
                using (DCManagementDLL dcManagementDLL = new DCManagementDLL())
                {
                    lstDC = dcManagementDLL.GetDCList();
                }
                return lstDC;
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

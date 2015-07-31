
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class PropertyManagementBLL : IDisposable
    {
        public Int32 InsertCabProperty(CabProperty property)
        {
            int isFlag = 0;
            try
            {
                using (PropertyManagementDLL propertyManagementDLL = new PropertyManagementDLL())
                {
                    isFlag = propertyManagementDLL.InsertCabProperty(property);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }
        }

        public bool UpdateCabProperty(CabProperty property)
        {
            bool isFlag = false;
            try
            {
                using (PropertyManagementDLL propertyManagementDLL = new PropertyManagementDLL())
                {
                    isFlag = propertyManagementDLL.UpdateCabProperty(property);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }
        }

        public bool Active_InactiveCabProperty(string propertyIds, bool IsActive, string ModifiedBy)
        {
            bool isFlag = false;
            try
            {
                using (PropertyManagementDLL propertyManagementDLL = new PropertyManagementDLL())
                {
                    isFlag = propertyManagementDLL.Active_InactiveProperty(propertyIds, IsActive, ModifiedBy);
                }
                return isFlag;
            }
            catch
            {
                throw;
            }
        }

        public List<CabProperty> GetCabPropertyList(Int32? propertyId, bool? IsActive)
        {
            List<CabProperty> lstproperty = null;
            try
            {
                using (PropertyManagementDLL propertyManagementDLL = new PropertyManagementDLL())
                {
                    lstproperty = propertyManagementDLL.GetCabProperty(propertyId, IsActive);
                }
                return lstproperty;
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

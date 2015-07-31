using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class DCManagementBLL : IDisposable
    {
        /// <summary>
        /// Method to get DCType
        /// </summary>
        /// <param name="RoleId"></param>
        /// <param name="RoleName"></param>
        /// <returns></returns>
        public List<DC> GetDCType()
        {
            List<DC> lstroletype = null;
            DCManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new DCManagementDLL();
                lstroletype = objrolemanagement.GetDCType();
                return lstroletype;
            }
            catch (Exception eu)
            {
                throw;
            }
            finally
            {
                lstroletype = null;
                objrolemanagement = null;
            }
        }

        /// <summary>
        /// Method to get DCDetail
        /// </summary>
        /// <returns></returns>
        public List<DC> GetDCDetail()
        {
            List<DC> lstroledetail = null;
            DCManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new DCManagementDLL();
                lstroledetail = objrolemanagement.GetDCList();
                return lstroledetail;

            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objrolemanagement = null;
                lstroledetail = null;
            }

        }

        /// <summary>
        /// Method to Insert DC
        /// </summary>

        /// <returns></returns>
        public string InsertDC(DC roledetail)
        {
            //bool isFlag = false;
            string outResult = string.Empty;
            DCManagementDLL objrolemanagement = null;

            try
            {
                objrolemanagement = new DCManagementDLL();
                outResult = objrolemanagement.InsertDC(roledetail);
                return outResult;

            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objrolemanagement = null;

            }
        }

        /// <summary>
        /// Method to Update DC
        /// </summary>
        /// <returns></returns>
        public string UpdateDC(DC roledetail)
        {
            string isFlag = string.Empty;
          //  bool isFlag = false;
            DCManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new DCManagementDLL();
                isFlag = objrolemanagement.UpdateDC(roledetail);
                return isFlag;

            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objrolemanagement = null;

            }

        }

        /// <summary>
        /// Method to Delete DC
        /// </summary>

        /// <returns></returns>
        public bool DeleteDC(string DCId, bool IsActive, string Modifiedby)
        {
            bool isFlag = false;
            DCManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new DCManagementDLL();
                isFlag = objrolemanagement.DeleteDC(DCId, IsActive, Modifiedby);
                return isFlag;

            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objrolemanagement = null;

            }

        }

        public Int32 GetRoleId(string DCName)
        {
            Int32 DCId;
            DCManagementDLL objRoleManagementDll = null;
            try
            {
                objRoleManagementDll = new DCManagementDLL();
                DCId = objRoleManagementDll.GetRoleid(DCName);
                return DCId;
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objRoleManagementDll = null;
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

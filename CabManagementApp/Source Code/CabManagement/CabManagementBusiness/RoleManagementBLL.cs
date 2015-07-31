using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class RoleManagementBLL : IDisposable
    {

        /// <summary>
        /// Method to get RoleType
        /// </summary>
        /// <param name="RoleId"></param>
        /// <param name="RoleName"></param>
        /// <returns></returns>
        public List<RoleType> GetRoleType()
        {
            List<RoleType> lstroletype = null;
            RoleManagementDLL objrolemanagement = null;
            try 
            {
                objrolemanagement = new RoleManagementDLL();
                lstroletype = objrolemanagement.GetRoleType();
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
        /// Method to get RoleDetail
        /// </summary>
       
        /// <returns></returns>

        public List<RoleDetail> GetRoleDetail()
        {
            List<RoleDetail> lstroledetail = null;
            RoleManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new RoleManagementDLL();
                lstroledetail = objrolemanagement.GetRoleDetail();
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
        /// Method to Insert Role
        /// </summary>

        /// <returns></returns>


        public int InsertRole(RoleDetail roledetail)
        {
            int isFlag = 0;
            RoleManagementDLL objrolemanagement = null;

            try
            {
                objrolemanagement = new RoleManagementDLL();
                isFlag = objrolemanagement.InsertRole(roledetail);
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
        /// Method to Update Role
        /// </summary>

        /// <returns></returns>

        public bool UpdateRole(RoleDetail roledetail)
        {
            bool isFlag = false;
            RoleManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new RoleManagementDLL();
                isFlag = objrolemanagement.UpdateRole(roledetail);
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
        /// Method to Delete Role
        /// </summary>

        /// <returns></returns>

        public bool DeleteRole(string RoleId,bool IsActive,string Modifiedby)
        {
            bool isFlag = false;
            RoleManagementDLL objrolemanagement = null;
            try
            {
                objrolemanagement = new RoleManagementDLL();
                isFlag = objrolemanagement.DeleteRole(RoleId,IsActive ,Modifiedby );
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


        public Int32 GetRoleId(string RoleName)
        {
            Int32 RoleId;
            RoleManagementDLL objRoleManagementDll = null;
            try
            {
                objRoleManagementDll = new RoleManagementDLL();
                RoleId = objRoleManagementDll.GetRoleid(RoleName);
                return RoleId;
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

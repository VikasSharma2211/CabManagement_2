using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
  public   class CabManagementBLL :IDisposable 
    {
        /// <summary>
        /// To Get Cab Type list by their status
        /// </summary>
        /// <param name="Cabname"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>

        public List<CabType > GetCABTYPE( bool? IsActive)
        {
            List<CabType > lstcabtype = null;
            try
            {
                using (CabManagementDLL cabtypedll = new CabManagementDLL())
                {
                    lstcabtype = cabtypedll.GetCabTypeList(IsActive);
                }
                return lstcabtype;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To Get Cab Capacity list
        /// </summary>
        /// <returns></returns>

        public List<CabCapacity > GetCABCAPCITY()
        {
            List<CabCapacity> lstcabcapacity = null;
            try
            {
                using (CabManagementDLL cabcapacitydll = new CabManagementDLL())
                {
                    lstcabcapacity = cabcapacitydll.GetCabCapacity();
                }
                return lstcabcapacity;
            }
            catch
            {
                throw;
            }
        }

        /// <summary>
        /// To Get Cab Property list
        /// </summary>
        /// <returns></returns>

        public List<CabProperty> GetCabproperty(int? PropertyId, bool? IsActive)
        {
            List<CabProperty> lstgetcabproperty = null;

            try
            {
                using (PropertyManagementDLL cabpropertydll = new PropertyManagementDLL())
                {
                    lstgetcabproperty = cabpropertydll.GetCabProperty(PropertyId,IsActive);
                }

                return lstgetcabproperty;
            }
               
            catch
            { throw; }



           
        
        }


        /// <summary>
        /// To Insert CabDetail and Get CabId For Inserted Record
        /// </summary>
        ///  /// <param name="CabManagement"></param>
        /// <returns></returns>

        public Int32 InsertCabDetail(CabManagementt CabManagement)
        {
            CabManagementDLL ObjCabManagementdll = new CabManagementDLL();
            return (ObjCabManagementdll.InsertCabDetail(CabManagement));
        }

        public List<CabManagementt> GetCabDetail(Int32? CabId, bool? IsActive)
        {
            List<CabManagementt> lstCabDetail = null;
            try
            {
                using (CabManagementDLL cabmanagementDll = new CabManagementDLL())
                {
                    lstCabDetail = cabmanagementDll.GetCabDetail(CabId,IsActive);

                }
                return lstCabDetail;
            }
            catch (Exception e)
            {
                throw;
            }

            finally
            { lstCabDetail = null; 
            }
           
        }

        public bool ActiveInactiveCabDetail(string  Cabid, bool ActiveInactive, string comment, string ModifiedBy)
        {
            bool isFlag = false;
            CabManagementDLL objCabManagementDLL = null;
            try 
            {
                objCabManagementDLL = new CabManagementDLL();

                isFlag = objCabManagementDLL.ActiveInactiveCabDetail(Cabid, ActiveInactive, comment, ModifiedBy);

                return isFlag;
            }
            catch(Exception e)
            {
             
                throw;
            }
            finally
            {
                objCabManagementDLL = null;
            }
           
        }

      public bool UpdateCabDetail(CabManagementt cabmanagement)
        {
            bool isFlag = false;
          CabManagementDLL objCabManagementDLL=null;
            try
            {
                objCabManagementDLL = new CabManagementDLL();
                isFlag = objCabManagementDLL.UpdateCabDetail(cabmanagement);
                return isFlag;
            }
            catch (Exception e)
            {
                throw;
            }
            finally
            {
                objCabManagementDLL = null;
            }


        }
      public List<CabProperty> GetCabVerificationDetail(string CabId)
      {
          List<CabProperty> lstCabproperty = null;
          CabManagementDLL objCabManagementDLL=null;
          try
          {
              objCabManagementDLL = new CabManagementDLL();
              lstCabproperty = objCabManagementDLL.GetCabVerificationDetail(CabId);
              return lstCabproperty;
          }
          catch (Exception e)
          {
              throw;
          }
          finally
          {
              objCabManagementDLL = null;
          }
      


      }

      #region Penalty on Cab

      public List<CabManagementt> GetAllCabListByDC(string DCID)
      {
          List<CabManagementt> lstCabNO = null;
          try
          {
              using (CabManagementDLL cabmanagementDll = new CabManagementDLL())
              {
                  lstCabNO = cabmanagementDll.GetAllCabListByDC(DCID);
              }
              return lstCabNO;
          }
          catch (Exception e)
          {
              throw;
          }

          finally
          {
              lstCabNO = null;
          }
 
      }
      /// <summary>
      /// To impose a new penalty on cab
      /// </summary>
      /// <param name="vendor"></param>
      /// <returns></returns>
      public bool PenaltyOnCab(Penalty PenaltyImpose)
      {
          bool isFlag = false;
          try
          {
              using (CabManagementDLL cabManagementDLL = new CabManagementDLL())
              {
                  isFlag = cabManagementDLL.PenaltyOnCab(PenaltyImpose);
              }
              return isFlag;
          }
          catch
          {
              throw;
          }
      }

      #endregion

      #region IDisposable Members

      public void Dispose()
        {
            //Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}

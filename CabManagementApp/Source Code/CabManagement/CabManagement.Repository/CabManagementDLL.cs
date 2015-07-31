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
using System.ComponentModel;
using System.Globalization;
namespace Infosys.CabManagement.Repository
{
   public  class CabManagementDLL:IDisposable
    {

       SqlHelper.SqlHelper ObjSqlHelper;
        /// <summary>
        /// Set connection string
        /// </summary>
       public CabManagementDLL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ConnectionString;
        }

        /// <summary>
        /// Method to get CabType
        /// </summary>
        /// <param name="CabName"></param>
        /// <param name="IsActive"></param>
        /// <returns></returns>
         public List<CabType> GetCabTypeList( bool? IsActive)
        {
            List<CabType> lstcabtype = null;
            string proc_name = ConstantsDLL.USP_GETCABTYPE;
            
            using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
            {
                using (DataSet ds = db.ExecDataSetProc(proc_name, null))
                {
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbCABTYPE = ds.Tables[0];
                            lstcabtype = tbCABTYPE.AsEnumerable().Select(Cabtype => new CabType 
                            {

                                CABNAME = Convert.ToString(Cabtype["CABNAME"])
                                
                            }).ToList();
                        }
                    }
                }
            }

            return lstcabtype;
        }



         /// <summary>
         /// Method to get CabCapacity
         /// </summary>
         /// <returns></returns>
         public List<CabCapacity> GetCabCapacity()
         {
             List<CabCapacity> lstcabcapacity = null;
             string proc_name = ConstantsDLL.usp_GETCABCAPACITY;

             using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
             {
                 using (DataSet ds = db.ExecDataSetProc(proc_name, null))
                 {
                     if (ds != null)
                     {
                         if (ds.Tables[0].Rows.Count > 0)
                         {
                             DataTable tbCABCPC = ds.Tables[0];
                             lstcabcapacity = tbCABCPC.AsEnumerable().Select(CabCpcty => new CabCapacity
                             {

                                 capacity = Convert.ToString(CabCpcty["cabcapacity"])

                             }).ToList();
                         }
                     }
                 }
             }

             return lstcabcapacity;
         }

        

         /// <summary>
         /// Method to insert the details for cab 
         /// </summary>
         /// <param name="CabManagement"></param>
         /// <returns></returns>

         public Int32  InsertCabDetail(CabManagementt CabManagement)
       {
           int Result = 0;
           ObjSqlHelper = new SqlHelper.SqlHelper();
           string proc_name = ConstantsDLL.USP_INSERTCABMANAGEMENT;
           SqlParameter[] param = new SqlParameter[14];
           param[0] = new SqlParameter("@CabNumberFirst", CabManagement.CabNumberFirst);
           param[1] = new SqlParameter("@CabNumberLast", CabManagement.CabNumberLast);
           param[2] = new SqlParameter("@DocumentsVerified",CabManagement.DocumentsVerified);
           param[3] = new SqlParameter("@VendorID",CabManagement.VendorID);
           param[4] = new SqlParameter("@CabType", CabManagement.CabType);
           param[5] = new SqlParameter("@CabCapacity",CabManagement.CabCapacity);
           param[6] = new SqlParameter("@DriverId", CabManagement.DriverName);
           param[7] = new SqlParameter("@EmpanelDate", CabManagement.EmpanelDate);
           param[8] = new SqlParameter("@CreatedBy", CabManagement.CreatedBy);
           var val = CabManagement.lstCabProperty;
           DataTable dt = new DataTable();
           dt = ToDataTable(val);
           dt.Columns.Remove("ModifiedBy");
           dt.Columns.Remove("IsActive");
           dt.Columns.Remove("CreatedDate");
           dt.Columns.Remove("CreatedBy");
           dt.Columns.Remove("ModifiedDate");
           dt.Columns.Remove("PropertyName");
           param[9] = new SqlParameter("@TableVar",dt);
           param[10] = new SqlParameter("@IsActive", CabManagement.IsActive);
           param[11] = new SqlParameter("@Comment", CabManagement.Comment);
           param[12] = new SqlParameter("@CabId",CabManagement.CabId);
           param[12].Direction = ParameterDirection.Output;

           param[13] = new SqlParameter("@Result", SqlDbType.Int);
           param[13].Direction = ParameterDirection.ReturnValue;
           ObjSqlHelper.ExecNonQueryProc(proc_name, param);
           Result = Convert.ToInt32(param[13].Value);
           return Result;
       }


       public DataTable ToDataTable<T>(IList<T> data)// T is any generic type
       {
           PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));

           DataTable table = new DataTable();
           for (int i = 0; i < props.Count; i++)
           {
               PropertyDescriptor prop = props[i];
               table.Columns.Add(prop.Name, prop.PropertyType);
           }
           object[] values = new object[props.Count];
           foreach (T item in data)
           {
               for (int i = 0; i < values.Length; i++)
               {
                   values[i] = props[i].GetValue(item);
               }
               table.Rows.Add(values);
           }
           return table;
       }


       /// <summary>
       /// Method to Get List of CAB DETAIL
       /// </summary>
      /// <returns></returns>
       public List<CabManagementt> GetCabDetail(Int32? CabId,bool? IsActive)
       {
           List<CabManagementt> lstCabdetail = null;
           string proc_name = ConstantsDLL.usp_GetCabDetail;
           SqlParameter[] param = new SqlParameter[2];
           param[0] = new SqlParameter("@CabId", CabId);
           param[1] = new SqlParameter("@IsActive", IsActive);

          using(SqlHelper.SqlHelper db=new SqlHelper.SqlHelper())
          {
                using (DataSet ds=db.ExecDataSetProc(proc_name,param))
                {
                    if (ds != null)
                     {
                         if (ds.Tables[0].Rows.Count > 0)
                         {
                             DataTable tbCABDETAIL = ds.Tables[0];
                             lstCabdetail = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new CabManagementt
                             {           CabId = Convert.ToInt32(Cabdetail["CabId"].ToString()),
                                         DCName=Cabdetail["DCName"].ToString(),
                                         CabNumberFirst =Cabdetail["CabNumberFirst"].ToString(),
                                         CabNumberLast = Cabdetail["CabNumberLast"].ToString(),
                                         DocumentsVerified = Convert.ToBoolean(Cabdetail["DocumentsVerified"]),
                                         VendorName=Cabdetail["VendorName"].ToString(),
                                         CabType = Cabdetail["CabType"].ToString(),
                                         CabCapacity =Convert.ToInt32 ( Cabdetail["CabCapacity"]),
                                         DriverName = Cabdetail["DriverName"].ToString(),
                                         Comment = Cabdetail["Comment"].ToString(),
                                         EmpanelDate =(Convert.ToDateTime( Cabdetail["EmpanelDate"])).ToString("MMM dd,yyyy"),
                                         IsActive=Convert.ToBoolean(Cabdetail["IsActive"]),
                                         IsActiveComment = Cabdetail["IsActiveComment"].ToString()
                                        
                             }).ToList();
                         }
                     }
                }
          }
         return lstCabdetail;
       }



       /// <summary>
       /// Method to make ActiveInActive Cab
       /// </summary>
       /// <param name="vendor"></param>
       /// <returns></returns>
       public bool ActiveInactiveCabDetail(string  Cabid,bool ActiveInactive,string comment,string ModifiedBy)
       {
           string proc_name = ConstantsDLL.USP_ACTIVEINACTIVECABDETAIL;
           SqlParameter[] param = new SqlParameter[4];
           param[0] = new SqlParameter("@CabId", Cabid);
           param[1] = new SqlParameter("@IsActive", ActiveInactive);
           param[2] = new SqlParameter("@IsActiveComment", comment);
           param[3] = new SqlParameter("@ModifiedBy", ModifiedBy);

           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               db.ExecNonQueryProc(proc_name, param);
           }
           return true;

       }



       /// <summary>
       /// Method to make modification in vendor
       /// </summary>
       /// <param name="vendor"></param>
       /// <returns></returns>
       public bool UpdateCabDetail(CabManagementt cabmanagement)
       {
           string proc_name = ConstantsDLL.USP_UPDATECABDETAIL;
           SqlParameter[] param = new SqlParameter[13];
           param[0] = new SqlParameter("@CabID ", cabmanagement.CabId);
           param[1] = new SqlParameter("@VendorId", cabmanagement.VendorID);
           param[2] = new SqlParameter("@CabNumberFirst", cabmanagement.CabNumberFirst);
           param[3] = new SqlParameter("@CabNumberLast", cabmanagement.CabNumberLast);
           param[4] = new SqlParameter("@CabType", cabmanagement.CabType);
           param[5] = new SqlParameter("@CabCapacity", cabmanagement.CabCapacity);
           param[6] = new SqlParameter("@driverId", cabmanagement.DriverName);
           param[7] = new SqlParameter("@DocumentVerified", cabmanagement.DocumentsVerified);
           param[8] = new SqlParameter("@Empaneldate",cabmanagement.EmpanelDate);
           param[9]=new SqlParameter ("@IsActive",cabmanagement.IsActive);
           param[10] = new SqlParameter("@Comment", cabmanagement.Comment);
           param[11] = new SqlParameter("@ModifiedBy",cabmanagement.ModifiedBy);
           var val = cabmanagement.lstCabProperty;
           DataTable dt = new DataTable();
           dt = ToDataTable(val);
           dt.Columns.Remove("ModifiedBy");
           dt.Columns.Remove("IsActive");
           dt.Columns.Remove("CreatedDate");
           dt.Columns.Remove("CreatedBy");
           dt.Columns.Remove("ModifiedDate");
           dt.Columns.Remove("PropertyName");
           param[12] = new SqlParameter("@TableVar",dt);
           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               db.ExecNonQueryProc(proc_name, param);
           }
           return true;
       }

       /// <summary>
       /// Method to get CabVerfication
       /// </summary>
       public List<CabProperty> GetCabVerificationDetail(string CabId)
       {
           List<CabProperty> lstgeetCabVerficationDetail = null;
           string proc_name = ConstantsDLL.USP_CABVERIFICATIONDETAIL;
           SqlParameter[] param = new SqlParameter[1];
           param[0] = new SqlParameter("@CabId", CabId);
           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, param))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbCabVerificationDetail = ds.Tables[0];
                           lstgeetCabVerficationDetail = tbCabVerificationDetail.AsEnumerable().Select(CabVerficationDetail => new CabProperty
                           {


                             PropertyId = Convert.ToInt32(CabVerficationDetail["PropertyId"]),

                             ExpiryDate = Convert.ToString(CabVerficationDetail["ExpiryDate"])==""? "":(Convert.ToDateTime(CabVerficationDetail["ExpiryDate"])).ToString("MMM dd,yyyy")
                             
                           }).ToList();

                       }

                   }

               }
           }

           return lstgeetCabVerficationDetail;

       }

       #region Penalty on Cabs
       /// <summary>
       /// Method to Get List of CAB NO
       /// </summary>
       /// <returns></returns>
       public List<CabManagementt> GetAllCabListByDC(string DCID)
       {
           List<CabManagementt> lstCabNo = null;
           string proc_name = ConstantsDLL.USP_GETCABNO;
           
           
           SqlParameter[] param = new SqlParameter[1];
           param[0] = new SqlParameter("@DCID", Convert.ToInt32(DCID));
           
           using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
           {
               using (DataSet ds = db.ExecDataSetProc(proc_name, param))
               {
                   if (ds != null)
                   {
                       if (ds.Tables[0].Rows.Count > 0)
                       {
                           DataTable tbCABDETAIL = ds.Tables[0];
                           lstCabNo = tbCABDETAIL.AsEnumerable().Select(Cabdetail => new CabManagementt
                           {
                               CabId = Convert.ToInt32(Cabdetail["CabId"].ToString()),
                               CabNumberFull = Cabdetail["CabNumberFirst"].ToString() + Cabdetail["CabNumberLast"].ToString()                            
                           }).ToList();
                       }
                   }
               }
           }
           return lstCabNo;
       }


       /// <summary>
       /// Method to insert the details for imposing penalty
       /// </summary>
       /// <param name="vendor"></param>
       /// <returns></returns>
       public bool PenaltyOnCab(Penalty penaltyImposed)
       {
           //string proc_name = ConstantsDLL.USP_INSERTVENDOR;
           ObjSqlHelper = new SqlHelper.SqlHelper();
           SqlParameter[] param = 
        { 
             new SqlParameter("@DCID",SqlDbType.VarChar),
             new SqlParameter("@CabID",SqlDbType.Int),
             new SqlParameter("@PenaltyAmount", SqlDbType.Int),
             new SqlParameter("@PenaltyDiscription",SqlDbType.VarChar), 
             new SqlParameter("@rVal",SqlDbType.Int)   
        };
           param[0].Value =Convert.ToInt32(penaltyImposed.DCID);
           param[0].Size = 255;
           param[1].Value = penaltyImposed.CabID;
           param[1].Size = 155;
           param[2].Value = penaltyImposed.PenaltyAmount;
           param[2].Size = 30;
           param[3].Value = penaltyImposed.PenaltyDiscription;
           param[3].Size = 455;  
           
           param[4].Direction = ParameterDirection.ReturnValue;

           ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_IMPOSEPENALTY, param);
          if (Convert.ToInt32(param[4].Value)==1)
	        {
		         return true;
	        }
         else
	        {
                 return false;
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

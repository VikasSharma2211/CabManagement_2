using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Infosys.CabManagement.Model;

namespace Infosys.CabManagement.Repository
{
    public class RouteMasterDAL
    {
       
        SqlHelper.SqlHelper ObjSqlHelper;
        public RouteMasterDAL()
        {
            SqlHelper.SqlHelper.ConnectionString = ConfigurationManager.ConnectionStrings["constrg"].ToString();
        }

        public Int32 InsertDropPoint(RouteMaster ObjRouteMaster)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            
            {
                new SqlParameter("@RouteID",SqlDbType.Int),
                new SqlParameter("@RouteName", SqlDbType.VarChar), 
                new SqlParameter("@DropPoint", SqlDbType.VarChar),
                new SqlParameter("@SortOrder", SqlDbType.Int),    
                new SqlParameter("@DCID",SqlDbType.Int),
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int), 
            };
            oPara[0].Value = ObjRouteMaster.RouteID;
            oPara[0].Size = 155;
            oPara[1].Value = ObjRouteMaster.RouteName.Trim();
            oPara[1].Size = 155;
            oPara[2].Value = ObjRouteMaster.DropPoint.Trim();
            oPara[2].Size = 255;
            oPara[3].Value = ObjRouteMaster.SortOrder;
            oPara[4].Value = ObjRouteMaster.DCID;
            oPara[4].Size = 255;
            oPara[5].Value = ObjRouteMaster.CreatedBy;
            oPara[5].Size = 255;
            oPara[6].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_InsertDropPoint, oPara);
            return Convert.ToInt32(oPara[6].Value);
        }

        public Int32 InsertRouteMaster(RouteMaster ObjRouteMaster)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            { 
                new SqlParameter("@RouteName", SqlDbType.VarChar), 
                new SqlParameter("@DCID",SqlDbType.Int),
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };
            oPara[0].Value = ObjRouteMaster.RouteName.Trim();
            oPara[0].Size = 155;
            oPara[1].Value = ObjRouteMaster.DCID;
            oPara[1].Size = 255;
            oPara[2].Value = ObjRouteMaster.CreatedBy;
            oPara[2].Size = 255;
            oPara[3].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_INSERTRoute, oPara);
            return Convert.ToInt32(oPara[3].Value);
        }

        public Int32 UpdateRouteMaster(RouteMaster ObjRouteMaster)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            { 
                new SqlParameter("@DPID", SqlDbType.Int), 
                new SqlParameter("@RouteName", SqlDbType.VarChar), 
                new SqlParameter("@DropPoint", SqlDbType.VarChar),
                new SqlParameter("@SortOrder", SqlDbType.Int),
                new SqlParameter("@DCID",SqlDbType.Int),
                new SqlParameter("@CreatedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };
            oPara[0].Value = ObjRouteMaster.DPID;
            oPara[0].Size = 155;
            oPara[1].Value = ObjRouteMaster.RouteName.Trim();
            oPara[1].Size = 155;
            oPara[2].Value = ObjRouteMaster.DropPoint.Trim();
            oPara[2].Size = 255;
            oPara[3].Value = ObjRouteMaster.SortOrder;
            oPara[4].Value = ObjRouteMaster.DCID;
            oPara[4].Size = 255;
            oPara[5].Value = ObjRouteMaster.CreatedBy;
            oPara[5].Size = 255;
            oPara[6].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_UpdateRoute, oPara);
            return Convert.ToInt32(oPara[6].Value);
        }

        public Int32 DeleteRouteMaster(RouteMaster ObjRouteMaster)
        {
            ObjSqlHelper = new SqlHelper.SqlHelper();
            SqlParameter[] oPara = 
            { 
                new SqlParameter("@DPID", SqlDbType.VarChar),
                new SqlParameter("@IsActive", SqlDbType.Int), 
                new SqlParameter("@ModifiedBy", SqlDbType.VarChar),
                new SqlParameter("@Rval", SqlDbType.Int) 
            };
            oPara[0].Value = ObjRouteMaster.RouteIDs;
            oPara[0].Size = 255;
            oPara[1].Value = ObjRouteMaster.IsActive;
            oPara[1].Size = 155;
            oPara[2].Value = ObjRouteMaster.ModifiedBy;
            oPara[2].Size = 255;
            oPara[3].Direction = ParameterDirection.ReturnValue;
            ObjSqlHelper.ExecNonQueryProc(ConstantsDLL.USP_DeleteRoute, oPara);
            return Convert.ToInt32(oPara[3].Value);
        }

        public List<RouteMaster> GetAllRoute(Int32? RouteId,Int32? DCID,bool? IsActive)
        {
            try
            {
                List<RouteMaster> list = null;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@RouteID", RouteId);
                param[1] = new SqlParameter("@DCID",DCID);
                param[2] = new SqlParameter("@IsActive",IsActive);

                using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
                {
                    using (DataSet ds = db.ExecDataSetProc(ConstantsDLL.USP_GetAllRoutes, param))
                    {
                        if (ds != null && ds.Tables != null && ds.Tables[0].Rows.Count > 0)
                        {
                            list = new List<RouteMaster>();
                            for(int i = 0 ;i < ds.Tables[0].Rows.Count; i++)
                            {
                                var row = ds.Tables[0].Rows[i];
                                var rm = new RouteMaster();
                                rm.DPID = (string)(row["DPID"] == null || row["DPID"] == DBNull.Value ? string.Empty : row["DPID"].ToString());
                                rm.RouteID = (Int32)(row["RouteID"]);
                                rm.RouteName = (string)(row["RouteName"] ?? "");
                                rm.DropPoint = row["DropPoint"] == null || row["DropPoint"] == DBNull.Value ? string.Empty : row["DropPoint"].ToString();
                                rm.SortOrder = Convert.ToString(row["SortOrder"]);
                                rm.DCID = (Int32)(row["DCID"]);
                                rm.DCName = (string)(row["DCName"] ?? "");
                                rm.IsActive = Convert.ToBoolean(row["IsActive"]);

                                list.Add(rm);
                            }
                            return list;
                        }
                        else
                        {
                            return list;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<RouteMaster> GetSelectedroute(RouteMaster ObjRouteMaster)
        {
            try
            {
                // string qry = "usp_selectRoute";
                var list = new List<RouteMaster>();
                SqlParameter[] opara =
                {
                    new SqlParameter("@DCID",SqlDbType.Int)
                };
                opara[0].Value = ObjRouteMaster.DCID;
                opara[0].Size = 255;
                using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
                {
                    using (DataSet ds = db.ExecDataSetProc(ConstantsDLL.USP_GetSelectedroute, opara))
                    {
                        if (ds != null)
                        {
                            list = ds.Tables[0].AsEnumerable().Select(x => new RouteMaster
                            {
                               RouteID = (Int32)(x["RouteID"]),
                                RouteName = (string)(x["RouteName"] ?? ""),
                               // DropPoint = (string)(x["DropPoint"] == null || x["DropPoint"] == DBNull.Value ? string.Empty : x["DropPoint"].ToString()),
                                //DCID = (Int32)(x["DCID"] ?? ""),
                                //DCName = (string)(x["DCName"] ?? ""),
                                //IsActive = (Boolean)(x["IsActive"] ?? "")
                            }).ToList();
                            return list;
                        }
                        else
                        {
                            return list;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<RouteMaster> GetSelectedrouteAccordingToDC(RouteMaster ObjRouteMaster)
        {
            try
            {
                // string qry = "usp_selectRoute";
                var list = new List<RouteMaster>();
                SqlParameter[] opara =
                {
                    new SqlParameter("@DCID",SqlDbType.Int)
                };
                opara[0].Value = ObjRouteMaster.DCID;
                opara[0].Size = 255;
                using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
                {
                    using (DataSet ds = db.ExecDataSetProc(ConstantsDLL.USP_GetSelectedrouteAccordingToDC, opara))
                    {
                        if (ds != null)
                        {
                            list = ds.Tables[0].AsEnumerable().Select(x => new RouteMaster
                            {
                                RouteID = (Int32)(x["RouteID"]),
                                RouteName = (string)(x["RouteName"] ?? ""),
                                DropPoint = (string)(x["DropPoint"] == null || x["DropPoint"] == DBNull.Value ? string.Empty : x["DropPoint"].ToString()),
                                SortOrder = Convert.ToString(x["SortOrder"]),
                                DCID = (Int32)(x["DCID"] ?? ""),
                                DCName = (string)(x["DCName"] ?? ""),
                                IsActive = (Boolean)(x["IsActive"] ?? "")
                            }).ToList();
                            return list;
                        }
                        else
                        {
                            return list;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<RouteMaster> GetAllPointsByRoute(string RouteName)
        {
            try
            {
                List<RouteMaster> list = null;
                SqlParameter[] opara =
                {
                    new SqlParameter("@RouteName",RouteName)
                };
                using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
                {
                    using (DataSet ds = db.ExecDataSetProc(ConstantsDLL.USP_GETPOINTSBYROUTE, opara))
                    {
                        if (ds != null)
                        {
                            list = ds.Tables[0].AsEnumerable().Select(x => new RouteMaster
                            {
                                RouteID = (Int32)(x["RouteID"]),
                                //RouteName = (string)(x["RouteName"] ?? ""),
                                DropPoint = (string)(x["DropPoint"] == null || x["DropPoint"] == DBNull.Value ? string.Empty : x["DropPoint"].ToString()),
                                //DCID = (Int32)(x["DCID"] ?? ""),
                               // DCName = (string)(x["DCName"] ?? ""),
                                //IsActive = (Boolean)(x["IsActive"] ?? "")
                            }).ToList();
                            return list;
                        }
                        else
                        {
                            return list;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public List<DC> GetDCList()
        {
            try
            {
                //  string qry = "usp_GetDCList";
                var list = new List<DC>();
                using (SqlHelper.SqlHelper db = new SqlHelper.SqlHelper())
                {
                    using (DataSet ds = db.ExecDataSetProc(ConstantsDLL.USP_GetDCList, null))
                    {
                        if (ds != null)
                        {
                            list = ds.Tables[0].AsEnumerable().Select(x => new DC
                            {
                                DCID = (Int32)(x["DCID"]),
                                DCName = (string)(x["DCName"] ?? "")
                            }).ToList();
                            return list;
                        }
                        else
                        {
                            return list;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

       
    }
}

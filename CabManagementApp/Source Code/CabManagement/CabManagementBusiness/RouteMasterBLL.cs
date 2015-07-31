using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infosys.CabManagement.Model;
using Infosys.CabManagement.Repository;

namespace Infosys.CabManagement.Business
{
    public class RouteMasterBLL
    {
        RouteMasterDAL ObjRouteDAL = new RouteMasterDAL();
        public Int32 InsertRouteMaster(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.InsertRouteMaster(ObjRouteMaster));
        }
        public Int32 InsertDropPoint(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.InsertDropPoint(ObjRouteMaster));
        }

        public Int32 UpdateRouteMaster(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.UpdateRouteMaster(ObjRouteMaster));
        }
        public Int32 DeleteRouteMaster(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.DeleteRouteMaster(ObjRouteMaster));
        }
        public List<RouteMaster> GetAllRoute(Int32? RouteId,Int32? DCID,bool? IsActive)
        {
            return (ObjRouteDAL.GetAllRoute(RouteId,DCID,IsActive));
        }
        public List<RouteMaster> GetSelectedroute(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.GetSelectedroute(ObjRouteMaster));
        }
        public List<DC> GetDCList()
        {
            return (ObjRouteDAL.GetDCList());
        }
        public List<RouteMaster> GetSelectedrouteAccordingToDC(RouteMaster ObjRouteMaster)
        {
            return (ObjRouteDAL.GetSelectedrouteAccordingToDC(ObjRouteMaster));
        }
        public List<RouteMaster> GetAllPointsByRoute(string RouteName)
        {
            return (ObjRouteDAL.GetAllPointsByRoute(RouteName));
        }

        public List<DC> GetSelectedDC()
        {
            return (ObjRouteDAL.GetDCList());
        }
    }
}

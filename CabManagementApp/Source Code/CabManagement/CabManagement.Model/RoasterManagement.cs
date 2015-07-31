using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace Infosys.CabManagement.Model
{
  public  class RoasterManagement
    {
      public string PreFix { get; set; }
      public string Client{ get; set;  }
      public string ProjectCode { get; set; }
      public string PickupDropDate { get; set; }
      public string TotalEmployee { get; set; }
      public string RouteName { get; set; }
      public string LandmarkName { get; set; }
      public string TypeOfPickupDrop { get; set; }
      public string ShiftTimings { get; set; }
      public string CabType { get; set; }
      public string Vendor { get; set; }
      public string EndUser { get; set; }
      public string Guard { get; set; }
      public string CabNo { get; set; }
      public string RosterNumber { get; set; }
      public DataTable RosterDetailDT;


    }
}

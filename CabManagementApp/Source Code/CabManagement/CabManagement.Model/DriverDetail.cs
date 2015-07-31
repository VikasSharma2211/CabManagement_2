using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
  public  class DriverDetail
    {
      public int DriverId { get; set; }
      public string DriverCode { get; set; }
      public string DriverName { get; set; }

      public int DCID { get; set; }

      public string DCName { get; set; }
      public string EmpanelDate { get; set; }
      public string CreatedBy { get; set; }
      public string  ModifyDate { get; set; }
      public string ModifyBy { get; set; }
      public bool IsActive { get; set; }
      

    }
}

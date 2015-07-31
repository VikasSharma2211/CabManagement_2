using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Infosys.CabManagement.Model
{
   public class Roster
    {
       // public DataTable RosterDetail;
        public string Cabno { get; set; }
        public string RouteName { get; set; }
        public string CabCapacity { get; set; }
        public string EmployeeNo { get; set; }
        public bool CabnoValid { get; set; }
        public bool RouteNameValid { get; set; }
        public bool CabCapacityValid { get; set; }
        public bool CabPropertyValid { get; set; }
        public bool EmployeNoValid { get; set; }

        public string RousterDate { get; set; }
        public string EmployeeName { get; set; }
        public string EmployeeGender { get; set; }
        public string Address { get; set; }
        public string Landmark { get; set; }
        public string Contact { get; set; }
        public string PickupTime { get; set; }

        public string ShiftTime { get; set; }

        public string PickUpOrder { get; set; }


        public string Vendor { get; set; }
        public string CabType { get; set; }
        public string Signature { get; set; }

        public string RoosterNumber { get; set; }
  
    }
}

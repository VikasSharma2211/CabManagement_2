using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class RouteMaster
    {
        public string DPID { get; set; }
        public int RouteID { get; set; }


        public string RouteIDs { get; set; }
        public string RouteName { get; set; }
        public string SortOrder { get; set; }
        public string DropPoint { get; set; }

        public int DCID { get; set; }

        public string DCName { get; set; }

        public DateTime CreatedDate { get; set; }

        public string CreatedBy { get; set; }

        public DateTime ModifiedDate { get; set; }

        public string ModifiedBy { get; set; }

        public Boolean IsActive { get; set; }
    }
}

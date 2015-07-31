using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class Vendor
    {
        public Int32 VendorID { get; set; }
        public string VendorName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string EmpanelDate { get; set; }
        public int DCID { get; set; }
        public string DCName { get; set; }
        public string Comment { get; set; }
        public bool IsActive { get; set; }
        public string IsActiveComment { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
}

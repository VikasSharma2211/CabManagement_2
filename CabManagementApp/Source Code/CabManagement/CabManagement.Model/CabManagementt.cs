using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class CabManagementt
    {
        public int DCID { get; set; }
        public string DCName { get; set; }
        public int CabId { get; set; }
        public string CabNumberFull { get; set; }
        public string CabNumberFirst { get; set; }
        public string CabNumberLast { get; set; }
        public bool DocumentsVerified { get; set; }
        public Int32 VendorID { get; set; }
        public string CabType { get; set; }
        public Int32 CabCapacity { get; set; }
        public string DriverName { get; set; }
        public int DriverId { get; set; }
        public string EmpanelDate { get; set; }
        public string Comment { get; set; }
        public bool IsActive { get; set; }
        public string IsActiveComment { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string  VendorName{get;set; }
        public List<CabProperty> lstCabProperty { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class Shift
    {

        //Added few comments to it
        //Added changes with robin at 11:00 AM
        public Int32 ShiftId { get; set; }
        public string ShiftType { get; set; }
        public string ShiftCategory { get; set; }
        public string ShiftTime { get; set; }
        public int DCID { get; set; }
        
        
        public bool IsActive { get; set; }
        
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string DcName { get; set; }

    }
}


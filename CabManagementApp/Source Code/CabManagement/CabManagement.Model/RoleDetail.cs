using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
   public  class RoleDetail
    {
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string RoleAccess { get; set; }
        public string CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public bool IsActive { get; set; }     
    }
}

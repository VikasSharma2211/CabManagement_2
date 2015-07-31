using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class Penalty
    {
        public int PenaltyAmount { get; set; }
        public string PenaltyDiscription { get; set; }
        public DateTime PenaltyDateTime { get; set; }
        public string CabNumberFull { get; set; }
        public int CabID { get; set; }
        public int DCID { get; set; }
    }
}

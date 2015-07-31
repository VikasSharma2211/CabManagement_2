using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Model
{
    public class OnDemandRequest
    {
        public Int64 OndemandRequestId { get; set; }
        public string RequestType { get; set; }
        public string ReoccuringRequest { get; set; }
        public DateTime toDate { get; set; }
        public string EmailId { get; set; }
        public string BookingType { get; set; }
        public string Gender { get; set; }
        public int DCID { get; set; }
        public int RouteId { get; set; }
        public string RequestedDate { get; set; }
        public string RequestedTime { get; set; }
        public string Address { get; set; }
        public string Mobile { get; set; }
        public string RequestRemarks { get; set; }
        public bool IsEditableByRequester { get; set; }
        public string Approver { get; set; }
        public int IsApprovedStatus { get; set; }
        public string ApproverRemarks { get; set; }
        public bool IsTransportStatus { get; set; }
        public string TransportApprovedBy { get; set; }
        public string TransportRemarks { get; set; }
        public int CabId { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }

        public string RouteName { get; set; }
    }
}

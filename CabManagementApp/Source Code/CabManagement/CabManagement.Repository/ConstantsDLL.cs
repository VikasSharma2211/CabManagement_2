using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infosys.CabManagement.Repository
{
    public class ConstantsDLL
    {
        #region Constants for Stored Procedures
        //Vendor
        public const string USP_INSERTVENDOR = "usp_InsertVendor";
        public const string USP_GETVENDORLIST = "usp_GetVendorList";
        public const string USP_GETVENDORLISTACCTODC = "usp_GetVendorListAccordingToDC";
        public const string USP_ACTIVEINACTIVEVENDOR = "usp_ActiveInactiveVendor"; 
        public const string USP_UPDATEVENDOR = "usp_UpdateVendor";

        //Cab
        public const string USP_INSERTCABMANAGEMENT = "usp_InsertCabManagement";
        public const string USP_GETCABLIST = "usp_GetCABList";

        public const string USP_GETDCLIST =  "usp_GetDCList";
        public const string USP_INSERTSHIFTINFO = "usp_InsertShiftInfo";
        public const string USP_UPDATESHIFTINFO = "usp_UpdateShiftInfo";
        public const string USP_GETSHIFTINFO = "usp_GetShiftInfo";
        public const string USP_ACTIVEINACTIVESHIFT = "usp_ActiveInactiveShift";
        public const string USP_GETCABTYPE = "usp_GetCabType";
        public const string usp_GETCABCAPACITY = "usp_GetCabCapacity";
        public const string usp_GetCabDetail = "usp_GetCabDetail";
        public const string USP_ACTIVEINACTIVECABDETAIL = "usp_ActiveInactiveCabdetail";
        public const string USP_UPDATECABDETAIL = "usp_UpdateCabdetail";
        public const string USP_CABVERIFICATIONDETAIL = "usp_GetCabVerficationDetail";
        public const string USP_GETROLETYPE = "usp_GetRoleType";
        public const string USP_GETROLEDETAIL = "usp_GetRoleDetail";
        public const string USP_INSERTROLE = "usp_InsertRole";
        public const string USP_ACTIVEINACTIVEROLE = "usp_ActiveInactiveRole";
        public const string USP_UPDATEROLE = "usp_UpdateRole";
        public const string USP_GETROLEID = "usp_GetRoleId";
        public const string USP_GETSHIFTDETAILBYDC = "usp_GetShiftDetailByDC";


        public const string USP_INSERTRoute = "usp_InsertRoute";
        public const string USP_InsertDropPoint = "usp_InsertDropPoint";
        public const string USP_UpdateRoute = "usp_UpdateRoute";
        public const string USP_DeleteRoute = "usp_DeleteRoute";
        public const string USP_GetAllRoutes = "usp_GetALLRoutes";
        public const string USP_GetDCList = "usp_GetDCList";
        public const string USP_GetSelectedroute = "usp_GetSelectedroute";
        public const string USP_GetSelectedrouteAccordingToDC = "usp_GetSelectedrouteAccordingToDC";
        public const string USP_GETPOINTSBYROUTE = "usp_GetPointsByRoute";
        public const string USP_GETCABNO = "usp_GetCabNo";
        public const string USP_IMPOSEPENALTY = "usp_ImposePenalty";
        
        //OnDemandRequest
        public const string USP_INSERTNEWREQUEST = "usp_InsertNewRequest";
        public const string USP_GetUserDetails = "usp_GetUserDetails";
        public const string USP_GetActiveUserDetails = "usp_GetActiveUserDetails";
        public const string USP_ActiveInactiveUser = "usp_ActiveInactiveUser";
        public const string USP_GetMyRequest = "usp_GetMyRequest";  
          public const string USP_REJECTUSERREQUEST = "USP_REJECTUSERREQUEST";
          public const string USP_APPROVEUSERREQUEST = "USP_APPROVEUSERREQUEST";
          public const string USP_GetRejectedUserDetails = "USP_GetRejectedUserDetails";
          public const string usp_GetLatestRecords = "usp_GetLatestRecords";
          public const string usp_CheckRecords = "usp_CheckRecords";
             public const string USP_UPDATEONDEMANDREQUEST = "usp_UpdateOndemandRequest";
          public const string USP_CANCELONDEMANDREQUEST = "USP_CancelRequest";


        
       
        //usp_CheckRecords
        

        // Driver Detail
        public const string USP_GetDriverDetails = "usp_GetDriverDetails";
        public const string usp_GetDriverDetailsAccToDC = "usp_GetDriverDetailsAccToDC";
        public const string USP_InsertDriverDetails = "usp_InsertDriverDetail";
        public const string USP_UpdateDriverDetail = "usp_UpdateDriverDetail";
        public const string USP_ActiveInactiveDriver = "usp_ActiveInactiveDriver";

        //Cab Property
        public const string USP_GETCABPROPERTY = "usp_GetCabProperty";
        public const string USP_ACTIVEINACTIVEPROPERTY = "usp_ActiveInactiveProperty";
        public const string USP_INSERTPROPERTY = "usp_InsertProperty";
        public const string USP_UPDATEPROPERTY = "usp_UpdateProperty";

        // Record For Validate Roster
        public const string USP_GETRECORDFORROSTER = "usp_GetRecordForRoster";
        public const string USP_CREATEROASTERNO = "usp_RoasterNoCreation";
        public const string USP_INSERTROASTERDETAIL = "usp_InsertRosterDetail";
        public const string USP_UPDATEROASTERDETAIL = "usp_UpdateRosterDetail";

        //Rooster Detail
        public const string USP_GETROOSTERDETAIL = "usp_GetRosterDetail";

        public const string USP_GETROOSTERWISERECORDS = "usp_GetRosterWiseRecords";

        //ondemand approval
        public const string USP_ACTIVEINACTIVEUSER = "usp_ActiveInactiveUser";
        
        //DCManagement
        public const string USP_INSERTDC = "usp_InsertDC";
        public const string USP_DELETEDC = "usp_DeleteDC";
        public const string USP_UPDATEDC = "usp_UpdateDC";      
       
        #endregion


    }
}

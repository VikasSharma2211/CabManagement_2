<%@ Page Title="On Demand Approval" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="OnDemandApproval.aspx.cs" Inherits="Infosys.CabManagement.UI.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


     <link href="../CSS/style.css" rel="stylesheet" />
    <%--datepicker--%>
    <link href="../CSS/jquery-ui.css" rel="stylesheet" />

   <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

     <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
    
     <!-- jQuery -->
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <%--validation--%>
    <script src="../Scripts/jquery.validationEngine-en.js"></script>
    <script src="../Scripts/jquery.validationEngine.js"></script>
    
      <%--datepicker--%>
    <script src="../Scripts/DatePicker/jquery-ui.js"></script>
  
    <!-- DataTables -->    
    <script src="../Scripts/DataTable/jquery.dataTables.js"></script>

    <script>

        function OnDemandCabApproval(EmailId, BookingType, Gender, RouteId, RequestedDate, RequestedTime, Address, RequestRemarks) {
            this.EmailId = EmailId;
            this.BookingType = BookingType;
            this.Gender = Gender;
            this.RouteId = RouteId;
            this.RequestedDate = RequestedDate;
            this.RequestedTime = RequestedTime;
            this.Address = Address;
             this.RequestRemarks = RequestRemarks;
            
        }

        var status = {
            activeStatus: "active",
            inActiveStatus: "inactive"
        };

        var statusRunning;

        $(document).ready(function () {
            $("#pageloaddiv").fadeIn(500);
            $('#overlay-back').fadeIn(500);
            //code to load active all Driver list
            GetuserList();

            $("#pageloaddiv").fadeOut(500);
            $('#overlay-back').fadeOut(500);
            //end code to load active all vendor list

            $("#txtEmpanelDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "M dd,yy",
                maxDate: new Date(),
                onSelect: hideValidation

            });

            $("#aApprovedDriver").click(function () {
                
                GetActiveUserList();
                $("#spnActiveInactive").text("Approved");
            });

            $("#apendingDriver").click(function () {

                GetuserList();
              
            });

            
            //show active list initially
            statusRunning = status.activeStatus;
            $("#spnActiveInactive").text(" InActivate");
            //to show popup to create a new vendor           
            $("#aCreateDriver").click(function () {
                //hide validation message if any
                $("#frmdriver").validationEngine('hideAll');
                ClearDriverDetail();
                //hide update button and show submit button
                $("#btnSubmit").show();
                $("#btnUpdate").hide();

                $('#overlay-back').fadeIn(100, function () {
                    $('#popup').show();
                    // ClearDriverDetail();
                });
            });
            


            $("#RejectedUsers").click(function () {
                GetRejectedUsers();
                statusRunning = status.inActiveStatus;
                $("#spnActiveInactive").text("Activate");
            });

            $("#aActiveDriver").click(function () {
                GetActiveDriverDetail();
                statusRunning = status.activeStatus;
                $("#spnActiveInactive").text("Inactivate");
            });

            //delete selected vendors
            $("#aDeleteDriver").click(function () {
                var SelectedDriverIds = "";
                var countchecked = $("#tblLstUser input[type=checkbox]:checked").length;

                if (countchecked > 0) {
                    var strMsg = "";
                    if (statusRunning == status.activeStatus) {
                        strMsg = "Are you sure to inactivate the selected " + countchecked;
                    }
                    else {
                        strMsg = "Are you sure to activate the selected " + countchecked;
                    }

                    if (countchecked > 1) {
                        strMsg += " Driver?";
                    } else {
                        strMsg += " Driver?";
                    }
                    if (confirm(strMsg)) {
                        // continue with delete
                        var chkSelected = $("#tblLstUser input[type=checkbox]:checked");
                        for (var index = 0; index < countchecked; index++) {
                            var id = chkSelected[index].attributes["id"].value.substring(3);
                            SelectedDriverIds += id + ",";
                        }
                        if (SelectedDriverIds != "") {
                            SelectedDriverIds = SelectedDriverIds.substring(0, SelectedDriverIds.length - 1);
                            ActiveInactiveDriver(SelectedDriverIds);
                        }

                    }
                }
                else {
                    if (statusRunning == status.activeStatus) {
                        alert("Select atleast 1 Driver to inactivate!!!");
                    }
                    else {
                        alert("Select atleast 1 Driver to activate!!!");
                    }

                }

            });


            $(".close-image").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(100);
            });
            $("#btnCancel").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(100);
                ClearDriverDetail();
            });

            $("#frmdriver").submit(function (e) {

                var valid = $("#frmdriver").validationEngine('validate');
                if (valid) {
                    e.preventDefault();

                    InsertNewDriver();
                    ClearDriverDetail();
                }
            });

           
        });
        function hideValidation() {
            $('#txtEmpanelDate').validationEngine('hide');
        }


     

       
        function GetRejectedUsers() {

            $.ajax({
                type: "POST",
                url: "OnDemandApproval.aspx/GetRejectedUserList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstUser').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "OndemandRequestId"
                            },

                            { "data": "EmailId" },
                            { "data": "BookingType" },
                            { "data": "Gender" },
                            { "data": "RouteId" },
                            { "data": "RequestedDate" },
                            { "data": "RequestedTime" },
                            { "data": "Address" },
                            { "data": "RequestRemarks", "bSearchable": false },

                            {
                                "data": "isapprovedstatus", "bSortable": false, render: function (data, type, row) {
                                    if (data) {
                                        return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";

                                    }
                                    else {
                                        return "<img src='../Images/Rejected_Bulb.jpg' height='25px' width='25px' />";
                                    }


                                }
                            }
                            ,
                            {
                                "data": "OndemandRequestId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "'></a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Reject the selected User Request?\")) ActiveInactiveUser(" + data + ");else return false;'>Reject</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' >Rejected</a>"; //href = '#'
                                    }
                                    return strReturn;
                                }
                            }

                        ]

                    });
                },
                error: function (er) {
                    alert(er.responseText());
                }
            });
        }

        function GetActiveUserList() {
           
            $.ajax({
                type: "POST",
                url: "OnDemandApproval.aspx/GetActiveUserList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstUser').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "OndemandRequestId"
                            },

                            { "data": "EmailId" },
                            { "data": "BookingType" },
                            { "data": "Gender" },
                            { "data": "RouteId" },
                            { "data": "RequestedDate" },
                            { "data": "RequestedTime" },
                            { "data": "Address" },
                            { "data": "RequestRemarks", "bSearchable": false },

                            {
                                "data": "isapprovedstatus", "bSortable": false, render: function (data, type, row) {
                                    if (data) {
                                        return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                                      
                                    }
                                    else {
                                        return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";
                                    }


                                }
                            }
                            ,
                            {
                                "data": "OndemandRequestId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "'></a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Reject the selected User Request?\")) ActiveInactiveUser(" + data + ");else return false;'>Reject</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' >Approved</a>"; //href = '#'
                                    }
                                    return strReturn;
                                }
                            }

                        ]

                    });
                },
                error: function (er) {
                    alert(er.responseText());
                }
            });
        }


        
        function GetuserList() {

            $.ajax({
                type: "POST",
                url: "OnDemandApproval.aspx/GetUserList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
         
                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstUser').dataTable({
                        destroy: true,
                        paging: true,
                        
                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "OndemandRequestId"
                            },

                            { "data": "EmailId" },
                            { "data": "BookingType" },
                            { "data": "Gender" },
                            { "data": "RouteId" },
                            { "data": "RequestedDate" },
                            { "data": "RequestedTime" },
                            { "data": "Address" },
                            { "data": "RequestRemarks", "bSearchable": false },

                            {
                                "data": "IsApprovedStatus", "bSortable": false, render: function (data, type, row) {
                                    if (data == 1) {
                                        return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";

                                    }
                                    if (data == 0) {
                                        return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                                    }
                                    if (data == 2) {
                                        return "<img src='../Images/Rejected_Bulb.jpg' height='25px' width='25px'/>";
                                    }


                                }
                            }
                            ,
                            {
                                "data": "OndemandRequestId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "'></a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Reject the selected User Request?\")) ActiveInactiveUser(" + data + ");else return false;'>Reject</a>";

                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Approve the Selected User Request?\")) ApproveUserRequest(" + data + ");else return false;'>Approve</a>";
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Reject the selected User Request?\")) RejectUserRequest(" + data + ");else return false;'>Reject</a>";

                                    }
                                    return strReturn;
                                }
                            }

                        ]

                    });
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        var status = {
            activeStatus: "active",
            inActiveStatus: "inactive"
        };
   
        function RejectUserRequest(SelectedUserId) {

           
            $.ajax({
                type: "POST",
                url: "OnDemandApproval.aspx/RejectRequestUsers",
                data: "{'UserId':'" + SelectedUserId + "','Comment':'Rejected'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                   
                            GetuserList();
                         
                                           
                },
                error: function (er) {
                    alert(er.responseText);
                }
            });

        }
        
        function  ApproveUserRequest(SelectedUserId) {


            $.ajax({
                type: "POST",



                //url: "OnDemandApproval.aspx/RejectRequestUsers",
                url: "OnDemandApproval.aspx/ApproveUserRequest",
                data: "{'UserId':'" + SelectedUserId + "','Comment':'Approved'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;

                    GetuserList();


                },
                error: function (er) {
                    alert(er.responseText);
                }
            });

        }

        function ActiveInactiveUser(SelectedUserId) {
 
            var isActive;
            if (statusRunning == status.inActiveStatus) {
                isActive = true;
            }
            else {
                isActive = false;
            }
            $.ajax({
                type: "POST",
                url: "OnDemandApproval.aspx/PendingRequestUsers",
                data: "{'UserId':'" + SelectedUserId + "','Comment':'approved','IsActive':'" + isActive + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                        if (statusRunning == status.activeStatus) {
                            GetActiveUserList();
                          //  $("#spnActiveInactive").text("Inactivate");
                        }
                        else {
                            GetuserList();
                           // $("#spnActiveInactive").text("Activate");
                        }
                        

                    }
                    else {
                        alert("Error Occured");
                    }

                },
                error: function (er) {
                    alert(er.responseText);
                }
            });

        }
        function ClearDriverDetail() {
            $("#txtDriverName").val('');
            $("#txtDriverCode").val('');
            $("#txtEmpanelDate").val('');


        }


    </script>
     <script>
         $(function () {
             $("#accordion").accordion({
                 collapsible: true
             });
         });
  </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
   <div id="accordion">
  <h3>Actions></h3>
  <div>
          <table>
          <tr>
              <td> <a href="#" id="apendingDriver">PENDING REQUESTS</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aApprovedDriver">APPROVED REQUESTS</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="RejectedUsers">REJECTED REQUESTS</a></td>
              <td class="width20"></td>
             
          </tr>
      </table>
  </div>
      
</div>
         <br />
    <br />
    <table width="100%" class="cell-border paddingtop15" id="tblLstUser" cellspacing="0">
        <thead>
            <tr class="tablerow">
                 <th>OnDemandRequestID</th>
                <th>EmailId</th>
                <th>BookingType</th>
                <th>Gender</th>
                <th>RouteId</th>
                <th>RequestedDate</th>
                <th>RequestedTime</th>
                <th>Address</th>
                <th>RequestRemarks</th>

              <th class="width20">Status</th>         
                <th>Action </th>

               

            </tr>
        </thead>

    </table>

       
    <form>
    <div id="overlay-back"></div>
     <div id="pageloaddiv"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#frmdriver").validationEngine({
                // Auto-hide prompt
                autoHidePrompt: true,
                // Delay before auto-hide
                autoHideDelay: 2000,
                // Fade out duration while hiding the validations
                fadeDuration: 0.3
            });

            //disable special characters
            //$('#frmVendor').bind('keypress', function (e) {
            //    var key = e.which;
            //    var ok = key >= 65 && key <= 90 || // A-Z
            //        key >= 97 && key <= 122 || // a-z
            //        key >= 48 && key <= 57 || //0-9
            //        key == 35 || // #
            //        key == 46 || //.
            //        key == 44 || //,
            //        key == 64 || //@
            //        key == 58 || //:
            //        key == 40 || //(
            //        key == 41 || //)
            //        key == 32  //space
            //    ;

            //    if (!ok) {
            //        e.preventDefault();
            //    }

            //});
        });
    </script>   

    </form>

</asp:Content>

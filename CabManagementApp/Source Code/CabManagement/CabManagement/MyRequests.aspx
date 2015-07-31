<%@ Page Title="My Requests" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MyRequests.aspx.cs" EnableEventValidation="false"    Inherits="Infosys.CabManagement.UI.WebForm6" %>

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

        function OnDemandCabApproval(onDemandRequestId, EmailId, BookingType, RouteId, RequestedDate, RequestedTime, Address, RequestRemarks, Approver) {
            this.onDemandRequestId = onDemandRequestId;
            this.EmailId = EmailId;
            this.BookingType = BookingType;
            //this.Gender = Gender;
            this.RouteId = RouteId;
            this.RequestedDate = RequestedDate;
            this.RequestedTime = RequestedTime;
            this.Address = Address;
            this.RequestRemarks = RequestRemarks;
            this.Approver = Approver;
        }

        var status = {
            activeStatus: "active",
            inActiveStatus: "inactive"
        };

        var statusRunning;

        $(document).ready(function () {
            
            $("#txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "M dd,yy",
                minDate: new Date(),
                onSelect: hideValidation

            });
            //    GetuserList();
            $("#pageloaddiv").fadeIn(500);
            $("#cancelpopup").hide();
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

            //show active list initially
            statusRunning = status.activeStatus;
            $("#spnActiveInactive").text(" InActivate");
            //to show popup to create a new vendor           
            //$("#aCreateDriver").click(function () {
            //    //hide validation message if any
            //    $("#frmdriver").validationEngine('hideAll');
            //    ClearDriverDetail();
            //    //hide update button and show submit button
            //    $("#btnSubmit").show();
            //    $("#btnUpdate").hide();

            //    $('#overlay-back').fadeIn(100, function () {
            //        $('#popup').show();
            //        $('#cancelpopup').show();
            //        // ClearDriverDetail();
            //    });
            //});


            $("#btnUpdate").on('click', function () {
                
                //var valid = $("#frmVendor").validationEngine('validate');
                //alert(valid);
                var valid = true;
                if (valid) {
                    var objRequest = new OnDemandCabApproval();
                    objRequest.onDemandRequestId = $("#hRequestId").val();

                    objRequest.RequestType = $("input:radio[name='txtRequestType']:checked").val()
                    objRequest.BookingType = $("input:radio[name='txtBookingType']:checked").val()

                   // objRequest.RouteName = $("#ddlRouteName").val();

                    objRequest.Approver = $("#txtApproverName").val();
                    objRequest.Address = $("#txtAddress").val();
                    objRequest.RequestedDate = $("#txtDate").val();
                    objRequest.RequestedTime = $("#ddlTime").val();
                    objRequest.RequestRemarks = $("#txtRemarks").val();
                   // objRequest. = $("#txtRemarks").val();

                    $.ajax({
                        type: "POST",
                        url: "MyRequests.aspx/UpdateRequest",
                        data: "{'Request':" + JSON.stringify(objRequest) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                          
                            var msg = result.d;
                            if (msg) {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(100);
                                GetuserList();
                            }
                            else {
                                alert("Error Occured");
                            }

                        },
                        error: function (er) {
                            alert(er.responseText);
                        }
                    })
                }
            });

            $(".close-image").on('click', function () {
                $('#popup').hide();
                $('#cancelpopup').hide();
                $('#overlay-back').fadeOut(100);
            });
            $("#btnCancel").on('click', function () {
                $('#popup').hide();
              
                $('#overlay-back').fadeOut(100);
                ClearDriverDetail();
            });

            $("#btnCancel1").on('click', function () {
                $('#popup').hide();
                $('#cancelpopup').hide();
                $('#overlay-back').fadeOut(100);
                ClearDriverDetail();
            });
            

            //$("#btnSubmitCancel").on('click', function () {
                
            //    $('#cancelpopup').hide();
            //    $('#overlay-back').fadeOut(100);
            //    ClearDriverDetail();
            //});

            $("#frmdriver").submit(function (e) {

                var valid = $("#frmdriver").validationEngine('validate');
                if (valid) {
                    e.preventDefault();

                    InsertNewDriver();
                    ClearDriverDetail();
                }
            });

            $("#btnSubmitCancel").on('click', function () {
             
                var valid = true;
                if (valid) {
                    
                    var RequestId = $("#hRequestId").val();
                  
                    var res = confirm("Are You Sure To Delete This Request?");
                    if (res == true) {
                        $.ajax({
                            type: "POST",
                            url: "MyRequests.aspx/CancelRequest",
                            contentType: "application/json; charset=utf-8",
                            data: "{'RequestId':'" + RequestId + "' }",
                            datatype: "text",
                            success: function (result) {

                                alert('REQUEST CANCELLED');
                                GetuserList();
                            },
                            error: function (er) {
                                alert(er.responseText);
                            }
                        });
                    }
                }
            });


        });


         //// function CancelRequest(e) {
           
         //// hide validation message if any
         ////$("#frmVendor").validationEngine('hideAll');
         ////hide update button and show submit button

         ////$("#btnSubmitCancel").show();
         ////$("#btnCancel1").show();

         //// get parent row
         //// var row = $(e).parent().parent();
         //// var RequestId = row[0].cells[0].innerText;
         //// $("#hRequestId").val(RequestId);


         //// $('#overlay-back').fadeIn(100, function () {

            
                
         ////  });
         ////    alert("");
         ////   $('#cancelpopup').show();



           
        
        function CancelRequest(e) {
           
            var row = $(e).parent().parent();
            var RequestId = row[0].cells[0].innerText;

            $.ajax({
                type: "POST",
                url: "MyRequests.aspx/CancelRequest",
                //data: "{'RequestId':'" + RequestId + "' }",
                data: "{'RequestId':" + JSON.stringify(RequestId) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "text",
                success: function (result) {
                    var msg = result.d;

                    GetuserList();

                },
                error: function (er) {
                    alert(er.responseText);
                }
            });

        }


            function hideValidation() {
                $('#txtEmpanelDate').validationEngine('hide');
            }

            function EditDetails(e) {
           
                //hide validation message if any
                $("#frmVendor").validationEngine('hideAll');
                //hide update button and show submit button
                $("#btnSubmit").hide();
                $("#btnUpdate").show();
                $("#btnSubmitCancel").show();
                
                //get parent row
                var row = $(e).parent().parent();
                var tdRequestId = row[0].cells[0].innerText;
                var tdApprover = row[0].cells[1].innerText;    //index 0 for checkbox

                var tdRequestType = row[0].cells[2].innerText;
                var tdBookingType = row[0].cells[3].innerText;
               // var tdRouteName = row[0].cells[4].innerText;

                var tdDate = row[0].cells[5].innerText;//Date
                var tdTime = row[0].cells[6].innerText;
                var tdAddress = row[0].cells[7].innerText;
                var tdRemarks = row[0].cells[8].innerText;

                $('#overlay-back').fadeIn(100, function () {
                    $('#popup').show();
                  
                   
                });

                if (tdRequestType == "Shift") {

                    $('#Sh').prop('checked', true);
                }
                else {
                   $('#Sr').prop('checked', true);
                }


                if (tdBookingType == "LogIn") {

                    $('#In').prop('checked', true);
                }
                else {
                    $('#Out').prop('checked', true);
                }


                $("#hRequestId").val(tdRequestId);

                $("#txtApproverName").val(tdApprover);

                //$("#txtRouteName").val(tdRouteName);

                $("#txtAddress").val(tdAddress);
                $("#txtDate").val(tdDate);
                $("#txtRemarks").val(tdRemarks);
                //set ddl
                $("#ddlDC option").each(function () {
                    if ($(this).text().trim() == tdDCName.trim()) {
                        $(this).attr('selected', 'selected');
                    }
                });


            }

        

            function GetuserList() {
                
                $.ajax({
                    type: "POST",
                    url: "MyRequests.aspx/MyRequestUsers",
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
                                { "data": "RequestType" },
                                { "data": "BookingType" },

                                { "data": "RouteName" },
                                 
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
                                        if (data == 3) {
                                            return "<img src='../Images/Cancelled_bulb.jpg' height='25px' width='25px'/>";
                                        }

                                    }
                                }
                                ,
                                {
                                    "data": "IsApprovedStatus", "bSortable": false, render: function (data, type, row) {
                                        var strReturn = "<a id='" + data + "' href='#'></a>";
                                        if (data == 1) {
                                            strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' >APPROVED </a>";
                                           
                                            
                                        }
                                        if (data == 0) {
                                            strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "'  >PENDING </a>";

                                        }
                                        if (data == 2) {
                                            strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "'  >REJECTED </a>"; //href='#'

                                        }
                                        if (data == 3) {
                                            strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "'  >CANCELLED </a>"; //href='#'

                                        }
                                        return strReturn;
                                    }
                                },
                                 {
                                     "data": "IsApprovedStatus", "bSortable": false, render: function (data, type, row) {
                                         var strReturn = "<a id='" + data + "' href='#'></a>";
                                         if (data == 0) {
                                   
                                             strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='" + data + "' href='#' onClick='EditDetails(this)'>Edit / Cancel</a>";//href='#'
                                             ////strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='" + data + "' href='#' onClick='CancelRequest(this)'>Cancel</a>";//href='#'

                                         }
                                         if (data == 1) {
                                            
                                             strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to Cancel the selected User Request?\")) CancelRequest(this)(" + data + ");else return false;'>Cancel</a>";
                                         }

                                         return strReturn;
                                     }
                                 }

                            ]

                        });
                    },
                    error: function (er) {
                        alert(er.responseText);
                    }
                });
            }




            var status = {
                activeStatus: "active",
                inActiveStatus: "inactive"
            };

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
            <%-- <table>
          <tr>
              <td> <a href="#" id="apendingDriver">PENDING REQUESTS</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aApprovedDriver">APPROVED REQUESTS</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aInActiveDriver">REJECTED REQUESTS</a></td>
              <td class="width20"></td>
             
          </tr>
      </table>--%>
        </div>

    </div>
    <br />
    <br />
    <table width="100%" class="cell-border paddingtop15" id="tblLstUser" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>RequestID</th>
                <th>Approver</th>
                 <th>RequestType</th>
                
                <th>Booking Type</th>

                <th>Route Name</th>
                <th>Date</th>
                <th>Time</th>
                <th>Address</th>
                <th>Remarks</th>

                <th class="width20">Status</th>
                <th>Current State</th>
                <th width="10%">Action</th>


            </tr>
        </thead>

    </table>
    <div id="popup">
        <img class="close-image" src="../Images/close.png" />

        <form id="frmVendor" method="post">
            <fieldset>
                <label>
                    <b>Edit Request Details:</b>
                </label>
            </fieldset>

            <table>
                <tr class="displayNone">
                    <td></td>
                    <td>
                        <input id="hRequestId" type="hidden" value="" /></td>
                </tr>
                <tr>
                    <td>Request Type:</td>
                     <td>
                <input  name="txtRequestType" type="radio" id="Sr" value="SR" />SR &nbsp;&nbsp;<input name="txtRequestType" id="Sh" type="radio" value="Shift" />Shift</td>
            <td>
                    
                </tr>


                <tr>
                    <td>Booking Type:</td>
                     <td>
                <input  name="txtBookingType" type="radio" id="In" value="LogIn" />LogIn &nbsp;&nbsp;<input name="txtBookingType" id="Out" type="radio" value="LogOut" />LogOut</td>
            <td>
                    
                </tr>


                 

                <tr>
                    <td>Approver Name:</td>
                    <td>
                        <input id="txtApproverName" name="txtApproverName" class="validate[required]" type="text" maxlength="50" />
                    </td>
                </tr>

                <tr>
                    <td>Date:</td>
                    <td>
                        <input type="text" id="txtDate" readonly="readonly" class="validate[required]" /></td>
                </tr>

                <tr>
                    <td>Time:</td>
                    <td>
                        <select id="ddlTime" class="validate[required]">
                            <option>06:00:00</option>
                            <option>09:00:00</option>
                            <option>09:15:00</option>
                            <option>12:00:00</option>
                            <option>15:00:00</option>
                            <option>18:00:00</option>
                            <option>19:30:00</option>
                            <option>21:00:00</option>
                            <option>23:59:00</option>
                        </select></td>
                </tr>

                <tr>
                    <td>Address:</td>
                    <td>
                        <asp:TextBox ID="txtAddress" CssClass="validate[required]" runat="server" ClientIDMode="Static" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Remarks:</td>
                    <td>
                        <asp:TextBox ID="txtRemarks" CssClass="validate[required]" runat="server" ClientIDMode="Static" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>




                <tr>
                    <td></td>
                    <td>
                        <input id="btnSubmit" class="submit" type="submit" value="Submit" />
                        <input id="btnUpdate" type="button" value="Update" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="btnSubmitCancel" class="submit" type="submit" value="Delete Request" />

                        <%--&nbsp;&nbsp;<input id="btnCancel" type="button" value="Cancel" /></td>--%>
                    </td>
                </tr>
            </table>
        </form>
    </div>

     <div id="cancelpopup">
        <img class="close-image" src="../Images/close.png" />

        <form id="frmCancel" method="post">
            <fieldset>
                <label>
                    <b>CANCEL REQUEST:</b>
                </label>
            </fieldset>

            <table>
                <tr class="displayNone">
                    <td></td>
                    <td>
                        <input id="hRequestIdCancel" type="hidden" value="" /></td>
                </tr>
              <tr>
                  <td>Do You Want To Cancel The Request?</td>
              </tr>

                <tr>
                    <td></td>
                    <td>
                        <input id="btnSubmitCancel1" class="submit" type="submit" value="Submit" />
                                                &nbsp;&nbsp;<input id="btnCancel1" type="button" value="Cancel" /></td>

                </tr>
            </table>
        </form>
    </div>
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

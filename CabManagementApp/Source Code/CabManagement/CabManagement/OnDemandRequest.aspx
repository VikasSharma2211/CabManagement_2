<%@ Page Title="On Demand Requests" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="OnDemandRequest.aspx.cs" Inherits="Infosys.CabManagement.UI.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <%--datepicker--%>
    <link href="../CSS/style.css" rel="stylesheet" />
    <link href="CSS/jquery-ui.css" rel="stylesheet" />
     <link href="CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

     <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
     <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.validationEngine-en.js"></script>
    <script src="Scripts/jquery.validationEngine.js"></script>
      <%--datepicker--%>
    <script src="Scripts/DatePicker/jquery-ui.js"></script>
    <script type="text/javascript">

        function OnDemandCabDetails(RequestType, ReoccuringRequest, ToDate, EmailId, BookingType, Gender, DCID, RouteId, RequestedDate, RequestedTime, Address, Mobile, RequestRemarks, IsEditableByRequester, Approver) {
            this.RequestType = RequestType;
            this.ReoccuringRequest = ReoccuringRequest;
            this.ToDate = ToDate;
            this.EmailId = EmailId;
            this.BookingType = BookingType;
            this.Gender = Gender;
            this.DCID = DCID;
            this.RouteId = RouteId;
            this.RequestedDate = RequestedDate;
            this.RequestedTime = RequestedTime;
            this.Address = Address;
            this.Mobile = Mobile;
            this.RequestRemarks = RequestRemarks;
            this.IsEditableByRequester = IsEditableByRequester;
            this.Approver = Approver;
        }
        $(document).ready(function () {
            // binds form submission and fields to the validation engine
            // $("#form1").validationEngine();
            //$('.spnReoccuringRequest').hide();
            GetDC();
            $("#txtPickUpDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "M dd,yy",
                minDate: new Date(),
                onSelect: hideValidation,
                //numberOfMonths: 2,
                //beforeShowDay: noSunday,
                //beforeShowDay: noSaturday,
                onSelect: function (selected) {
                    $("#txtToDate").datepicker("option", "minDate", selected)
                }
            });
            //function noSunday(date) {
            //    var day = date.getDay();
            //    return [(day > 0 && day!=6), ''];
            //};


            //function noSaturday(date) {
            //    var day = date.getDay();
            //    return [(day > -1), ''];
            //};

            $("#txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "M dd,yy",
                minDate: new Date(),
                onSelect: hideValidation,
                //beforeShowDay: noSunday,
              //  beforeShowDay: noSaturday,
                numberOfMonths: 2,
                // onSelect: hideValidation,
                onSelect: function (selected) {
                    $("#txtPickUpDate").datepicker("option", "maxDate", selected)
                }
            });

            //change span inner text according to booking type
            if ($("input:radio[name='rdBooking']:checked").val() == "LogIn") {
                $(".spnBookType").val("PickUp");
                $(".spnBookType1").val("PickUp");
                $(".spnBookType2").val("Login");

            }
            else {
                $(".spnBookType").val("Drop");
                $(".spnBookType2").val("LogOut");
            }
            //add change event for radiobutton list of booking type
            $('input[type=radio][name=rdBooking]').change(function () {

                if (this.value == 'LogIn') {
                    $(".spnBookType").each(function (i, data) {
                        data.innerHTML = "PickUp";
                    });
                    $(".spnBookType1").each(function (i, data) {
                        data.innerHTML = "PickUp";
                    });
                    $(".spnBookType2").each(function (i, data) {
                        data.innerHTML = "Login";
                    });
                }
                else {
                    $(".spnBookType").each(function (i, data) {
                        data.innerHTML = "Drop";
                    });
                    $(".spnBookType1").each(function (i, data) {
                        data.innerHTML = "Drop";
                    });
                    $(".spnBookType2").each(function (i, data) {
                        data.innerHTML = "LogOut";
                    });
                }
                GetShiftsByDC();
            });



            $('input[type=radio][name=rdRequestType]').change(function () {

                GetShiftsByDC();
            });
            //change span inner text according to booking type
            if ($("input:radio[name='rdReoccuringRequest']:checked").val() == "Yes") {

                $(".spnBookType1").val("From");

            }
            else {
                $(".spnBookType1").val("PickUp");
            }
            //add change event for radiobutton list of Request Type
            $('input[type=radio][name=rdReoccuringRequest]').change(function () {

                if (this.value == 'Yes') {
                    $(".spnReoccuringRequest").each(function (i, data) {
                        $('#txtToDate').prop('disabled', false);

                    });

                    $(".spnBookType1").each(function (i, data) {
                        data.innerHTML = "From";
                    });


                }
                else {
                    $(".spnReoccuringRequest").each(function (i, data) {
                        $('#txtToDate').prop('disabled', true);
                        $('.spnReoccuringRequest').show();

                    });
                    $(".spnBookType1").each(function (i, data) {
                        data.innerHTML = "PickUp";
                    });

                }

                GetShiftsByDC();
            });

            //     $('#ddlPickUpTime').append($("<option>").val(0).text('–Select–'));
            $('#ddlRoute').append($("<option>").val(0).text('–Select–'));
            $('#ddlPickUps').append($("<option>").val(0).text('–Select–'));
           
            $("#ddlRoute").change(function () {
                GetAllPointsByRoutes();
            });
            
            $("#ddlDcName").change(function () {
                GetAllRoutesListByDC();

            });

            
            GetShiftsByDC();
            GetLogUsrDetails();

          function checkRecords()
            {

                var RouteId = $('#ddlRoute>option:selected').val();
                var RequestedDate = $("#txtPickUpDate").val();
                $.ajax({
                    type: "Post",
                    url: "OnDemandRequest.aspx/CheckRecord",
                    data: "{'routeId':'" + RouteId + "','requestedDate':'" + RequestedDate + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        
                        var Output = result.d;
                        if (Output ==0) {
                                                       
                                BookOnDemandCab();
                           
                        }
                        else {
                            $("#errMsg").text("Sorry, you Have Already Made a request For The Selected Date And RouteID!!!!! ");
                            setTimeout(function () {
                                $("#errMsg").text(" ").css("color", "Red");
                            }, 10000);

                        }
                    },
                    error: function (er) {
                       
                        alert(er.responseText);
                    }
                });


            }

            $("#btnReqSubmit").click(function (e) {
            
                e.preventDefault();
              
               
                //$("#form1").validationEngine();
                var valid = $("#form1").validationEngine('validate');
                if (valid) {

                    var dtNow = new Date();
                    var dtSelection = new Date($("#txtPickUpDate").val() + " " + $("#ddlPickUpTime option:selected").text());
                    var diff = (dtSelection - dtNow) / (1000 * 60);//minutes
                    var days = (dtSelection - dtNow) / 1000 / 60 / 60;
                    if ($("input:radio[name='rdBooking']:checked").val() == "LogIn") {
                        if (days <= 1) {//i day = 24hrs
                            $("#errMsg").text("Sorry, you can't make request!!!!! You can make request before 24 Hrs from current time for Login.");
                            setTimeout(function () {
                                $("#errMsg").text(" ");
                            }, 10000);
                        }
                        else {

                            checkRecords();


                        }

                    }

                    else {
                        if (diff < 120) {
                            $("#errMsg").text("Sorry, you can't make request!!!!! You can make request before 2Hrs from current time for Logout.");
                            setTimeout(function () {
                                $("#errMsg").text(" ");
                            }, 10000);
                        }
                        else {
                            checkRecords();
                            //BookOnDemandCab();
                        }
                    }
                }
                //valid over
            });
        });


        function ClearAll() {
            $("#txtPickUpDate").val("");
            $("#txtToDate").val("");
            $("#txtAddress").val("");
            $("#txtRemarks").val("");
            GetAllRoutesListByDC();

            GetShiftsByDC();
            GetAllPointsByRoutes();
        }
        // book ondemand Cab 
        function BookOnDemandCab() {
           
            var objOndemandCab = new OnDemandCabDetails();

            objOndemandCab.RequestType = $("input:radio[name='rdRequestType']:checked").val();
            objOndemandCab.RequestedDate = $("#txtPickUpDate").val();
            objOndemandCab.ReoccuringRequest = $("input:radio[name='rdReoccuringRequest']:checked").val();

            if (objOndemandCab.ReoccuringRequest == "No") {
                objOndemandCab.ToDate = objOndemandCab.RequestedDate;
            }
            else {
                objOndemandCab.ToDate = $("#txtToDate").val();
            }
            objOndemandCab.EmailId = '';
            objOndemandCab.BookingType = $("input:radio[name='rdBooking']:checked").val();
            objOndemandCab.Gender = $("input:radio[name='rdGender']:checked").val();
            objOndemandCab.DCID = $('#ddlDcName').val();
            objOndemandCab.RouteId = $('#ddlRoute>option:selected').val();

            objOndemandCab.RequestedTime = $('#ddlPickUpTime>option:selected').text();
            objOndemandCab.Address = $("#txtAddress").val();
            objOndemandCab.Mobile = $("#txtMobile").val();
            objOndemandCab.IsEditableByRequester = true;
            objOndemandCab.Approver = $("#txtApprover").val();
            objOndemandCab.RequestRemarks = $("#txtRemarks").val();

            $.ajax({
                type: "Post",
                url: "OnDemandRequest.aspx/SaveOndemandRequest",
                data: "{'OnDemandCabBooking':" + JSON.stringify(objOndemandCab) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var Output = result.d;
                    if (Output != null && Output == true) {
                        $("#errMsg").text("YOUR REQUEST HAS BEEN CREATED SUCCESSFULLY AND GONE FOR MANAGER VERIFICATION.")
                        .css("color", "Green");

                        ClearAll();
                        setTimeout(function () {
                            $("#errMsg").text(" ");
                        }, 10000);
                    }
                },
                error: function (er) {
                    alert(er.responseText);
                }
            });
        }

        function GetAllRoutesListByDC() {
            
            var DcId = $('#ddlDcName').val();
            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetAllRoutesListByDC",
                data: "{'DCID':" + DcId + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    
                    var Output = result.d;
                    if (Output != null) {
                        $('#ddlRoute').children().remove();
                        $('#ddlRoute').append($("<option>").val(0).text('–Select–'));
                        $.each(Output, function (index, value) {
                            $('#ddlRoute').append($("<option></option>").val(value.RouteID).html(value.RouteName));
                        });
                    }

                },
                error: function (er) {
                    alert(er);
                }
            });
        }


        function GetDC() {
            
            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetAllDC",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var Output = result.d;
                    if (Output != null) {
                        $('#ddlDcName').children().remove();
                        $('#ddlDcName').append($("<option>").val(0).text('–Select–'));
                        $.each(Output, function (index, value) {
                            $('#ddlDcName').append($("<option></option>").val(value.DCID).html(value.DCName));
                        });
                    }

                },
                error: function (er) {
                    alert(er);
                }
            });
        }


        function GetAllPointsByRoutes() {
           
            var RouteName = $("#ddlRoute  option:selected").text();
            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetAllPointsByRoutes",
                data: "{'RouteName':'" + RouteName + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var Output = result.d;
                    if (Output != null) {
                        $('#ddlPickUps').children().remove();
                        $('#ddlPickUps').append($("<option>").val(0).text('–Select–'));
                        $.each(Output, function (index, value) {
                            $('#ddlPickUps').append($("<option></option>").val(value.RouteID).html(value.DropPoint));
                        });
                    }
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function GetShiftsByDC() {
           
            var ShiftType = $("input:radio[name='rdBooking']:checked").val();
            var RequestType = $("input:radio[name='rdRequestType']:checked").val();
            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetShiftsByDC",
                data: "{'ShiftType':'" + ShiftType + "','RequestType':'" + RequestType + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var Output = result.d;
                    if (Output != null) {
                        $('#ddlPickUpTime').children().remove();
                        $('#ddlPickUpTime').append($("<option>").val(0).text('–Select–'));
                        $.each(Output, function (index, value) {
                            $('#ddlPickUpTime').append($("<option></option>").val(value.ShiftId).html(value.ShiftTime));
                        });
                    }
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function GetLogUsrDetails() {
            
            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetLogUsrDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var Output = result.d;

                    $('#txtApprover').val(Output.Manager);
                    $('#txtMobile').val(Output.Mobile);
                    $('#txtProjectCode').val(Output.ProjectCode);
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function hideValidation() {
            $('#txtPickUpDate').validationEngine('hide');
        }
    </script>
      <style type="text/css">
          .newStyle1 {
              text-align: left;
          }
          .sorting {
              text-align: left;
          }
          .newStyle2 {
              text-align: left;
          }
          #txtPickUpDate {
              width: 150px;
          }
          #txtAddress {
              width: 149px;
          }
          #txtProjectCode {
              width: 151px;
          }
          #txtMobile {
              width: 150px;
          }
          #txtApprover {
              width: 151px;
          }
          #txtPickUpDate0 {
              width: 144px;
          }
          .auto-style1 {
              text-align: left;
              height: 24px;
          }
          .auto-style2 {
              width: 20px;
              height: 24px;
          }
          .auto-style3 {
              height: 24px;
          }
          .auto-style4 {
              width: 50px;
              height: 24px;
          }
          #txtToDate {
              width: 151px;
          }
          .auto-style5 {
              font-size: large;
          }
          </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div id="accordion" > 
  <h3 tabindex="0" class="ui-accordion-header ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons" id="ui-id-1" role="tab" aria-expanded="true" aria-selected="true" aria-controls="ui-id-2">OnDemand Request</h3>
    </div>
    <table style="border:1px solid;" class="sorting">
        <tr>
<td colspan="8"><div style="color:red;font-weight:bold;width:100%;" id="errMsg">&nbsp;</div></td>
        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">Request Type</th>
            <td style="width:20px;">&nbsp;</td>
            <td>
                <input  name="rdRequestType" type="radio" checked="checked" value="SR" />SR &nbsp;&nbsp;<input name="rdRequestType" type="radio" value="Regular" />Shift</td>
            <td>
                &nbsp;</td>
             <td style="width:50px;">&nbsp;</td>
            <th class="newStyle2">
                Re-Occuring Request </th>
             <td style="width:20px;">&nbsp;</td>
             <td><input type="radio" name="rdReoccuringRequest"  value="Yes"/>Yes&nbsp;&nbsp;<input type="radio" name="rdReoccuringRequest" checked="checked"  value="No"/>No&nbsp;&nbsp;</td>
             <td style="width:50px;">&nbsp;</td>
            
        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">&nbsp;</th>
            <td style="width:20px;">&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
             <td style="width:50px;">&nbsp;</td>
            <th class="newStyle2">
                &nbsp;</th>
             <td style="width:20px;">&nbsp;</td>
             <td>&nbsp;</td>
             <td style="width:50px;">&nbsp;</td>
            
        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">Booking Type:</th>
            <td style="width:20px;"></td>
            <td><input type="radio" name="rdBooking" id="rdbtnlogin" value="LogIn"/>Login&nbsp;&nbsp;<input type="radio" id="rdbtnlogout" name="rdBooking"  value="LogOut"/>LogOut </td>
            <td>&nbsp;</td>
             <td style="width:50px;"></td>
            <th class="newStyle2">
               Gender:
            </th>
             <td style="width:20px;"></td>
             <td><input type="radio" name="rdGender" id="maleid"  value="MALE"/>Male&nbsp;&nbsp;<input type="radio"  id="Femaleid" name="rdGender"  value="FEMALE"/>Female </td>
             <td style="width:50px;"></td>
            
        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">
                DC Name :
            </th>
             <td style="width:20px;">&nbsp;</td>
            <td><select id="ddlDcName"  style="width:151px;" name="D2">                
                </select> <span class="auto-style5" style= "color:red">*</span></td>
           
            <td>&nbsp;</td>
           
             <td style="width:50px;">&nbsp;</td>
             <th class="newStyle2">
                 &nbsp;</th>
             <td style="width:20px;">&nbsp;</td>
            <td> &nbsp;</td>
            
        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">
               Route Name:
            </th>
             <td style="width:20px;"></td>
            <td><select id="ddlRoute"  style="width:151px;">                
                </select>&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
           
            <td>&nbsp;</td>
           
             <td style="width:50px;"></td>
             <th class="newStyle2">
                <span class="spnBookType">PickUp</span> Point:
            </th>
             <td style="width:20px;"></td>
            <td> <select id="ddlPickUps" class="validate[required]" style="width:151px;"> </select>&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
            
        </tr>
         <tr>
            <th class="auto-style1"> <span class="spnBookType1">PickUp</span> Date:             
            </th>
             <td class="auto-style2"></td>
            <td class="auto-style3"><input type="text" id="txtPickUpDate" class="validate[required] text-input" readonly="readonly" /><span class="auto-style5" style= "color:red">*</span></td>
            <td class="auto-style3">&nbsp;</td>
              <td class="auto-style4"></td>
            <th class="auto-style1">  </th>
             <td class="auto-style2"></td>
            <td class="auto-style3"></td>
        </tr>
         <tr>
            <th class="sorting">
              <span class="spnReoccuringRequest"><asp:Label ID="lblToDate" runat="server" Text="To Date:" ></asp:Label></span>
             </th>
             <td style="width:20px;">&nbsp;</td>
            <td><span class="spnReoccuringRequest"><input type="text" id="txtToDate" class="validate[required] text-input" readonly="readonly" disabled="disabled"  /><span class="auto-style5" style= "color:red">*</span></span></td>
            <td>&nbsp;</td>
              <td style="width:50px;">&nbsp;</td>
            <th class="newStyle2">  <span class="spnBookType2">LogOut</span> Time:            
            </th>
             <td style="width:20px;">&nbsp;</td>
            <td><select id="ddlPickUpTime" class="validate[required]" style="width:151px;" name="D1"> </select>&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
        </tr>
         <tr>
           <th class="sorting">  Address             
            </th>
             <td style="width:20px;"></td>
            <td>
                <textarea name="txtAddress" rows="2" id="txtAddress" class="validate[required]" maxlength="50"></textarea><span class="auto-style5" style= "color:red">*</span></td>
            <td>
                &nbsp;</td>
              <td style="width:50px;"></td>
            <th class="newStyle2">Mobile:              
            </th>
             <td style="width:20px;"></td>
            <td> <input id="txtMobile" name="txtMobile" class="validate[required] text-input" type="text" maxlength="10" />&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
        </tr>
         <tr>
           <th class="sorting">Project Code:               
            </th>
             <td style="width:20px;"></td>
            <td><input id="txtProjectCode" name="txtProjectCode" class="validate[required] text-input" type="text" maxlength="30" /><span class="auto-style5" style= "color:red">*</span></td>
            <td>&nbsp;</td>
              <td style="width:50px;"></td>
              <th class="newStyle2">Approver Name:               
            </th>
             <td style="width:20px;"></td>
            <td><input id="txtApprover" name="txtApprover" class="validate[required] text-input" type="text" maxlength="30" />@infosys.com&nbsp; <span class="auto-style5" style= "color:red">*</span></td>
           
        </tr>
         <tr>
           <th class="sorting">  Remarks:            
            </th>
             <td style="width:20px;"></td>
            <td><textarea name="txtRemarks" cols="40" rows="5" id="txtRemarks" maxlength="300"></textarea></td>
            <td>&nbsp;</td>
              <td style="width:50px;"></td>
            <td class="newStyle2">              
            </td>
             <td style="width:20px;"></td>
            <td></td>
        </tr>
         <tr>
           <td>               
            </td>
             <td style="width:20px;"></td>
            <td></td>
            <td>&nbsp;</td>
              <td style="width:50px;"></td>
            <td>              
            </td>
             <td style="width:20px;"></td>
            <td></td>
        </tr>
         <tr>
           <td colspan="8">               
               <asp:Label ID="lblErrorMsg" runat="server" Text="Field Marked * Are Mandatory" ForeColor="#FF3300"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="submit" style="position: relative; z-index: auto; width: 296px; left:400px; top: 0px;">
        <input type="button" id="btnReqSubmit" value="Submit" />
    </div>
</asp:Content>

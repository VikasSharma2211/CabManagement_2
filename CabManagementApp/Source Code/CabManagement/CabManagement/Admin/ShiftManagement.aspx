<%@ Page Title="Shift Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ShiftManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="../CSS/style.css" rel="stylesheet" />
     <link href="../CSS/jquery-ui.css" rel="stylesheet" />
    <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
     <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <%--validation--%>
    <script src="../Scripts/jquery.validationEngine-en.js"></script>
    <script src="../Scripts/jquery.validationEngine.js"></script>
    
    <!-- DataTables -->    
    <script src="../Scripts/DataTable/jquery.dataTables.js"></script>
    <script src="../Scripts/DatePicker/jquery-ui.js"></script>


    <script type="text/javascript">

        function shift(ShiftId, ShiftCategory, ShiftType, ShiftTime, DCID, IsActive) {
            this.ShiftId = ShiftId;
            this.ShiftCategory = ShiftCategory;
            this.ShiftType = ShiftType;
            this.ShiftTime = ShiftTime;
            this.DCID = DCID;
            this.IsActive = IsActive;           
        }

        var status = {
            activeStatus: "active",
            inActiveStatus: "inactive"
        };

        var statusRunning;

        $(document).ready(function () {
            //show active list initially
            statusRunning = status.activeStatus;
            $("#spnActiveInactive").text("InActivate");
            //code to load active all shift list
            GetActiveShiftList();
            //end code to load active all shift list
            GetDCList();

            //to show popup to create a new shift           
            $("#CreateShift").click(function () {
                //hide validation message if any
                $("#form1").validationEngine('hideAll');
               
                //hide update button and show submit button
                $("#btnSubmit").show();
                $("#btnUpdate").hide();

                $('#overlay-back').fadeIn(500, function () {
                    $('#popup').show();
                    ClearShift();
                });
            });


            $("#aInActiveShift").click(function () {
                GetInactiveShiftList();
                statusRunning = status.inActiveStatus;
                $("#spnActiveInactive").text("Activate");
            });

            $("#aActiveShift").click(function () {
                GetActiveShiftList();
                statusRunning = status.activeStatus;
                $("#spnActiveInactive").text("Inactivate");
            });

            //delete selected shifts
            $("#aDeleteShift").click(function () {
                var SelectedShiftIds = "";
                var countchecked = $("#tblLstShift input[type=checkbox]:checked").length;
                
                if (countchecked > 0) {
                    var strMsg = "";
                    if (statusRunning == status.activeStatus) {
                        strMsg = "Are you sure to inactivate the selected " + countchecked;
                    }
                    else {
                        strMsg = "Are you sure to activate the selected " + countchecked;
                    }

                    if (countchecked > 1) {
                        strMsg += " shifts?";
                    } else {
                        strMsg += " shift?";
                    }
                    if (confirm(strMsg)) {
                        // continue with delete
                        var chkSelected = $("#tblLstShift input[type=checkbox]:checked");
                        for (var index = 0; index < countchecked; index++) {
                            var id = chkSelected[index].attributes["id"].value.substring(3);
                            SelectedShiftIds += id + ",";
                        }
                        if (SelectedShiftIds != "") {
                            SelectedShiftIds = SelectedShiftIds.substring(0, SelectedShiftIds.length - 1);
                            ActiveInactiveShift(SelectedShiftIds);
                        }

                    }
                }
                else {
                    if (statusRunning == status.activeStatus) {
                        alert("Select atleast 1 shift to inactivate!!!");
                    }
                    else {
                        alert("Select atleast 1 shift to activate!!!");
                    }                  
                }

            });

            $(".close-image").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(500);
            });
            $("#btnCancel").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(500);
                ClearShift();
            });
            //to insert new shift
            $("#btnSubmit").on('click', function () {

                var valid = $("#form1").validationEngine('validate');
                if (valid) {
                //    e.preventDefault();
                    var objShift = new shift();
                    objShift.ShiftType = $("#" + "<%=ddlShiftType.ClientID%>" + "").val();
                    objShift.ShiftTime = $("#" + "<%=ddlShiftTypeHour.ClientID%>" + "").val() + ":" + $("#" + "<%=ddlShiftTypeMin.ClientID%>" + "").val();
                    objShift.ShiftCategory = $("#" + "<%=ddlCategory.ClientID%>" + "").val(); 
                    objShift.DCID = $("#ddlDC").val();
                  

                    $.ajax({
                        type: "POST",
                        url: "ShiftManagement.aspx/AddNewShift",
                        data: "{'shift':" + JSON.stringify(objShift) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == 'Exists') {
                               alert("Shift Already Exist")
                            }
                            else {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(500);
                                alert("Shift Added Successfully")
                                GetActiveShiftList();
                                statusRunning = status.activeStatus;
                                $("#spnActiveInactive").text("InActivate");
                                //alert("Error Occured");
                            }

                        },
                        error: function (er) {
                            alert(er);
                        }
                    })
                }
                
            });
           
        //to update existing shift
            $("#btnUpdate").on('click', function () {
                var valid = $("#form1").validationEngine('validate');
                if (valid) {
                    var objShift = new shift();
                    objShift.ShiftId = $("#hdnShiftId").text();
                    objShift.ShiftType = $("#" + "<%=ddlShiftType.ClientID%>" + "").val();
                    objShift.ShiftTime = $("#" + "<%=ddlShiftTypeHour.ClientID%>" + "").val() + ":" + $("#" + "<%=ddlShiftTypeMin.ClientID%>" + "").val();
                    objShift.ShiftCategory = $("#" + "<%=ddlCategory.ClientID%>" + "").val();
                    objShift.DCID = $("#ddlDC").val();


                    $.ajax({
                        type: "POST",
                        url: "ShiftManagement.aspx/UpdateShift",
                        data: "{'shift':" + JSON.stringify(objShift) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == 'Exists') {
                                alert("Shift Already Exist")
                            }
                            else {                            
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(500);
                                if (statusRunning == status.activeStatus) {
                                    GetActiveShiftList();
                                    $("#spnActiveInactive").text("Inactivate");
                                }
                                else {
                                    GetInactiveShiftList();
                                    $("#spnActiveInactive").text("Activate");
                                }                                
                            }
                        },
                        error: function (er) {
                            alert(er);
                        }
                    })
                }
        });

        });

        function ActiveInactiveShift(SelectedShiftIds)
        {
            var isActive;
            if (statusRunning == status.activeStatus) {
                isActive = false;
            }
            else {
                isActive = true;
            }
            $.ajax({
                type: "POST",
                url: "ShiftManagement.aspx/DeleteSelectedShift",
                data: "{'shiftIds':'" + SelectedShiftIds + "','IsActive':'" + isActive + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                        if (statusRunning == status.activeStatus) {
                            GetActiveShiftList();
                            $("#spnActiveInactive").text("Inactivate");
                        }
                        else {
                            GetInactiveShiftList();
                            $("#spnActiveInactive").text("Activate");
                        }                       
                    }
                    else {
                        alert("Error Occured");
                    }

                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function GetActiveShiftList() {
            $.ajax({
                type: "POST",
                url: "ShiftManagement.aspx/GetActiveShiftList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listShift = result.d;
                    if (listShift == null)
                        listShift = [];
                    $('#tblLstShift').dataTable({
                        destroy: true,
                        paging: true,
                        "bsorting": true,
                        "data": listShift,
                        "aoColumns": [
                            {
                                "data": "ShiftId", "bSortable": false, render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                            //{ "data": "ShiftId" },
                             { "data": "ShiftCategory" },
                            { "data": "ShiftType" },
                            { "data": "ShiftTime" },
                            { "data": "DcName" },
                            {
                                "data": "IsActive", "bSortable": false, render: function (data, type, row) {
                                    if (data) {
                                        return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";
                                    }
                                    else {
                                        return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                                    }


                                }
                            },
                             {
                                 "data": "ShiftId", "bSortable": false, render: function (data, type, row) {
                                     var strReturn = "<a id='" + data + "' href='#' onClick='EditShift(this)'>Edit</a>";
                                     if (row.IsActive) {
                                         strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected shift?\")) ActiveInactiveShift(" + data + ");else return false;'>Inactivate</a>";
                                     }
                                     else {
                                         strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected shift?\")) ActiveInactiveShift(" + data + ");else return false;'>Activate</a>";
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

        function GetInactiveShiftList() {
            $.ajax({
                type: "POST",
                url: "ShiftManagement.aspx/GetInactiveShiftList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listShift = result.d;
                    if (listShift == null)
                        listShift = [];
                    $('#tblLstShift').dataTable({
                        destroy: true,
                        paging: true,
                        "bStateSave": true,
                        "bsorting": true,
                        "data": listShift,
                        "aoColumns": [
                            {
                                "data": "ShiftId", "bSortable": false, render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                            //{ "data": "ShiftId" },
                            { "data": "ShiftCategory" },
                            { "data": "ShiftType" },
                            { "data": "ShiftTime" },
                            { "data": "DcName" },
                             {
                                 "data": "IsActive", "bSortable": false, render: function (data, type, row) {
                                     if (data) {
                                         return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";
                                     }
                                     else {
                                         return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                                     }


                                 }
                             },
                             {
                                 "data": "ShiftId", "bSortable": false, render: function (data, type, row) {
                                     var strReturn = "<a id='" + data + "' href='#' onClick='EditShift(this)'>Edit</a>";
                                     if (row.IsActive) {
                                         strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected shift?\")) ActiveInactiveShift(" + data + ");else return false;'>Inactivate</a>";
                                     }
                                     else {
                                         strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected shift?\")) ActiveInactiveShift(" + data + ");else return false;'>Activate</a>";
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

        function GetDCList() {
            $.ajax({
                type: "POST",
                url: "ShiftManagement.aspx/GetDCList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var dcJSON = result.d;
                    if (dcJSON != null) {
                        $.each(dcJSON, function (index, value) {
                            $('#ddlDC').append($("<option></option>").val(value.DCID).html(value.DCName));
                        });
                    }
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function EditShift(e) {
            //hide validation message if any
            $("#form1").validationEngine('hideAll');
            //hide update button and show submit button
            $("#btnSubmit").hide();
            $("#btnUpdate").show();
            $("#hdnShiftId").text(e.attributes["id"].value);
            //get parent row
            var row = $(e).parent().parent();
            var tdShiftCategory = row[0].cells[1].innerText;//ShiftCategory //index 0 for checkbox
            var tdShiftType = row[0].cells[2].innerText;//ShiftType             
            var tdShiftTime = row[0].cells[3].innerText;//ShiftTime 07:50:00
            var tdDcName = row[0].cells[4].innerText;//DCID
            
            //var tdCreatedDate = row[0].cells[3].innerText;//CreatedDate
            //var tdCreatedBy = row[0].cells[4].innerText;//CreatedBy
            //var tdModiFiedDate = row[0].cells[5].innerText;//ModiFiedDate
            //var tdModifiedBy = row[0].cells[6].innerText;//ModiFiedBy
           
          
           
  
  

            var hr = tdShiftTime.substring(0,tdShiftTime.indexOf(":"));
    
            var min = tdShiftTime.substring(tdShiftTime.indexOf(":") + 1);
          
            $('#overlay-back').fadeIn(500, function () {
                $('#popup').show();
            });
     
            //set ddl For DC
            $("#ddlDC option").each(function () {
                if ($(this).text().trim() == tdDcName.trim()) {
                    $(this).attr('selected', 'selected');
                }
            });

       
            $("#" + "<%=ddlCategory.ClientID%>" + " option").each(function () {
                if ($(this).text().trim() == tdShiftCategory.trim()) {
                    $(this).attr('selected', 'selected');
                }
            });

            //set ddl
            $("#" + "<%=ddlShiftType.ClientID%>" + " option").each(function () {               
                if ($(this).text().trim() == tdShiftType.trim()) {                    
                    $(this).attr('selected', 'selected');
                } 
            });

            $("#" + "<%=ddlShiftTypeHour.ClientID%>" + " option").each(function () {
                if ($(this).attr('selected') == "selected") {
                    $(this).removeAttr("selected");
                }
                if ($(this).text().trim() == hr) {
                    $(this).attr('selected', 'selected');
                }
            });
            $("#" + "<%=ddlShiftTypeMin.ClientID%>" + " option").each(function () {
                if ($(this).attr('selected') == "selected") {
                    $(this).removeAttr("selected");
                }
                if ($(this).text().trim() == min) {
                    $(this).attr('selected', 'selected');
                }
            });
                                                                      
                                                                                  
                                                                             
            

        }

        function ClearShift() {
            $("#" + "<%=ddlShiftType.ClientID%>" + "").val("");
            $("#" + "<%=ddlShiftTypeHour.ClientID%>"+ ""). val("");
            $("#" + "<%=ddlShiftTypeMin.ClientID%>" + "").val("");
            $("#" + "<%=ddlCategory.ClientID%>" + "").val("");           
            //$("#ddlDC").val("");
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
              <td>  <a href="#" id="CreateShift">Add New Shift</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aActiveShift">View Active Shift</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aInActiveShift">View Inactive Shift</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aDeleteShift"><span id="spnActiveInactive">InActivate</span> Selected Shift</a></td>
          </tr>
      </table>
  </div>
      
</div>   
  
         <br />
    <br />


    <table width="100%" class="display paddingtop15" id="tblLstShift" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Select</th>
                <%--<th>ShiftId</th>--%>
                <th>Category</th>
                <th>Type</th>
                <th>Time</th>
                <th>DcName</th>
                 <th class="width37">Status</th>
                <th class="width73">Action </th>
            </tr>
        </thead>

    </table>

 
   

    <div id="popup"><img class="close-image" src="../Images/close.png" />
    <fieldset>
        <label>
           <b>Enter Shift Details</b>
        </label>
    </fieldset>
    <tab    le>
        <tr class="displayNone">
            <td></td><td><input id="hdnShiftId" type="hidden" value="" /></td>
        </tr>

        <tr>
            <td>Select DC:</td>
            <td><select id="ddlDC"  class="validate[required] ddlwidth120"></select></td>
        </tr>
        <tr>
            <td>Select Category:</td>
            <td>
                 <asp:DropDownList ID="ddlCategory"  CssClass="validate[required] ddlwidth120" runat="server" >
                 <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                    <asp:ListItem>Regular</asp:ListItem>
                    <asp:ListItem>SR</asp:ListItem>    
                     </asp:DropDownList>            
               </td>
        </tr>
        <tr>
            <td>Shift Type:</td>
            <td>
                         <asp:DropDownList ID="ddlShiftType"  CssClass="validate[required] ddlwidth120" runat="server" >
                     <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                    <asp:ListItem>LogIn</asp:ListItem>
                    <asp:ListItem>LogOut</asp:ListItem>
                </asp:DropDownList>
                
       
                
            </td>
        </tr>
        <tr>
            <td>ShiftTime:</td>
            <td>               
                <asp:DropDownList ID="ddlShiftTypeHour"   CssClass="validate[required] ddlwidth120" runat="server"  >
                    <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                     <asp:ListItem>07</asp:ListItem>
                     <asp:ListItem>08</asp:ListItem>

                     <asp:ListItem>09</asp:ListItem>
                     <asp:ListItem>10</asp:ListItem>
                     <asp:ListItem>11</asp:ListItem>
                     <asp:ListItem>12</asp:ListItem>
                     <asp:ListItem>13</asp:ListItem>
                     <asp:ListItem>14</asp:ListItem>
                     <asp:ListItem>15</asp:ListItem>
                     <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                    <asp:ListItem>24</asp:ListItem>
                </asp:DropDownList>&nbsp;Hr &nbsp;&nbsp;
                <asp:DropDownList ID="ddlShiftTypeMin" CssClass="validate[required] ddlwidth120" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                </asp:DropDownList>&nbsp;Min
            </td>
        </tr>
        
      <tr>
            <td></td>
            <td><input id="btnSubmit" type="button" value="Submit" />
                <input id="btnUpdate" type="button" value="Update" />
            &nbsp;&nbsp;<input id="btnCancel" type="button" value="Cancel" /></td>
            
        </tr>
    </tab>
        </div>

    <div id="overlay-back"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").validationEngine({
                // Auto-hide prompt
                autoHidePrompt: true,
                // Delay before auto-hide
                autoHideDelay: 2000,
                // Fade out duration while hiding the validations
                fadeDuration: 0.3           
            });
        });
     </script>   
</asp:Content>

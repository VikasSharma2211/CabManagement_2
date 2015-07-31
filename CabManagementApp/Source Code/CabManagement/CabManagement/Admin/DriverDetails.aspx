<%@ Page Title="Driver Details" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DriverDetails.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.DriverDetails" %>
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

        function Driver(DriverId, DriverCode, DriverName,DCID,DCName,EmpanelDate, ModifyDate, ModifyBy, IsActive) {
            this.DriverId = DriverId;
            this.DriverCode = DriverCode;
            this.DriverName = DriverName;
            this.DCID = DCID;
            this.DCName = DCName;
            this.EmpanelDate = EmpanelDate;
            this.ModifyDate = ModifyDate;
            this.ModifyBy = ModifyBy;
            this.IsActive = IsActive;

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
            GetDriverList();
            GetDCList();
            $('#ddlDCName').append($("<option>").val(0).text('–Select–'));
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

            $("#aInActiveDriver").click(function () {
                GetInActiveDriverDetail();
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
                var countchecked = $("#tblLstDriver input[type=checkbox]:checked").length;

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
                        var chkSelected = $("#tblLstDriver input[type=checkbox]:checked");
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

            //$("#frmdriver").submit(function (e) {
            //    
            //    var valid = $("#frmdriver").validationEngine('validate');
            //    if (valid) {
            //        e.preventDefault();
                  
            //        InsertNewDriver();
            //        ClearDriverDetail();
            //    }
            //});

            $("#btnSubmit").click(function (e) {
              
            var valid = $("#frmdriver").validationEngine('validate');
            if (valid) {
                e.preventDefault();

                InsertNewDriver();
                ClearDriverDetail();
            }
            });

            //to update existing vendor
            $("#btnUpdate").on('click', function () {
                
                var valid = $("#frmdriver").validationEngine('validate');
                var isActive = null;
                if (statusRunning == 'active')
                {
                    isActive = true;
                }
                else
                {
                    isActive = false;
                }

                if (valid) {
                    var objDriver = new Driver();
                  
                    objDriver.DriverId = $("#hdndriverId").text();
                    objDriver.DriverName = $("#txtDriverName").val();
                    objDriver.DriverCode = $("#txtDriverCode").val();
                    objDriver.DCID = $("#ddlDCName").val();
                    objDriver.DCName = $("ddlDCName").text();
                    objDriver.EmpanelDate = $("#txtEmpanelDate").val();
                    objDriver.IsActive = isActive;
                  

                    $.ajax({
                        type: "POST",
                        url: "DriverDetails.aspx/UpdateDriver",
                        data: "{'DriverDetail':" + JSON.stringify(objDriver) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == '-1') {
                                alert("Driver Code Already Exist");
                            }

                            else {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(100);
                                if (statusRunning == status.activeStatus) {
                                    ClearDriverDetail();
                                    GetActiveDriverDetail();
                                    $("#spnActiveInactive").text("Inactivate");
                                }
                                else {
                                    GetInActiveDriverDetail();
                                    $("#spnActiveInactive").text("Activate");
                                }
                            }
                            

                        },
                        error: function (er) {
                            alert(er.responseText);
                        }
                    })
                }
            });

        });
        function hideValidation() {
            $('#txtEmpanelDate').validationEngine('hide');
        }

        //For DC List
        function GetDCList() {
            $.ajax({
                type: "POST",
                url: "CabManagement.aspx/GetDCList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var dcJSON = result.d;
                    if (dcJSON != null) {
                        $.each(dcJSON, function (index, value) {
                            $('#ddlDCName').append($("<option></option>").val(value.DCID).html(value.DCName));
                        });
                    }
                },
                error: function (er) {
                    alert(er);
                }
            });
        }

        function GetDriverList() {
                
                $.ajax({
                type: "POST",
                url: "DriverDetails.aspx/GetDriverList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                   
                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstDriver').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "DriverId", "bSortable": false, "sClass": "center", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                          
                            { "data": "DriverName" },
                            { "data": "DriverCode" },
                            { "data": "DCName" },
                            { "data": "EmpanelDate", "bSearchable": false },
                           
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
                                "data": "DriverId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditDriver(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Activate</a>";
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

        function InsertNewDriver()
        {
            
            objDriver = new Driver();
            objDriver.DriverName = $("#txtDriverName").val();
            objDriver.DriverCode = $("#txtDriverCode").val();
            objDriver.DCID = $("#ddlDCName").val();
            objDriver.DCName = $("ddlDCName").text();
            objDriver.EmpanelDate = $("#txtEmpanelDate").val();
            if (objDriver.DriverName != '' & objDriver.DriverCode != '' & objDriver.EmpanelDate !='') {
                
                    $.ajax({
                        type: "POST",
                        url: "DriverDetails.aspx/InsertDriverDetail",
                        data: "{'DriverDetail':" + JSON.stringify(objDriver) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == '-1') {
                                alert("Driver Code Already Exist");
                            }
                            else {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(100);
                                alert("Driver Details Added Successfully")
                                ClearDriverDetail();
                                GetActiveDriverDetail();
                                statusRunning = status.activeStatus;
                                $("#spnActiveInactive").text("Inactivate");
                            }


                        },
                        error: function (er) {
                            alert(er);
                        }
                    });
               
            }
            else {
                alert("Please Fill All Details")
            }






        }
        function EditDriver(e)
        {
            //hide validation message if any
            $("#frmdriver").validationEngine('hideAll');
            //hide update button and show submit button
            $("#btnSubmit").hide();
            $("#btnUpdate").show();
            $("#hdndriverId").text(e.attributes["id"].value);

            //get parent row
            var row = $(e).parent().parent();
            var tdDriverName = row[0].cells[1].innerText;//DriverName    //index 0 for checkbox
            var tdDriverCode = row[0].cells[2].innerText;//DriverCode
            var tdDCName = row[0].cells[3].innerText//DCID
            var tdEmpanelDate = row[0].cells[4].innerText;//DriverEmpanelDate

            $('#overlay-back').fadeIn(100, function () {
                $('#popup').show();
            });
             
            $("#txtDriverName").val(tdDriverName);
            $("#txtDriverCode").val(tdDriverCode);
            $("#ddlDCName option").each(function () {
                console.log("ddl TEXT :'" + $(this).text().trim() + "'       DCName:" + tdDCName.trim());
                if ($(this).text().trim() == tdDCName.trim()) {
                    $(this).attr('selected', 'selected');
                    $(this).change();
                }
            });
            $("#txtEmpanelDate").val(tdEmpanelDate);
            
        }

        function GetActiveDriverDetail()
        {
            $.ajax({
                type: "POST",
                url: "DriverDetails.aspx/GetActiveDriverList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstDriver').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "DriverId", "bSortable": false, "sClass": "center", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },

                            { "data": "DriverName" },
                            { "data": "DriverCode" },
                            { "data": "DCName" },
                            { "data": "EmpanelDate", "bSearchable": false },

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
                                "data": "DriverId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditDriver(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Activate</a>";
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
        function GetInActiveDriverDetail()
        {
            $.ajax({
                type: "POST",
                url: "DriverDetails.aspx/GetInActiveDriverList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    var listDriver = result.d;
                    if (listDriver == null)
                        listDriver = [];
                    $('#tblLstDriver').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listDriver,
                        "aoColumns": [
                            {
                                "data": "DriverId", "bSortable": false, "sClass": "center", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },

                            { "data": "DriverName" },
                            { "data": "DriverCode" },
                            { "data": "DCName" },
                            { "data": "EmpanelDate", "bSearchable": false },

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
                                "data": "DriverId", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditDriver(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected Driver?\")) ActiveInactiveDriver(" + data + ");else return false;'>Activate</a>";
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

        function ActiveInactiveDriver(SelectedDriverId)
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
                url: "DriverDetails.aspx/DeleteSelectedDriver",
                data: "{'DriverId':'" + SelectedDriverId + "','Comment':'','IsActive':'" + isActive + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                        if (statusRunning == status.activeStatus) {
                            GetActiveDriverDetail();
                            $("#spnActiveInactive").text("Inactivate");
                        }
                        else {
                            GetInActiveDriverDetail();
                            $("#spnActiveInactive").text("Activate");
                        }
                       // ClearCabDetail();

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
        function ClearDriverDetail()
        {
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
              <td> <a href="#" id="aCreateDriver">Add New Driver</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aActiveDriver">View Active Driver</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aInActiveDriver">View Inactive Driver</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aDeleteDriver"><span id="spnActiveInactive">InActivate</span> Selected Driver</a></td>
          </tr>
      </table>
  </div>
      
</div>
         <br />
    <br />
    <table width="100%" class="cell-border paddingtop15" id="tblLstDriver" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Select</th>
                <th>DriverName</th>
                <th>DriverCode</th>
                <th>DCName</th>
                <th>EmpanelDate</th>
                <th class="width20">Status</th>             
                <th>Action </th>
            </tr>
        </thead>

    </table>

 
       <div id="popup"><img class="close-image" src="../Images/close.png" />
        
         <form id="frmdriver" method="post">
    <fieldset>
        <label>
           <b>Enter Driver Details:</b>
        </label>
    </fieldset>
       
    <table>
        <tr class="displayNone">
            <td></td><td><input id="hdndriverId" type="hidden" value="" /></td>
        </tr>
        <tr>
            <td>Driver Name:</td>
            <td>
                <input id="txtDriverName" name="txtDriverName" class="validate[required]"  type="text" maxlength="50" />
            </td>
        </tr>
        <tr>
            <td>Driver Code:</td>
            <td>
                 <input id="txtDriverCode" name="txtDriverCode" class="validate[required]"  type="text" maxlength="50" />
                              
            </td>
        </tr>
          <tr>
                  <td>DC Name:</td>
                  <td><select id ="ddlDCName" style="width: 152px; "  class="validate[required]"></select></td>
          </tr>
        <tr>
           <td>EmpanelDate:</td>
            <td> <input type="text" id="txtEmpanelDate" readonly="readonly" class="validate[required]" /></td>
        </tr>
             
        <tr>
            <td></td>
            <td><input id="btnSubmit" class="submit" type="submit" value="Submit" />                
                <input id="btnUpdate" type="button" value="Update" />
            &nbsp;&nbsp;<input id="btnCancel" type="button" value="Cancel" /></td>
            
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

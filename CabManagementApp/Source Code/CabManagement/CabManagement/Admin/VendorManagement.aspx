<%@ Page Title="Vendor Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="VendorManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.WebForm1" %>

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

    <script type="text/javascript">

        function vendor(VendorID, VendorName, Address, City, EmpanelDate, DCName, Comment,IsActive) {
            this.VendorID = VendorID;
            this.VendorName = VendorName;
            this.Address = Address;
            this.City = City;
            this.EmpanelDate = EmpanelDate;
            this.DCName = DCName;
            this.Comment = Comment;
            this.IsActive = IsActive;
        }

        var status = {
            activeStatus: "active",
            inActiveStatus:"inactive"
        };

        var statusRunning;

        $(document).ready(function () {
            $("#pageloaddiv").fadeIn(500);
            $('#overlay-back').fadeIn(500);
            //code to load active all vendor list
            GetActiveVendorList();
            $("#pageloaddiv").fadeOut(500);
            $('#overlay-back').fadeOut(500);
            //end code to load active all vendor list
            GetDCList();
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
            $("#aCreateVendor").click(function () {
                //hide validation message if any
                $("#frmVendor").validationEngine('hideAll');
                //hide update button and show submit button
                $("#btnSubmit").show();
                $("#btnUpdate").hide();                

                $('#overlay-back').fadeIn(100, function () {
                    $('#popup').show();   
                    ClearVendor();
                });
            });

            $("#aInActiveVendor").click(function () {
                GetInActiveVendorList();
                statusRunning = status.inActiveStatus;
                $("#spnActiveInactive").text("Activate");
            });

            $("#aActiveVendor").click(function () {
                GetActiveVendorList();
                statusRunning = status.activeStatus;
                $("#spnActiveInactive").text("Inactivate");
            });

            //delete selected vendors
            $("#aDeleteVendor").click(function () {
                var SelectedVendorIds = "";
                var countchecked = $("#tblLstVendor input[type=checkbox]:checked").length;

                if (countchecked > 0) {
                    var strMsg = "";
                    if (statusRunning == status.activeStatus) {
                        strMsg = "Are you sure to inactivate the selected " + countchecked;
                    }
                    else {
                        strMsg = "Are you sure to activate the selected " + countchecked;
                    }
                    
                    if (countchecked > 1)
                    {
                        strMsg += " vendors?";
                    } else
                    {
                        strMsg += " vendor?";
                    }
                    if (confirm(strMsg)) {
                        // continue with delete
                        var chkSelected = $("#tblLstVendor input[type=checkbox]:checked");                        
                        for(var index=0;index<countchecked;index++)
                        {
                            var id = chkSelected[index].attributes["id"].value.substring(3);
                            SelectedVendorIds += id + ",";
                        }
                        if (SelectedVendorIds != "")
                        {
                            SelectedVendorIds = SelectedVendorIds.substring(0, SelectedVendorIds.length - 1);
                            ActiveInactiveVendor(SelectedVendorIds);
                        }
                        
                    }
                }
                else {
                    if (statusRunning == status.activeStatus) {
                        alert("Select atleast 1 vendor to inactivate!!!");
                    }
                    else {
                        alert("Select atleast 1 vendor to activate!!!");
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
                ClearVendor();
            });
            
            $("#frmVendor").submit(function (e) {
                
                var valid = $("#frmVendor").validationEngine('validate');
                if (valid)
                {
                    e.preventDefault();
                    InsertNewVendor();
                }
            });

            //$("#btnSubmit").click(function () {
            //    InsertNewVendor();
            //});
            
            //to update existing vendor
            $("#btnUpdate").on('click', function () {
                var valid = $("#frmVendor").validationEngine('validate');
                if (valid) {
                    var objVendor = new vendor();
                    objVendor.VendorID = $("#hdnVendorId").text();
                    objVendor.VendorName = $("#txtVendorName").val();
                    objVendor.Address = $("#txtAddress").val();
                    objVendor.City = $("#txtCity").val();
                    objVendor.EmpanelDate = $("#txtEmpanelDate").val();
                    objVendor.DCID = $("#ddlDC").val();
                    objVendor.Comment = $("#txtComment").val();

                    $.ajax({
                        type: "POST",
                        url: "VendorManagement.aspx/UpdateVendor",
                        data: "{'vendor':" + JSON.stringify(objVendor) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg=='1') {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(100);
                                if (statusRunning == status.activeStatus)
                                    {
                                    GetActiveVendorList();
                                    $("#spnActiveInactive").text("Inactivate");
                                }
                                else
                                {
                                    GetInActiveVendorList();
                                    $("#spnActiveInactive").text("Activate");
                                }
                            }
                            else if (msg == '-1')
                            {
                                alert("Vendor Name All Ready Exists");
                            }
                            else
                            {
                                alert("Vendor With The Same Data Already Exists")
                            }

                        },
                        error: function (er) {
                            alert(er);
                        }
                    })
                }
            });

        });

        function hideValidation()
        {
            $('#txtEmpanelDate').validationEngine('hide');
        }
        
        function ActiveInactiveVendor(SelectedVendorIds)
        {
            var isActive;
            if (statusRunning == status.activeStatus)
            {
                isActive=false;
            }
            else
            {
                isActive=true;
            }
            $.ajax({
                type: "POST",
                url: "VendorManagement.aspx/DeleteSelectedVendor",
                data: "{'vendorIds':'" + SelectedVendorIds + "','Comment':'','IsActive':'"+isActive+"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                        if (statusRunning == status.activeStatus) {
                            GetActiveVendorList();
                            $("#spnActiveInactive").text("Inactivate");
                        }
                        else {
                            GetInActiveVendorList();
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

        function InsertNewVendor()
        {
            //alert("call insertnewVendor");
            //return false;
            //alert("wwwwwww");
            var objVendor = new vendor();
            objVendor.VendorName = $("#txtVendorName").val();
            objVendor.Address = $("#txtAddress").val();
            objVendor.City = $("#txtCity").val();
            objVendor.EmpanelDate = $("#txtEmpanelDate").val();
            objVendor.DCID = $("#ddlDC").val();
            objVendor.Comment = $("#txtComment").val();

            $.ajax({
                type: "POST",
                url: "VendorManagement.aspx/AddNewVendor",
                data: "{'vendor':" + JSON.stringify(objVendor) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg==1) {
                        $('#popup').hide();
                        $('#overlay-back').fadeOut(100);
                        alert("Vendor Added Successfully");
                        GetActiveVendorList();
                        statusRunning = status.activeStatus;
                        $("#spnActiveInactive").text("Inactivate");
                    }
                    else
                    {
                        alert("Vendor Already Exists");
                    }

                },
                error: function (er) {
                    alert(er);
                }
            });
        }

             

        function GetActiveVendorList()
        {
            
            $.ajax({
                type: "POST",
                url: "VendorManagement.aspx/GetActiveVendorList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listVendor = result.d;
                    if (listVendor == null)
                        listVendor = [];
                    $('#tblLstVendor').dataTable({                        
                        destroy: true,
                        paging: true,
                        
                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listVendor,
                        "aoColumns": [
                            {
                                "data": "VendorID", "bSortable": false, "sClass": "center", render: function (data, type, row) {
                                    return "<input id='chk"+data+"' type='checkbox'/>";
                                }
                            },
                            { "data": "VendorName"},
                            { "data": "Address" },
                            { "data": "City" },
                            { "data": "EmpanelDate", "bSearchable": false },
                            { "data": "DCName", "bSearchable": false },
                            { "data": "Comment", "bSortable": false, "bSearchable": false },
                            { "data": "CreatedBy", "bSearchable": false },
                            {
                                "data": "IsActive", "bSortable": false, render: function (data, type, row) {
                                    if (data)
                                    {
                                        return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";
                                    }
                                    else
                                    {
                                        return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                                    }

                                   
                                }
                            },
                            {
                                "data": "VendorID", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditVendor(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected vendor?\")) ActiveInactiveVendor(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected vendor?\")) ActiveInactiveVendor(" + data + ");else return false;'>Activate</a>";
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

        function GetInActiveVendorList() {

            $.ajax({
                type: "POST",
                url: "VendorManagement.aspx/GetInActiveVendorList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listVendor = result.d;
                    if (listVendor == null)
                        listVendor = [];
                    $('#tblLstVendor').dataTable({
                        destroy: true,
                        paging: true,

                        //"bsorting":false,
                        //"sLoadingRecords":"Loading............",
                        "bStateSave": true,
                        "data": listVendor,
                        "aoColumns": [
                            {
                                "data": "VendorID", "bSortable": false, "sClass": "center", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                            { "data": "VendorName" },
                            { "data": "Address" },
                            { "data": "City" },
                            { "data": "EmpanelDate", "bSearchable": false },
                            { "data": "DCName", "bSearchable": false },
                            { "data": "Comment", "bSortable": false, "bSearchable": false },
                            { "data": "CreatedBy", "bSearchable": false },
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
                                "data": "VendorID", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditVendor(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected vendor?\")) ActiveInactiveVendor(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected vendor?\")) ActiveInactiveVendor(" + data + ");else return false;'>Activate</a>";
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
                url: "VendorManagement.aspx/GetDCList",
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

        function EditVendor(e)
        {
            //hide validation message if any
            $("#frmVendor").validationEngine('hideAll');
            //hide update button and show submit button
            $("#btnSubmit").hide();
            $("#btnUpdate").show();

            $("#hdnVendorId").text(e.attributes["id"].value);

            //get parent row
            var row = $(e).parent().parent();
            var tdVendorName = row[0].cells[1].innerText;//VendorName    //index 0 for checkbox
            var tdAddress = row[0].cells[2].innerText;//Address
            var tdCity = row[0].cells[3].innerText;//City
            var tdEmpanelDate = row[0].cells[4].innerText;//EmpanelDate
            var tdDCName = row[0].cells[5].innerText;//DCName
            var tdComment = row[0].cells[6].innerText;//Comment
            var tdCreatedBy = row[0].cells[7].innerText;//CreatedBy
            
            $('#overlay-back').fadeIn(100, function () {
                $('#popup').show();                
            });
            
            
            $("#txtVendorName").val(tdVendorName);
            $("#txtAddress").val(tdAddress);
           $("#txtCity").val(tdCity);
           $("#txtEmpanelDate").val(tdEmpanelDate);
            //set ddl
           $("#ddlDC option").each(function () {
               if ($(this).text().trim() == tdDCName.trim()) {
                   $(this).attr('selected', 'selected');
               }
           });
           $("#txtComment").val(tdComment);
           
        }

        function ClearVendor()
        {
            $("#txtVendorName").val("");
            $("#txtAddress").val("");
            $("#txtCity").val("");
            $("#txtEmpanelDate").val("");
            $("#txtComment").val("");
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
              <td> <a href="#" id="aCreateVendor">Add New Vendor</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aActiveVendor">View Active Vendors</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aInActiveVendor">View Inactive Vendors</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aDeleteVendor"><span id="spnActiveInactive">InActivate</span> Selected Vendors</a></td>
          </tr>
      </table>
  </div>
      
</div>
         <br />
    <br />
    <table width="100%" class="cell-border paddingtop15" id="tblLstVendor" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Select</th>
                <th>VendorName</th>
                <th>Address</th>
                <th>City</th>
                <th>EmpanelDate</th>
                <th>DCName</th>
                <th>Comment</th>
                <th>CreatedBy</th>    
                <th class="width20">Status</th>             
                <th>Action </th>
            </tr>
        </thead>

    </table>

 
       
 
 </form>
    <div id="popup"><img class="close-image" src="../Images/close.png" />
        
         <form id="frmVendor" method="post">
    <fieldset>
        <label>
           <b>Enter Vendor Details:</b>
        </label>
    </fieldset>
       
    <table>
        <tr class="displayNone">
            <td></td><td><input id="hdnVendorId" type="hidden" value="" /></td>
        </tr>
        <tr>
            <td>Vendor Name:</td>
            <td>
                <input id="txtVendorName" name="txtVendorName" class="validate[required]"  type="text" maxlength="50" />
            </td>
        </tr>
        <tr>
            <td>Address:</td>
            <td>
                <asp:TextBox ID="txtAddress" CssClass="validate[required]"  runat="server" ClientIDMode="Static" TextMode="MultiLine" MaxLength="50"></asp:TextBox>                              
            </td>
        </tr>
        <tr>
            <td>City:</td>
            <td>
                <input id="txtCity" name="txtCity" class="validate[required]" type="text" maxlength="50" />
            </td>
        </tr>
        <tr>
            <td>EmpanelDate:</td>
            <td> <input type="text" id="txtEmpanelDate" readonly="readonly" class="validate[required]" /></td>
        </tr>
        <tr>
            <td>DC Related to:</td>
            <td>
                <select id="ddlDC" class="validate[required]"></select></td>
        </tr>
        <tr>
            <td>Any Comment:</td>
            <td>
                <%--<textarea name="txtComment" class="width147" cols="20" rows="3" id="txtComment" maxlength="300"></textarea> 
              <div contenteditable="true" class="validate[required] likeTextArea"></div>--%>
                <asp:TextBox ID="txtComment" runat="server" ClientIDMode="Static" TextMode="MultiLine" MaxLength="300"></asp:TextBox>
            </td>
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
            $("#frmVendor").validationEngine({
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

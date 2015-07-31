<%@ Page Title="Property Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PropertyManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.WebForm4" %>
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

           function Property(PropertyId, PropertyName, ExpiryDate, IsCompulsory, IsActive) {
               this.PropertyId = PropertyId;
               this.PropertyName = PropertyName;
               this.ExpiryDate = ExpiryDate;
               this.IsCompulsory = IsCompulsory;
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
               //code to load active all vendor list
               GetActivePropertyList();
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
               $("#aCreateProperty").click(function () {
                   //hide validation message if any
                   $("#form1").validationEngine('hideAll');
                   //hide update button and show submit button
                   ClearProperty();
                   $("#btnSubmit").show();
                   $("#btnUpdate").hide();

                   $('#overlay-back').fadeIn(100, function () {
                       $('#popup').show();
                       ClearProperty();
                   });
               });

               $("#aInActiveProperty").click(function () {
                   GetInActivePropertyList();
                   statusRunning = status.inActiveStatus;
                   $("#spnActiveInactive").text("Activate");
               });

               $("#aActiveProperty").click(function () {
                   GetActivePropertyList();
                   statusRunning = status.activeStatus;
                   $("#spnActiveInactive").text("Inactivate");
               });

               //delete selected Property
               $("#aDeleteProperty").click(function () {
                   var SelectedPropertyIds = "";
                   var countchecked = $("#tblLstProperty .clsProperty input[type=checkbox]:checked").length;

                   if (countchecked > 0) {
                       var strMsg = "";
                       if (statusRunning == status.activeStatus) {
                           strMsg = "Are you sure to inactivate the selected " + countchecked;
                       }
                       else {
                           strMsg = "Are you sure to activate the selected " + countchecked;
                       }

                       if (countchecked > 1) {
                           strMsg += " propertys?";
                       } else {
                           strMsg += " property?";
                       }
                       if (confirm(strMsg)) {
                           // continue with delete
                           var chkSelected = $("#tblLstProperty .clsProperty input[type=checkbox]:checked");
                           for (var index = 0; index < countchecked; index++) {
                               var id = chkSelected[index].attributes["id"].value.substring(3);
                               SelectedPropertyIds += id + ",";
                           }
                           if (SelectedPropertyIds != "") {
                               SelectedPropertyIds = SelectedPropertyIds.substring(0, SelectedPropertyIds.length - 1);
                               ActiveInactiveProperty(SelectedPropertyIds);
                           }

                       }
                   }
                   else {
                       if (statusRunning == status.activeStatus) {
                           alert("Select atleast 1 property to inactivate!!!");
                       }
                       else {
                           alert("Select atleast 1 property to activate!!!");
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
                   ClearProperty();
               });

               $("#form1").submit(function (e) {

                   var valid = $("#form1").validationEngine('validate');
                   if (valid) {
                       e.preventDefault();
                       InsertNewProperty();
                   }
               });

               //$("#btnSubmit").click(function () {
               //    InsertNewVendor();
               //});

               //to update existing 
               $("#btnUpdate").on('click', function () {
                   var valid = $("#form1").validationEngine('validate');
                   if (valid) {
                       var objProperty = new Property();
                       objProperty.PropertyId = $("#hdnPropertyId").text();
                       objProperty.PropertyName = $("#txtPropertyName").val();
                       if ($("#chkIsCompulsory").is(":checked")) {
                           objProperty.IsCompulsory = true;
                       }
                       else {
                           objProperty.IsCompulsory = false;
                       }

                       $.ajax({
                           type: "POST",
                           url: "PropertyManagement.aspx/UpdateCabProperty",
                           data: "{'CabProperty':" + JSON.stringify(objProperty) + "}",
                           contentType: "application/json; charset=utf-8",
                           dataType: "json",
                           success: function (result) {
                               var msg = result.d;
                               if (msg) {
                                   $('#popup').hide();
                                   $('#overlay-back').fadeOut(100);
                                   if (statusRunning == status.activeStatus) {
                                       GetActivePropertyList();
                                       $("#spnActiveInactive").text("Inactivate");
                                   }
                                   else {
                                       GetInActivePropertyList();
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
                       })
                   }
               });

           });

           function hideValidation() {
               $('#txtEmpanelDate').validationEngine('hide');
           }

           function ActiveInactiveProperty(SelectedPropertyIds) {
               var isActive;
               if (statusRunning == status.activeStatus) {
                   isActive = false;
               }
               else {
                   isActive = true;
               }
               $.ajax({
                   type: "POST",
                   url: "PropertyManagement.aspx/DeleteSelectedCabProperty",
                   data: "{'CabPropertyIds':'" + SelectedPropertyIds + "','IsActive':'" + isActive + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (result) {
                       var msg = result.d;
                       if (msg) {
                           if (statusRunning == status.activeStatus) {
                               GetActivePropertyList();
                               $("#spnActiveInactive").text("Inactivate");
                           }
                           else {
                               GetInActivePropertyList();
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

           function InsertNewProperty() {
               //alert("call insertnewVendor");
               //return false;
               //alert("wwwwwww");
               var objProperty = new Property();
               objProperty.PropertyName = $("#txtPropertyName").val();
               if ($("#chkIsCompulsory").is(":checked")) {
                   objProperty.IsCompulsory = true;
               }
               else {
                   objProperty.IsCompulsory = false;
               }
               if (objProperty.PropertyName != '') {
                   $.ajax({
                       type: "POST",
                       url: "PropertyManagement.aspx/AddNewCabProperty",
                       data: "{'CabProperty':" + JSON.stringify(objProperty) + "}",
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       success: function (result) {
                           var msg = result.d;
                           if (msg == 1) {
                              
                               $('#popup').hide();
                               $('#overlay-back').fadeOut(100);
                              
                               alert("Property Added Successfully");
                               GetActivePropertyList();
                               statusRunning = status.activeStatus;
                               $("#spnActiveInactive").text("Inactivate");
                           }
                           else {
                               alert("Property Already Exists");
                           }

                       },
                       error: function (er) {
                           alert(er);
                       }
                   });
               }
               else
               {
                   alert("Please Enter Valid Property Name");
               }
           }



           function GetActivePropertyList() {

               $.ajax({
                   type: "POST",
                   url: "PropertyManagement.aspx/GetActiveCabPropertyList",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (result) {
                       var listProperty = result.d;
                       if (listProperty == null)
                           listProperty = [];
                       $('#tblLstProperty').dataTable({
                           destroy: true,
                           paging: true,

                           //"bsorting":false,
                           //"sLoadingRecords":"Loading............",
                           "bStateSave": true,
                           "data": listProperty,
                           "aoColumns": [
                               {
                                   "data": "PropertyId", "bSortable": false, "sClass": "center clsProperty", render: function (data, type, row) {
                                       return "<input id='chk" + data + "' type='checkbox'/>";
                                   }
                               },
                               { "data": "PropertyName" },
                                {
                                    "data": "IsCompulsory", "bSortable": false, render: function (data, type, row) {
                                        if (data) {
                                            return "<input disabled checked='checked' type='checkbox'/>";
                                        }
                                        else {
                                            return "<input disabled  type='checkbox'/>";
                                        }


                                    }
                                },
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
                                   "data": "PropertyId", "bSortable": false, render: function (data, type, row) {
                                       var strReturn = "<a id='" + data + "' href='#' onClick='EditProperty(this)'>Edit</a>";
                                      
                                       if (row.IsActive) {
                                           strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected property?\")) ActiveInactiveProperty(" + data + ");else return false;'>Inactivate</a>";
                                       }
                                       else {
                                           strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected property?\")) ActiveInactiveProperty(" + data + ");else return false;'>Activate</a>";
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

           function GetInActivePropertyList() {

               $.ajax({
                   type: "POST",
                   url: "PropertyManagement.aspx/GetInActiveCabPropertyList",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (result) {
                       var listProperty = result.d;
                       if (listProperty == null)
                           listProperty = [];
                       $('#tblLstProperty').dataTable({
                           destroy: true,
                           paging: true,

                           //"bsorting":false,
                           //"sLoadingRecords":"Loading............",
                           "bStateSave": true,
                           "data": listProperty,
                           "aoColumns": [
                               {
                                   "data": "PropertyId", "bSortable": false, "sClass": "center clsProperty", render: function (data, type, row) {
                                       return "<input id='chk" + data + "' type='checkbox'/>";
                                   }
                               },
                               { "data": "PropertyName" },
                               {
                                   "data": "IsCompulsory", "bSortable": false, render: function (data, type, row) {
                                       if (data) {
                                           return "<input disabled checked='checked' type='checkbox'/>";
                                       }
                                       else {
                                           return "<input disabled  type='checkbox'/>";
                                       }


                                   }
                               },

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
                                   "data": "PropertyId", "bSortable": false, render: function (data, type, row) {
                                       var strReturn = "<a id='" + data + "' href='#' onClick='EditProperty(this)'>Edit</a>";
                                       if (row.IsActive) {
                                           strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected Property?\")) ActiveInactiveProperty(" + data + ");else return false;'>Inactivate</a>";
                                       }
                                       else {
                                           strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected Property?\")) ActiveInactiveProperty(" + data + ");else return false;'>Activate</a>";
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

           

           function EditProperty(e) {
               //hide validation message if any
               $("#form1").validationEngine('hideAll');
               //hide update button and show submit button
               $("#btnSubmit").hide();
               $("#btnUpdate").show();

               $("#hdnPropertyId").text(e.attributes["id"].value);

               //get parent row
               var row = $(e).parent().parent();
               var tdPropertyName = row[0].cells[1].innerText;
               var ctrlCheckBox = row[0].cells[2].firstChild;

               

               $('#overlay-back').fadeIn(100, function () {
                   $('#popup').show();
               });


               $("#txtPropertyName").val(tdPropertyName);
               if ($(ctrlCheckBox).is(":checked")) {
                   $("#chkIsCompulsory").prop("checked", true);
               }
               else {
                   $("#chkIsCompulsory").prop('checked',false);
               }

           }

           function ClearProperty() {
               $("#txPropertyName").val("");
               $("#chkIsCompulsory").prop('checked',false);
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
              <td>  <a href="#" id="aCreateProperty">Add New Property</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aActiveProperty">View Active Property</a></td>
              <%--<td class="width20"></td>--%>
              <td> <a href="#" id="aInActiveProperty">View Inactive Property</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aDeleteProperty"><span id="spnActiveInactive">InActivate</span> Selected Property</a></td>
          </tr>
      </table>
  </div>
      
</div>

        <br />
    <br />
    <table width="100%" class="cell-border paddingtop15" id="tblLstProperty" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Select</th>
                <th>PropertyName</th>                
                <th>IsCompulsory</th>
                <th>CreatedBy</th>    
                <th class="width20">Status</th>             
                <th>Action </th>
            </tr>
        </thead>

    </table>

 
       
 

    <div id="popup"><img class="close-image" src="../Images/close.png" />
        
         
    <fieldset>
        <label>
           <b>Enter Cab Property Details:</b>
        </label>
    </fieldset>
       
    <table>
        <tr class="displayNone">
            <td></td><td><input id="hdnPropertyId" type="hidden" value="" /></td>
        </tr>
        <tr>
            <td>Property Name:</td>
            <td>
                <input id="txtPropertyName" name="txtPropertyName" class="validate[required]"  type="text" maxlength="50" />
            </td>
        </tr>
       
       
        
        <tr>
            <td>IsCompulsory:</td>
            <td>
               <input type="checkbox" id="chkIsCompulsory" value="" /></td>
        </tr>
      
        <tr>
            <td></td>
            <td><input id="btnSubmit" class="submit" type="submit" value="Submit" />                
                <input id="btnUpdate" type="button" value="Update" />
            &nbsp;&nbsp;<input id="btnCancel" type="button" value="Cancel" /></td>
            
        </tr>
    </table>
    
        </div>

    <div id="overlay-back"></div>
     <div id="pageloaddiv"></div>
</asp:Content>

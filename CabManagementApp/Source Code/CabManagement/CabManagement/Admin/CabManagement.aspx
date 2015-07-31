<%@ Page Title="Cab Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CabManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.CabManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
    <style>
  .ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
  }
  /* IE 6 doesn't support max-height
   * we use height instead, but this forces the menu to always be this tall
   */
  * html .ui-autocomplete {
    height: 100px;
  }
  </style>


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


  
    <%--  <!-- Cabmanagement JS-->
        <script src="../Scripts/CabManagementScript/CabManagement.js"></script>--%>

     <script type="text/javascript">

         function CabDetails(DCID,DCName,VendorID, VendorName, CabNumberFirst, CabNumberLast, CabType, CabCapacity, DriverName, EmpanelDate,Comment, lstCabProperty, DocumentsVerified, IsActive,IsActiveComment,CabID) {
             this.DCID = DCID;
             this.DCName = DCName;
             this.VendorID = VendorID;
             this.VendorName = VendorName;
             this.CabNumberFirst = CabNumberFirst;
             this.CabNumberLast = CabNumberLast;
             this.CabType = CabType;
             this.CabCapacity = CabCapacity;
             this.Comment = Comment;
             this.DriverName = DriverName;
             this.EmpanelDate = EmpanelDate;
             this.lstCabProperty = lstCabProperty;
             this.DocumentsVerified = DocumentsVerified;
             this.IsActive = IsActive;
             this.IsActiveComment = IsActiveComment;
             this.CabId = CabID;
             
         }

         function CabProperty(PropertyId, ExpiryDate, IsCompulsory)
         {
             this.PropertyId = PropertyId;
             this.ExpiryDate = ExpiryDate;
             this.IsCompulsory = IsCompulsory;
         }

         var status = {
             activeStatus: "active",
             inActiveStatus: "inactive"
         };

         var statusRunning;
         
         $(document).ready(function () {
             
             $("#frmcabdetail").validationEngine({ // Auto-hide prompt
                 autoHidePrompt: true,
                 // Delay before auto-hide
                 autoHideDelay: 2000,
                 // Fade out duration while hiding the validations
                 fadeDuration: 0.3
             });
             $("#pageloaddiv").fadeIn(1000);
             $('#overlay-back').fadeIn(1000);
             
             $("#pageloaddiv").fadeOut(500);
             $('#overlay-back').fadeOut(500);
             //show active list initially
             statusRunning = status.activeStatus;
             $("#spnActiveInactive").text(" InActivate");
             //end code to load active all vendor list
             GetDCList();
             //GetCabVendorList();
             GetCabType();
             GetCabCapacity();
             GetCabProperty();
             GetActiveCabDetail();
             
             $('#ddlDCName').append($("<option>").val(0).text('–Select–'));
             $('#ddlVenderName').append($("<option>").val(0).text('–Select–'));
             $('#ddldrivername').append($("<option>").val(0).text('–Select–'));
             // Change Function for DDL
             $("#ddlDCName").change(function () {
                 GetCabDriverList();
                 GetCabVendorList();
             });
             $("#txtEmpanelDate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 dateFormat: "M dd,yy",
                 maxDate: new Date(),
                 onSelect: hideValidation,
                 readonly: true
             });
                 
             $("#aInActiveCab").click(function () {
                 GetInActiveCabDetail();
                 statusRunning = status.inActiveStatus;
                 $("#spnActiveInactive").text("Activate");
             });

             $("#aActiveCab").click(function () {
                 GetActiveCabDetail();
                 statusRunning = status.activeStatus;
                 $("#spnActiveInactive").text("Inactivate");
             });
             //to show popup to create a new vendor           
             $("#aCreatCabDetail").click(function () {
                 //hide validation message if any
                 $("#frmcabdetail").validationEngine('hideAll');
                 //hide update button and show submit button
                 $("#btnSubmit").show();
                $("#btnUpdate").hide();

                 $('#overlay-back').fadeIn(100, function () {
                     $('#popup').show();
                    ClearCabDetail();
                 });
             });

             //delete selected CabDetail
             $("#aDeleteCabDetail").click(function () {
                 var SelectedCabId = "";
               
                 var countchecked = $("#tblLstCabDetail input[type=checkbox]:checked").length;

                 if (countchecked > 0) {
                     var strMsg = "";
                     if (statusRunning == status.activeStatus) {
                         strMsg = "Are you sure to inactivate the selected " + countchecked;
                     }
                     else {
                         strMsg = "Are you sure to activate the selected " + countchecked;
                     }

                     if (countchecked > 1) {
                         strMsg += " cabs?";
                     } else {
                         strMsg += " cab?";
                     }
                     if (confirm(strMsg)) {
                         // continue with delete
                         var chkSelected = $("#tblLstCabDetail input[type=checkbox]:checked");
                         for (var index = 0; index < countchecked; index++) {
                             var id = chkSelected[index].attributes["id"].value.substring(3);
                             SelectedCabId += id + ",";
                         }
                         if (SelectedCabId != "") {
                             SelectedCabId = SelectedCabId.substring(0, SelectedCabId.length - 1);
                             ActiveInactiveCabs(SelectedCabId);
                         }

                     }
                 }
                 else {
                     if (statusRunning == status.activeStatus) {
                         alert("Select atleast 1 cab to inactivate!!!");
                     }
                     else {
                         alert("Select atleast 1 cab to activate!!!");
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
                 ClearCabDetail();
             });
             $("#frmcabdetail").submit(function (e) {

                 
                 var valid = $("#frmcabdetail").validationEngine('validate');
                 if (valid) {
                     e.preventDefault();
                     InsertCabDetail();
                 }
             });

             //to update existing vendor
             $("#btnUpdate").on('click', function () {
                 
                 var valid = $("#frmcabdetail").validationEngine('validate');
                 if (valid) {
                     var objVendor = new CabDetails();
                     objVendor.CabId = $("#hdnCabId").text();
                     objVendor.DCID = $("#ddlDCName").val();
                     objVendor.DCName = $("ddlDCName").text();
                     objVendor.VendorID = $("#ddlVenderName").val();
                     objVendor.VendorName = $("#ddlVenderName").text;
                     objVendor.CabNumberFirst = $("#txtcabnofirst").val().toUpperCase();
                     objVendor.CabNumberLast = $("#txtcabnolast").val().toUpperCase();
                     objVendor.CabType = $("#txtcabtype").val();
                     objVendor.CabCapacity = $("#txtcarcapacity").val();
                     objVendor.DriverName = $("#ddldrivername").val().toUpperCase();
                     objVendor.EmpanelDate = $("#txtEmpanelDate").val();
                     objVendor.Comment = $("#txtComment").val();
                     var property = [];
                    
                     for (i = 0; i < counter; i++) {

                         var PropID = $('#hdPropertyId' + i).val();
                         var PropExpDate = $('#chklistitem_text' + i).val();
                         var PropIsCompulsory = true;
                         if ($("#chklistitem_check" + i).prop('checked') == true) {
                             PropIsCompulsory = true;
                         }
                         else {
                             PropIsCompulsory = false;
                         }
                         property.push(new CabProperty(PropID, PropExpDate, PropIsCompulsory));
                         if (PropExpDate != '') {
                             objVendor.DocumentsVerified = 'true';
                             objVendor.IsActive = 'true';
                         }


                     }
                     objVendor.lstCabProperty = property;
                     $.ajax({
                         type: "POST",
                         url: "CabManagement.aspx/UpdateCabDetail",
                         data: "{'cabManagement':" + JSON.stringify(objVendor) + "}",
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (result) {
                             var msg = result.d;
                             if (msg) {
                              
                                 $('#popup').hide();
                                 $('#overlay-back').fadeOut(100);
                                 if (statusRunning == status.activeStatus) {
                                     GetActiveCabDetail();
                                     $("#spnActiveInactive").text("Inactivate");
                                 }
                                 else {
                                     GetInActiveCabDetail();
                                     $("#spnActiveInactive").text("Activate");
                                 }
                                 
                                 ClearCabDetail();
                             }
                             else {
                                 alert("Error Occured");
                             }

                         },
                         error: function (er) {
                             alert("Please Enter Numeric Value for Car Capacity");
                         }
                     })
                 }
             });

         });
                  
         function GetCabVendorList() {
             
             var DCID = $('#ddlDCName').val();
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetVendorList",
                 data: "{'DCID':" + DCID + "}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     
                     var dcJSON = result.d;
                     if (dcJSON != null) {
                         $('#ddlVenderName').children().remove();
                         $('#ddlVenderName').append($("<option>").val(0).text('–Select–'));
                         $.each(dcJSON, function (index, value) {
                             $('#ddlVenderName').append($("<option></option>").val(value.VendorID).html(value.VendorName));
                         });
                     }
                     else
                     {
                         $('#ddlVenderName').children().remove();
                         $('#ddlVenderName').append($("<option>").val(0).text('–Select–'));
                     }
                 },
                 error: function (er) {
                     alert(er);
                 }
             });
         }

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

                
         function ActiveInactiveCabs(SelectedCabId)
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
                 url: "CabManagement.aspx/DeleteSelectedCab",
                 data: "{'CabId':'" + SelectedCabId + "','Comment':'','IsActive':'" + isActive + "'}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var msg = result.d;
                     if (msg) {
                         if (statusRunning == status.activeStatus) {
                             GetActiveCabDetail();
                             $("#spnActiveInactive").text("Inactivate");
                         }
                         else {
                             GetInActiveCabDetail();
                             $("#spnActiveInactive").text("Activate");
                         }
                         ClearCabDetail();
                        
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

         function GetCabType() {
            
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetCabType",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var dcJSON = result.d;
                     if (dcJSON != null) {
                         $.each(dcJSON, function (index, value) {
                             $('#ddlcabtype').append($("<option></option>").html(value.CABNAME));
                         });
                     }
                 },
                 error: function (er) {
                     alert(er);
                 }
             });
         }
         
         function GetCabCapacity() {
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetCabCapacity",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var dcJSON = result.d;
                     if (dcJSON != null) {
                         $.each(dcJSON, function (index, value) {
                             $('#ddlcarcapacity').append($("<option></option>").html(value.capacity));
                         });
                     }
                 },
                 error: function (er) {
                     alert(er);
                 }
             });
         }

         function GetCabProperty() {
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetCabProperty",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var dcJSON = result.d;
                     if (dcJSON != null) {
                        
                         CreateCheckBoxList(dcJSON);
                     }
                 },
                 error: function (er) {
                     alert(er);
                 }
             });
         }

         var counter = 0;
         function CreateCheckBoxList(checkboxlistItems) {
             var strtable = "<table style='border:1px solid;border-collapse: collapse;'><tr style='border:1px solid;'><th>Property</th><th>IsMandatory</th><th>ExpiryDate</th></tr>"
            // var counter = 0;
             $(checkboxlistItems).each(function () {

                 strtable += "<tr style='border:1px solid;'><td><input type='hidden' name='hdPropertyId' id='hdPropertyId" + counter + "' value='" + this.PropertyId + "'/><label for='hdPropertyId_label" + counter + "'>" + this.PropertyName + "</label></td>";
                 if (this.IsCompulsory)
                 {
                     strtable += "<td style='padding-left:16px'><input id='chklistitem_check" + counter + "' checked='checked' disabled  type='checkbox' value='" + this.PropertyId + "'/></td>";
                     strtable += "<td style='padding-left:16px'><input id='chklistitem_text" + counter + "' class='validate[required] datepick' type='text' /></td>";
                 }
                 else
                 {
                     strtable += "<td style='padding-left:16px'><input id='chklistitem_check" + counter + "' disabled  type='checkbox' value='" + this.PropertyId + "'/></td>";
                     strtable += "<td style='padding-left:16px'><input id='chklistitem_text" + counter + "' class='datepick' type='text' /></td>";
                 }
                 
                 strtable += "</tr>";
                
                 counter++;
             });
             //type: 'checkbox', name: 'chklistitem', value: this.PropertyId, id: 'chklistitem' + counter,
             strtable += "</table>";

             $('#dvCheckBoxListControl').append(strtable);
            // 
           // var a =$('#chklistitem_text0');
            $(".datepick").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "M dd,yy"//,
                //maxDate: new Date(),
                //readonly: true
            });
          
           
         }
         
         function InsertCabDetail()
         {
             var objVendor = new CabDetails();
             objVendor.VendorID = $("#ddlDCName").val();
             objVendor.VendorID = $("#ddlVenderName").val();
             objVendor.VendorName = $("#ddlVenderName").text;
             objVendor.CabNumberFirst = $("#txtcabnofirst").val().toUpperCase();
             objVendor.CabNumberLast = $("#txtcabnolast").val().toUpperCase();
             objVendor.CabType = $("#txtcabtype").val();
             objVendor.CabCapacity = $("#txtcarcapacity").val();
             objVendor.DriverName = $("#ddldrivername").val().toUpperCase();
             objVendor.EmpanelDate = $("#txtEmpanelDate").val();
             objVendor.Comment = $("#txtComment").val();
              var property = [];
             
              for (i = 0; i < counter; i++) {
                 
                  var PropID = $('#hdPropertyId' + i).val();
                  var PropExpDate = $('#chklistitem_text' + i).val();
                  var PropIsCompulsory =true;
                  if ($("#chklistitem_check" + i).prop('checked') == true) {
                      PropIsCompulsory = true;
                  }
                  else
                  {
                      PropIsCompulsory = false;
                  }
                  property.push(new CabProperty(PropID, PropExpDate, PropIsCompulsory));
                 if (PropExpDate!='')
                 {
                objVendor.DocumentsVerified = 'true';
                objVendor.IsActive = 'true';
                 }
               

                }
              objVendor.lstCabProperty = property;
          
             $.ajax({
                 type: "Post",
                 url: "CabManagement.aspx/InsertCabDetail",
                 data: "{'cabManagement':" + JSON.stringify(objVendor) + "}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",

                 success: function (result) {
                    
                     var msg = result.d;
                     if (msg == '-1') {
                         alert("Cab Already Exist");
                     }
                     else {

                         $('#popup').hide();
                         $('#overlay-back').fadeOut(100);
                         ClearCabDetail();
                         GetActiveCabDetail();
                         statusRunning = status.activeStatus;
                         $("#spnActiveInactive").text("Inactivate");
                     }

                 },
                 error: function (er) {
                    
                     alert("Please Enter Numeric Value for Car Capacity");
                 }
                 
             })
         }
           
         function hideValidation() {
             $('#txtEmpanelDate').validationEngine('hide');
         }
         function ClearCabDetail()
         {
             $("#txtcabnofirst").val("");
             $("#txtcabnolast").val("");
             $("#ddldrivername").val("");
             $("#txtEmpanelDate").val("");
             $("#txtComment").val("");
             $("#txtcabtype").val("");
             $("#txtcarcapacity").val("");
             for (i = 0; i < counter; i++) {

             
                 var PropExpDate = $('#chklistitem_text' + i).val();

                
                 if (PropExpDate != '') {
                     $('#chklistitem_text' + i).val("");
                 }


             }
         }
         function GetActiveCabDetail()
         {
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetActiveCabDetail",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result)
                 {
                     var cabDetail = result.d;
                     if (cabDetail == null)
                         cabDetail = [];
                     $("#tblLstCabDetail").dataTable({
                         destroy: true,
                         paging: true,
                         "bStateSave": true,
                         "data": cabDetail,                        
                         "aoColumns": [
                            {
                                "data": "CabId", "bSortable": false, render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                            { "data": "DCName" },
                           { "data": "VendorName" },
                           { "data": "CabNumberFirst" },
                           { "data": "CabNumberLast" },
                           { "data": "CabType" },
                           { "data": "CabCapacity" },
                           { "data": "DriverName" },
                           { "data": "EmpanelDate" },
                            { "data": "Comment" },
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
                               "data": "DocumentsVerified", "bSortable": false, render: function (data, type, row) {
                                   if (data) {
                                       return "<img src='../Images/true.png' height='25px' width='25px' />";
                                   }
                                   else {
                                       return "<img src='../Images/cross.png' height='25px' width='25px'/>";
                                   }


                               }
                           },
                           
                         {
                             "data": "CabId", "bSortable": false, render: function (data, type, row) {                                 
                                 var strReturn = "<a id='" + data + "' href='#' onClick='EditCabDetail(this)'>Edit</a>";
                                 if (row.IsActive) {
                                     strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected cab?\")) ActiveInactiveCabs(" + data + ");else return false;'>Inactivate</a>";
                                 }
                                 else {
                                     strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected cab?\")) ActiveInactiveCabs(" + data + ");else return false;'>Activate</a>";
                                 }
                                 return strReturn;
                             }
                         }

                        

                         ],                        
                         //"fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                         //    if(!aData.DocumentsVerified)
                         //        $(nRow).css("background-color", "rgb(255, 194, 0)");
                         // }


                     })

                 }


             })



         }

         function GetInActiveCabDetail() {
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetInActiveCabDetail",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var cabDetail = result.d;
                     if (cabDetail == null)
                         cabDetail = [];
                     $("#tblLstCabDetail").dataTable({
                         destroy: true,
                         paging: true,
                         "bStateSave": true,
                         "data": cabDetail,
                         "aoColumns": [
                            {
                                "data": "CabId", "bSortable": false, render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                            { "data": "DCName" },
                           { "data": "VendorName" },
                           { "data": "CabNumberFirst" },
                           { "data": "CabNumberLast" },
                           { "data": "CabType" },
                           { "data": "CabCapacity" },
                           { "data": "DriverName" },
                           { "data": "EmpanelDate" },
                            { "data": "Comment" },
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
                              "data": "DocumentsVerified", "bSortable": false, render: function (data, type, row) {
                                  if (data) {
                                      return "<img src='../Images/true.png' height='25px' width='25px' />";
                                  }
                                  else {
                                      return "<img src='../Images/cross.png' height='25px' width='25px'/>";
                                  }


                              }
                          },

                         {
                             "data": "CabId", "bSortable": false, render: function (data, type, row) {
                                 var strReturn = "<a id='" + data + "' href='#' onClick='EditCabDetail(this)'>Edit</a>";
                                 if (row.IsActive) {
                                     strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected cab?\")) ActiveInactiveCabs(" + data + ");else return false;'>Inactivate</a>";
                                 }
                                 else {
                                     strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected cab?\")) ActiveInactiveCabs(" + data + ");else return false;'>Activate</a>";
                                 }
                                 return strReturn;
                             }
                         }



                         ],
                         //"fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                         //    if (!aData.DocumentsVerified)
                         //        $(nRow).css("background-color", "rgb(255, 194, 0)");
                         //}


                     })

                 }


             })



         }
         //Flag for distinguishing 'edit driver for cab' and 'add driver for cab' 

         function ChangeFlag()
         {
             flag = 1;

             // data binding by calling function to get updated list
             GetCabDriverList();
         }

         function EditCabDetail(e) {
            
             flag=0;
             //hide validation message if any
             $("#frmcabdetail").validationEngine('hideAll');
             //hide submit button and show Update button
             $("#btnSubmit").hide();
             $("#btnUpdate").show();
          
             var vall = e.attributes["id"].value;
            // $("#hdnCabId").text(e.attributes["id"].value);
             $("#hdnCabId").text(vall);
             //get parent row
             var row = $(e).parent().parent();
             var tdDCName = row[0].cells[1].innerText;//DCName 
             var tdVenderName = row[0].cells[2].innerText;//VendorName    //index 0 for checkbox
             var tdCabNumberFirst = row[0].cells[3].innerText;//CabNumberFirst
             var tdCabNumberLast = row[0].cells[4].innerText;//CabNumberLast
             var tdCabType = row[0].cells[5].innerText;//CabType
             var tdCabCapacity = row[0].cells[6].innerText;//CabCapacity
              tdDriverName = row[0].cells[7].innerText;//DriverName
             var tdEmpanelDate = row[0].cells[8].innerText;//EmPanelDate
             var tdComment = row[0].cells[9].innerText;
             //var tdIsActiveComment = row[0].cells[9].innerText;//IsActiveComment
             //var tdDocumnetVarified = row[0].cells[10].innerText;//DocumnetsVerified


             $('#overlay-back').fadeIn(100, function () {
                $('#popup').show();
             });

            //set ddl for DC Name
             //$("#ddlDCName option").each(function () {
             //    if ($(this).text().trim() == tdVendorName.trim()) {
             //        $(this).attr('selected', 'selected');
             //    }
             //});

             $("#ddlDCName option").each(function () {
                 console.log("ddl TEXT :'" + $(this).text().trim() + "'       DCName:" + tdDCName.trim());
                 if ($(this).text().trim() == tdDCName.trim()) {
                     $(this).attr('selected', 'selected');
                     $(this).change();
                 }
             });

             //set ddl for Vendor Name
             //$("#ddlVenderName option").each(function () {
             //    if ($(this).text().trim() == tdVendorName.trim()) {
             //        $(this).attr('selected', 'selected');
             //    }
             //});
             $("#ddlVenderName option").each(function () {
                 console.log("ddl TEXT :'" + $(this).text().trim() + "'       VendorName:" + tdVenderName.trim());
                 if ($(this).text().trim() == tdVenderName.trim()) {
                     $(this).attr('selected', 'selected');
                     $(this).change();
                 }
             });

             //set ddl for Drivername
             $("#ddldrivername option").each(function () {           
                 console.log("ddl TEXT :'" + $(this).text().trim() + "'       DriverName:" + tdDriverName.trim());
                 if ($(this).text().trim() == tdDriverName.trim()) {
                     $(this).attr('selected', 'selected');
                     $(this).change();
                 }
             });
         
             $("#txtcabnofirst").val(tdCabNumberFirst);
             $("#txtcabnolast").val(tdCabNumberLast);
           
             $("#txtEmpanelDate").val(tdEmpanelDate);
             $("#txtcabtype").val(tdCabType);
             $("#txtcarcapacity").val(tdCabCapacity);
             //set ddl For Cab Type
             //$("#ddlcabtype option").each(function () {
             //    if ($(this).text().trim() == tdCabType.trim()) {
             //        $(this).attr('selected', 'selected');
             //    }
             //});

            

             //set ddl For Cab Capacity
             //$("#ddlcabtype option").each(function () {
             //    if ($(this).text().trim() == tdCabCapacity.trim()) {
             //        $(this).attr('selected', 'selected');
             //    }
             //});
             //set ddl for Driver Name
             //$("#ddldrivername option").each(function () {
             //    if ($(this).text().trim() == tdDriverName.trim()) {
             //        $(this).attr('selected', 'selected');
             //    }
             //});
             //$("#ddldrivername").val(tdDriverName);
             $("#txtEmpanelDate").val(tdEmpanelDate);
             $("#txtComment").val(tdComment);
             GetCabVerificationDetail(vall);

         }

         function GetCabVerificationDetail( cabid)
         {
            
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetCabVerificationDetail",
                 data: "{'CabId':'" + cabid + "','Comment':''}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var msg = result.d;
                   
                     if (msg!=null) {
                         
                         var dcJSON = msg;
                         if (dcJSON != null) {
                             $.each(dcJSON, function (index, value) {
                                 $('#chklistitem_text' + index).val(value.ExpiryDate);
                             });
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

         function GetCabDriverList() {
             
             var DCID = $('#ddlDCName').val();
             $.ajax({
                 type: "POST",
                 url: "CabManagement.aspx/GetDriverList",
                 data: "{'DCID':" + DCID + "}",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var dcJSON = result.d;
                     if (dcJSON != null) {
                         $('#ddldrivername').children().remove();
                         $('#ddldrivername').append($("<option>").val(0).text('–Select–'));
                         if (flag == 0) {
                             $('#ddldrivername').append($("<option>").val(1).text(tdDriverName));
                         }
                         $.each(dcJSON, function (index, value) {
                             $('#ddldrivername').append($("<option></option>").val(value.DriverId).html(value.DriverName));
                         });
                     }
                     else
                     {
                         $('#ddldrivername').children().remove();
                         $('#ddldrivername').append($("<option>").val(0).text('–Select–'));
                     }
                 },
                 error: function (er) {
                     alert(er.responseText);
                 }
             });
         }
                 //dataType: "json",
                 //success: function (result) {
                 //    var dcJSON = result.d;
                 //    if (dcJSON != null) {
                         //$.each(dcJSON, function (index, value) {
                         //    $('#ddlVenderName').append($("<option></option>").val(value.VendorID).html(value.VendorName));
                         //});
         //                var lstDriverName = dcJSON.lstDriverName;
         //                var availableTags = dcJSON.lstDriverNameCode;
         //                $("#ddldrivername").autocomplete({
         //                    source: availableTags,
         //                    focus: function (event, ui) {
         //                    $("#project").val(ui.item.label);
         //                    return false;
         //                },
         //                    select: function (event, ui) {   
         //                            var val = ui.item.label;
         //                            var value = val.split(' -');
         //                            $("#ddldrivername").val(value[0]);
                                 
         //                    return false;
         //                }
         //                }).blur(function () {
         //                    var val = $("#ddldrivername").val();
         //                    if (val.length > 0) {
         //                        if ($.inArray(val, lstDriverName) > -1) {
         //                            //alert("correct driver!!!!");
         //                            ////var value = val.split(' -');
         //                            ////$("#ddldrivername").val(value[0]);
         //                        }
         //                        else {
         //                            alert("Please select the correct driver!!!!");
         //                            $("#ddldrivername").val("");
         //                            $("#ddldrivername").focus();
         //                        }
         //                    }
         //                });
         //            }
         //        },
         //        error: function (er) {
         //            alert(er);
         //        }
         //    });
         //}
         
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
              <td>  <a href="#" id="aCreatCabDetail" onclick="ChangeFlag()">Add New Cab</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aActiveCab">View Active Cabs</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aInActiveCab">View Inactive Cabs</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aDeleteCabDetail"><span id="spnActiveInactive">InActivate</span> Selected Cab</a></td>
          </tr>
      </table>
  </div>
      
</div>
      <br />
    <br />
    
 <table width="100%" class="display paddingtop15" id="tblLstCabDetail" cellspacing="0">
        <thead>
            <tr  class="tablerow" >
                 <th>Select</th>
                <th>DCName</th>
                <th>VendorName</th>
                <th>CabNumberFirst</th>
                <th>CabNumberLast</th>
                <th>CabType</th>
                <th>CabCapacity</th>
                <th>DriverName</th>
                <th>EmpanelDate</th>      
               <th>Comment</th>    
               <th class="width20">Status </th>               
                <th class="width37">Doc. Verified</th>
                 <th class="width37">Action</th>
            </tr>
        </thead>

    </table>
    </form>


  
    <div id="popup" ><img class="close-image" src="../Images/close.png" />

      <form id="frmcabdetail" method="post">
         
              <label>
                  <b>Enter Cab Details:</b>
              </label>
       
          <table id="tblinputdetail"  class="display">
              <tr class="displayNone">
                  <td></td>
                  <td>
                      <input id="hdnCabId" type="hidden" value="" />
                       <input id="hdPropertyId" type="hidden" value="" />
                  </td>
              </tr>
               <tr>
                  <td>DC Name:</td>
                  <td><select id ="ddlDCName" style="width: 152px; "  class="validate[required]"></select></td>
              </tr>
              <tr>
                  <td>Associated Vendor:</td>
                  <td><select id ="ddlVenderName" style="width: 152px; "  class="validate[required]"></select></td>
              </tr>
              <tr>
                  <td >Cab No First:</td>
                  <td><input id="txtcabnofirst" name="txtcabnofirst" class="validate[required]"   type="text" maxlength="7"/> </td>
              </tr>
              <tr>
                  <td>Cab No Last:</td>
                  <td>
                      <input id="txtcabnolast" name="txtcabnolast"  class="validate[required]" type="text" maxlength="4" />

                  </td>
               </tr>
              <tr>
                  <td>Cab Type:</td>
                  <%--<td>
                      <select id="ddlcabtype" style="width: 152px; "  class="validate[required]"></select>
                  </td>--%>
                  <td><input id="txtcabtype" name="txtcabtype" class="validate[required]"   type="text" maxlength="50"/> </td>
              </tr>
              <tr>
                  <td>Cab Capacity:</td>
                 <%-- <td>
                      <select id="ddlcarcapacity" style="width: 152px; "  class ="validate[required]"></select>
                  </td>--%>
                  <td><input id="txtcarcapacity" name="txtcarcapacity" class="validate[required]"  type="text" maxlength="50"/> </td>
              </tr>
            
              <tr>
                  <td>Empanel Date:</td>
                  <td>
                      <input  id="txtEmpanelDate" name="txtEmpanelDate" class="validate[required]"   type="text"/>
                  </td>
              </tr>
                <tr>
                  <td>Driver Name:</td>
                  <td>
                      <div class="ui-widget">
                           <select id="ddldrivername" style="width: 152px; "  class ="validate[required]"></select>
  <%--<input id="txtdrivername" name="txtdrivername" class="validate[required]"   type="text"/>--%>
</div>
                     
                  </td>
              </tr>
                <tr>
            <td>Any Comment:</td>
            <td>
                <input id="txtComment" type="text" maxlength="300" />
            </td>
        </tr>
              <tr>
                  <td>Document verified:</td>
              </tr>
           </table>
           <div id="dvCheckBoxListControl"  ></div>
          <table>
              <tr>
                  <td></td>
                  <td><input id="btnSubmit"  class="submit" type="submit" value="Submit" />
                       <input id="btnUpdate" type="button" value="Update" />
            &nbsp;&nbsp;<input id="btnCancel" type="button" value="Cancel" />
                  </td>
              </tr>

          </table>

      </form>

        </div>
    
      <div id="overlay-back"></div>
     <div id="pageloaddiv"></div>
        <div id="tmp" style="height:20px"></div>

 

    <script type="text/javascript">
        $(document).ready(function () {
            
            var valid=  $("#frmcabdetail").validationEngine();
            $('#txtSortOrder').bind('keypress', function (e) {
                if (parseInt(e.key) < 1) {
                    e.preventDefault();
                    return;
                }
                var key = e.which;
                var ok = key >= 48 && key <= 57;
            //disable special characters
            //$('#frmcabdetail').bind('keypress', function (e) {
               
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
            //        key == 41  //)
            //    ;
            //    if (!ok) {
            //        e.preventDefault();
            //    }
            //});
                if (!ok) {
                    e.preventDefault();
                }

            });
        });
    </script>
</asp:Content>
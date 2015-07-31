<%@ Page Title="Roles Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ManageRole.aspx.cs" Inherits="Infosys.CabManagement.UI.Roles.ManageRole" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style type="text/css">
        #popup {
            position: absolute;
            display: none;
            top: 200px;
            left: 50%;
            width: 400px;
            height: 566;
            margin-left: -250px;
            background-color: white;
            z-index:10;
        }
        #overlay-back {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: 0.6;
            filter: alpha(opacity=60);
            z-index: 5;
            display: none;
        }
        #wgtmsr{
         width:150px;   
                 }
        .close-image {
            display: block;
            float: right;
            position: relative;
            top: -10px;
            right: -10px;
            height: 20px;
        }

        .displayNone
        {
            display:none;
        }

         #pageloaddiv {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 1000;
            background: url('../Images/pageloader.gif') no-repeat center center;
        }
         
         .bgColorRed
         {
             background-color:red;
         }
         .tablerow
           {
              background:#017dc3;
              color:white;
          }

    </style>
   
  <%--datepicker--%>
    <%--<link href="../CSS/jquery-ui.css" rel="stylesheet" />--%>

   <%--<link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />--%>

     <!-- DataTables CSS -->
    <%--<link href="../CSS/jquery.dataTables.css" rel="stylesheet" />--%>
    
     <!-- jQuery -->
    <%--<script src="../Scripts/jquery-1.10.2.min.js"></script>--%>

    <%--validation--%>
    <%--<script src="../Scripts/jquery.validationEngine-en.js"></script>--%>
    <%--<script src="../Scripts/jquery.validationEngine.js"></script>--%>
    
      <%--datepicker--%>
    <%--<script src="../Scripts/DatePicker/jquery-ui.js"></script>--%>
  
    <!-- DataTables -->    
    <%--<script src="../Scripts/DataTable/jquery.dataTables.js"></script>--%>

  
     <link href="../CSS/style.css" rel="stylesheet" />
    <link href="../CSS/jquery-ui.css" rel="stylesheet" />
    <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
  
    <!-- DataTables -->    
    <script src="../Scripts/DataTable/jquery.dataTables.js"></script>

    <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script src="<%=ResolveUrl("../Scripts/jquery.validationEngine-en.js") %>" type="text/javascript"></script>
    <script src="<%=ResolveUrl("../Scripts/jquery.validationEngine.js") %>" type="text/javascript"></script>

    <script src="../Scripts/DatePicker/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            // binds form submission and fields to the validation engine
            $("#form1").validationEngine({ // Auto-hide prompt
                autoHidePrompt: true,
                // Delay before auto-hide
                autoHideDelay: 2000,
                // Fade out duration while hiding the validations
                fadeDuration: 0.3
            });
        });
    </script>

  
   

     <script type="text/javascript">
               
         function RoleDetail(RoleId,RoleName,RoleAccess,CreatedDate,CreatedBy,ModifiedDate,ModifiedBy,IsActive)
         {
             this.RoleId = RoleId;
             //this.RoleType = RoleType;
             this.RoleName = RoleName;
             this.RoleAccess = RoleAccess;
             this.CreatedDate = CreatedDate;
             this.CreatedBy = CreatedBy;
             this.ModifyDate = ModifiedDate;
             this.ModifyBy = ModifiedBy;
             this.IsActive = IsActive;

         }


         $(document).ready(function () {
             $("#frmManageRole").validationEngine();
             $("#pageloaddiv").fadeIn(1000);
             $('#overlay-back').fadeIn(1000);

             $("#pageloaddiv").fadeOut(500);
             $('#overlay-back').fadeOut(500);
             //end code to load 
             GetRoleType();
             GetRoleDetail();


            
             //to show popup to create a new Role           
             $("#aCreateRole").click(function () {
                 //hide validation message if any
                 $("#frmManageRole").validationEngine('hideAll');
                 //hide update button and show submit button
                 $("#btnSubmit").show();
                 $("#btnUpdate").hide();

                 $('#overlay-back').fadeIn(100, function () {
                     $('#popup').show();
                    
                 });


                
             });



             //delete selected Role
             $("#aDeleteRole").click(function () {
                 var SelectRoleId = "";
    
                 var countchecked = $("#tblLstRoleDetail input[type=checkbox]:checked").length;

                 if (countchecked > 0) {
                     if (confirm("Are you sure to delete the selected " + countchecked + " User?")) {
                         // continue with delete
                         var chkSelected = $("#tblLstRoleDetail input[type=checkbox]:checked");
                         for (var index = 0; index < countchecked; index++) {
                             var id = chkSelected[index].attributes["id"].value.substring(3);
                             SelectRoleId += id + ",";
                         }
                         if (SelectRoleId != "") {
                             SelectRoleId = SelectRoleId.substring(0, SelectRoleId.length - 1);
                             $.ajax({
                                 type: "POST",
                                 url: "ManageRole.aspx/DeleteRole",
                                 data: "{'RoleId':'" + SelectRoleId + "','Comment':''}",
                                 contentType: "application/json; charset=utf-8",
                                 dataType: "json",
                                 success: function (result) {
                                     var msg = result.d;
                                     if (msg) {
                                        
                                         ClearCabDetail();
                                         GetRoleDetail();
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

                     }
                 }
                 else {
                     alert("Select atleast 1 User to delete!!!");
                 }

             });



             $("#btnUpdate").on('click', function () {
                
                 var valid = $("#frmManageRole").validationEngine('validate');
                 if (valid) {
                    
                     var objRole = new RoleDetail();
                     objRole.RoleId = $("#hdnRoleId").text();
                     objRole.RoleAccess = $("#ddlRoleAcess").val();
                     objRole.RoleName = $("#txtrolename").val();
                     objRole.IsActive = JSON.parse($("#ddlIsActive").val());

                     $.ajax({
                         type: "POST",
                         url: "ManageRole.aspx/UpdateRole",
                         data: "{'roledetail':" + JSON.stringify(objRole) + "}",
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (result) {
                             var msg = result.d;
                             if (msg) {

                                 $('#popup').hide();
                                 $('#overlay-back').fadeOut(100);
                                 
                                 GetRoleDetail();
                                 ClearCabDetail();

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
           


             $(".close-image").on('click', function () {
                 $('#popup').hide();
                 $('#overlay-back').fadeOut(100);
             });

             $("#btnCancel").on('click', function () {
                 $('#popup').hide();
                 $('#overlay-back').fadeOut(100);
                 ClearCabDetail();
             });
             $("#btnSubmit").click(function (e) {
                

                 var valid = $("#frmManageRole").validationEngine('validate');
              
                 if (valid) {
                     e.preventDefault();
                     InsertRole();
                     ClearCabDetail();
                 }
             });

           
             //$("#aInActiveRole").click(function () {
            
             //    GetInActiveRole();
             //});

         });

        

         function GetRoleType()
         {
             $.ajax({
                 type: "POST",
                 url: "ManageRole.aspx/GetRoleType",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var dcJSON = result.d;
                 
                     if (dcJSON != null) {
                         $.each(dcJSON, function (index, value) {
                             $('#ddlRoleAcess').append($("<option></option>").val(value.RoleTypeId).html(value.RoleTypes));
                         });
                     }
                 },
                 error: function (er) {
                     alert(er);
                 }
             });

         }

         //function GetInActiveRole()
         //{
         //    $.ajax({
         //        type: "POST",
         //        url: "ManageRole.aspx/GetInActiveRole",
         //        contentType: "application/json; charset=utf-8",
         //        dataType: "json",
         //        success: function (result) {
         //            var dcJSON = result.d;
                 
         //            if (dcJSON != null) {
         //                $.each(dcJSON, function (index, value) {
         //                    $('#ddlRoleAcess').append($("<option></option>").val(value.RoleTypeId).html(value.RoleTypes));
         //                });
         //            }
         //        },
         //        error: function (er) {
         //            alert(er);
         //        }
         //    });

         //}


         function GetRoleDetail() {
             
             $.ajax({
                 type: "POST",
                 url: "ManageRole.aspx/GetRoleDeatil",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (result) {
                     var roledetail = result.d;

                     $("#tblLstRoleDetail").dataTable({
                         destroy: true,
                         paging: true,
                         "bStateSave": true,
                         "data": roledetail,
                         "aoColumns": [
                            {
                                "data": "RoleId", "bSortable": false, render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox'/>";
                                }
                            },
                           { "data": "RoleName" },
                           { "data": "RoleAccess" },
                           { "data": "CreatedDate" },
                           { "data": "CreatedBy" },
                           { "data": "ModifiedDate" },
                           { "data": "ModifiedBy" },
                                                  
                   
                           { "data": "IsActive" },

                         {
                             "data": "RoleId", "bSortable": false, render: function (data, type, row) {
                                 return "<a id='" + data + "' href='#' onClick='EditRoleDetail(this)'>Edit</a>";
                             }
                         }



                         ],
                         "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                             if (!aData.IsActive)
                                 $(nRow).css("background-color", "rgb(255, 194, 0)");
                         }


                     })

                 }


             })



         }

      

         function InsertRole()
         {
             
             var objRole = new RoleDetail();
             objRole.RoleAccess = $("#ddlRoleAcess").val();
             objRole.RoleName = $("#txtrolename").val();
             objRole.IsActive = JSON.parse($("#ddlIsActive").val());
             if (objRole.RoleName != '') {
                 $.ajax({
                     type: "Post",
                     url: "ManageRole.aspx/InsertRole",
                     data: "{'Roledetail':" + JSON.stringify(objRole) + "}",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",

                     success: function (result) {
                         var msg = result.d;
                         if (msg == 1) {

                             $('#popup').hide();
                             $('#overlay-back').fadeOut(100);
                             alert("RoleName Added Successfully");
                             ClearCabDetail();
                             GetRoleDetail();
                         }
                         else {
                             alert("Role Name Already Exists");
                         }

                     },
                     error: function (er) {

                         alert(er);
                     }

                 })
             }
             else {
                 alert("Enter Valid Role Name!")
             }

         }


         function ClearCabDetail() {
             $("#txtrolename").val("");
         }
            
          function EditRoleDetail(e)
         {
                 //hide validation message if any
                 $("#frmManageRole").validationEngine('hideAll');
                 //hide submit button and show Update button
                 $("#btnSubmit").hide();
                 $("#btnUpdate").show();

                 var vall = e.attributes["id"].value;
               
                 $("#hdnRoleId").text(vall);
                 //get parent row
                 var row = $(e).parent().parent();
                 var tdRoleName= row[0].cells[1].innerText;//RleName    //index 0 for checkbox
                 var tdRoleAcess = row[0].cells[2].innerText;//RoleAcess
                 var tdIsActive = row[0].cells[7].innerText;//IsActive
                 $("#txtrolename").val(tdRoleName);
                 //set ddl For Role Access
                 $("#ddlRoleAcess option").each(function () {
                     if ($(this).text().trim() == tdRoleAcess.trim()) {
                         $(this).attr('selected', 'selected');
                     }
                 });
                 //set ddl For Role Access
                 $("#ddlIsActive option").each(function () {
                     if ($(this).text().trim() == tdIsActive.trim()) {
                         $(this).attr('selected', 'selected');
                     }
                 });
                     $('#overlay-back').fadeIn(100, function () {
                     $('#popup').show();
                 });


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
                <td><a href="#" id="aCreateRole">Add New User </a></td>
                <td class="width20"></td>
                <td><a href="#" id="aDeleteRole">Delete User</a></td>
                </tr>
            </table>
        </div>
    </div>
    <br/>
    <br/>
    
 <table width="100%" class="display" id="tblLstRoleDetail" cellspacing="0">
        <thead>
            <tr class="tablerow">
                 <th>Select</th>
                <th>UserName</th>
                <th>RoleAccess</th>
                <th>CreatedDate</th>
                <th>CreatedBy</th>
                <th>ModifiedDate</th>
                <th>ModifiedBy</th>                
                <th>IsActive</th>
                 <th>Action</th>
            </tr>
        </thead>

    </table>

    

  
    <div id="popup" ><img class="close-image" src="../Images/close.png" />

      <form id="frmManageRole" method="post">
         
              <label>
                  <b>Create Role:</b>
              </label>
       

          <table id="tblinputdetail"  class="display">
              <tr class="displayNone">
                  <td></td>
                  <td></td>
                  <td>
                      <input id="hdnRoleId" type="hidden" value="" />
                      
                  </td>
              </tr>
              <tr>
                  <td>User Name:</td>
                  <td><input id="txtrolename" name="txtrolename" class="validate[required]"  type="text" /></td>
              </tr>
              <tr>
                  <td >Role Access:</td>
                  <td> <select id="ddlRoleAcess" style="width: 152px; " class="validate[required]">
           
                       </select> </td>
              </tr>
              <tr>
                  <td>IsActive:</td>
                  <td>
                    <select id="ddlIsActive"  style="width: 152px; " class="validate[required]">
                      <option value="true">Active</option>
                       <option value="false">In-Active</option>
                    </select>

                  </td>
               </tr>
                      
           </table>
           
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
    <form>
      <div id="overlay-back"></div>
     <div id="pageloaddiv"></div>
        <div id="tmp" style="height:20px"></div>

 

    <script type="text/javascript">
        $(document).ready(function () {

            var valid = $("#frmManageRole").validationEngine();

            //disable special characters
            $('#frmManageRole').bind('keypress', function (e) {

                var key = e.which;
                var ok = key >= 65 && key <= 90 || // A-Z
                    key >= 97 && key <= 122 || // a-z
                    key >= 48 && key <= 57 || //0-9
                    key == 35 || // #
                    key == 46 || //.
                    key == 44 || //,
                    key == 64 || //@
                    key == 58 || //:
                    key == 40 || //(
                    key == 41  //)
                ;
                if (!ok) {
                    e.preventDefault();
                }
            });
        }
        );
    </script>   

    </form>

</asp:Content>

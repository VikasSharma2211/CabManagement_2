<%@ Page Title="DC Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DCManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.DCManagement" %>

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
            z-index: 10;
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

        #wgtmsr {
            width: 150px;
        }

        .close-image {
            display: block;
            float: right;
            position: relative;
            top: -10px;
            right: -10px;
            height: 20px;
        }

        .displayNone {
            display: none;
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

        .bgColorRed {
            background-color: red;
        }

        .tablerow {
            background: #017dc3;
            color: white;
        }

    </style>

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

        function DC(DCId, DCName, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, IsActive) {
            this.DCId = DCId;
            this.DCName = DCName;
            this.IsActive = IsActive;
            this.CreatedDate = CreatedDate;
            this.CreatedBy = CreatedBy;
            this.ModifyDate = ModifiedDate;
            this.ModifyBy = ModifiedBy;
        }

        $(document).ready(function () {
            $("#frmManageDC").validationEngine();

            $("#pageloaddiv").fadeIn(1000);
            $('#overlay-back').fadeIn(1000);

            $("#pageloaddiv").fadeOut(500);
            $('#overlay-back').fadeOut(500);

            //end code to load 
            GetDCType();
            GetDCDetail();

            //to show popup to create a new DC           
            $("#aCreateDC").click(function () {
                //hide validation message if any
                $("#frmManageDC").validationEngine('hideAll');
                //hide update button and show submit button
                $("#btnSubmit").show();
                $("#btnUpdate").hide();

                $('#overlay-back').fadeIn(100, function () {
                    $('#popup').show();

                });



            });

            $("#aDeleteDC").click(function () {


                $.ajax({
                                type: "POST",
                                url: "DCManagement.aspx/DeleteDC",
                                data: "{'RoleId':'" + SelectRoleId + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    var msg = result.d;
                                    if (msg) {

                                        ClearCabDetail();
                                        GetDCDetail();
                                    }
                                   

                                },
                                error: function (er) {
                                    alert(er.responseText);
                                }
                            })
                        });


      
            //to update details

            $("#btnUpdate").on('click', function () {

                var valid = $("#frmManageDC").validationEngine('validate');
                if (valid) {

                    var objRole = new DC();
                    objRole.DCId = $("#hdnRoleId").val();
                    objRole.DCName = $("#txtrolename").val();
                    objRole.IsActive = JSON.parse($("#ddlIsActive").val());
                    if (objRole.DCName != '') {
                        $.ajax({
                            type: "POST",
                            url: "DCManagement.aspx/UpdateDC",
                            data: "{'roledetail':" + JSON.stringify(objRole) + "}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (result) {
                                var msg = result.d;
                                if (msg == 'Exists') {
                                    alert("DC Already Exists")
                                }
                                else {
                                    $('#popup').hide();
                                    $('#overlay-back').fadeOut(100);
                                    // alert(msg)
                                    ClearCabDetail();
                                    GetDCDetail();
                                }



                            },
                            //else {
                            //    alert("Error Occured");
                            //}


                            error: function (er) {
                                alert(er.responseText);
                            }
                        })
                    }
                    else
                    {
                        alert("Enter Valid DC Name!")
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
            $("#btnSubmit").click (function (e) {

                var valid = $("#frmManageDC").validationEngine('validate');

                if (valid) {

                    e.preventDefault();
                    InsertDC();
                    ClearCabDetail();
                }
            });




        });

        function GetDCType() {
            $.ajax({
                type: "POST",
                url: "DCManagement.aspx/GetDCType",
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


        function GetDCDetail() {
            $.ajax({
                type: "POST",
                url: "DCManagement.aspx/GetDCDetail",
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
                               "data": "DCID"
                           },
                          { "data": "DCName" },

                          { "data": "CreatedDate" },
                          { "data": "CreatedBy" },
                          { "data": "ModifiedDate" },
                          { "data": "ModifiedBy" },


                          { "data": "IsActive" },

                          {"data": "IsActive", "bSortable": false, render: function (data, type, row) {
                            if (data) {
                             return "<img src='../Images/active_bulb.jpg' height='25px' width='25px' />";
                            }
                           else {
                              return "<img src='../Images/Inactive_bulb.jpg' height='25px' width='25px'/>";
                              }


                                 }
                             },

                        {
                            "data": "DCId", "bSortable": false, render: function (data, type, row) {
                                return "<a id='" + data + "' href='#' onClick='EditDCDetail(this)'>Edit</a>";
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

        function InsertDC() {
           
            //var dc = new DC();
            var SelectedShiftIds = $("#txtrolename").val();
            var isActive = JSON.parse($("#ddlIsActive").val());
            if (SelectedShiftIds != '') {
            $.ajax({
                type: "Post",
                    url: "DCManagement.aspx/InsertDC",
                //data: JSON.stringify(dc),
                data: "{'DCName':'" + SelectedShiftIds + "','IsActive':'" + isActive + "'}",
             
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (result) {
                    var msg = result.d;
                        if (msg == 'E') {
                            alert("DC Already Exist");
                        }
                        else {

                        $('#popup').hide();
                        $('#overlay-back').fadeOut(100);

                            //alert(msg);
                            alert("New DC Added");

                        ClearCabDetail();
                            GetDCDetail();
                    }

                },
                error: function (er) {

                    alert(er.responseText);
                }

            })
            }
            else {

                alert('Please Enter Valid DCName!');

        }
        }


        function ClearCabDetail() {
            $("#txtrolename").val("");
        }

        function EditDCDetail(e) {  //hide validation message if any
            $("#frmManageDC").validationEngine('hideAll');
            //hide submit button and show Update button
            $("#btnSubmit").hide()
            $("#btnUpdate").show();

            var vall = e.attributes["id"].value;

          //  $("#hdnRoleId").text(vall);
            //get parent row
            var row = $(e).parent().parent();
            var tdRoleName = row[0].cells[1].innerText;
            var tdDCId = row[0].cells[0].innerText;


            //RleName    //index 0 for checkbox
            // var tdRoleAcess = row[0].cells[2].innerText;//RoleAcess
            var tdIsActive = row[0].cells[6].innerText;//IsActive
            $("#txtrolename").val(tdRoleName);
            $("#hdnRoleId").val(tdDCId);

            //set ddl For Role Access
            //$("#ddlRoleAcess option").each(function () {
            //    if ($(this).text().trim() == tdRoleAcess.trim()) {
            //        $(this).attr('selected', 'selected');
            //    }
            //});
            ////set ddl For Role Access
            //$("#ddlIsActive option").each(function () {
            //    if ($(this).text().trim() == tdIsActive.trim()) {
            //        $(this).attr('selected', 'selected');
            //    }
            //});
            $('#overlay-back').fadeIn(100, function () {
                $('#popup').show();
            });


        }







    </script>





</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp
    <a href="#" id="aCreateDC">ADD NEW DC</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     
    <br />
    <br />

    <table width="100%" class="display" id="tblLstRoleDetail" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>DC Id</th>

                <th>DC Name</th>

                <th>CreatedDate</th>
                <th>CreatedBy</th>
                <th>ModifiedDate</th>
                <th>ModifiedBy</th>
                <th>IsActive</th>
                <th class="width10">Status</th>
                <th>Action</th>
            </tr>
        </thead>

    </table>




    <div id="popup">
        <img class="close-image" src="../Images/close.png" />

        <form id="frmManageDC" method="post">

            <label>
                <b>Enter DC Details</b>
            </label>


            <table id="tblinputdetail" class="display">
                <tr class="displayNone">
                    <td></td>
                    <td></td>
                    <td>
                        <input id="hdnRoleId" type="hidden" value="" />

                    </td>
                </tr>
             
                <tr>
                    <td>DC Name:</td>
                    <td>
                        <input id="txtrolename" name="txtrolename" class="validate[required]" type="text" required="required"
                            /></td>
                </tr>


                <tr>
                    <td>IsActive:</td>
                    <td>
                        <select id="ddlIsActive" style="width: 152px;" class="validate[required]">
                            <option value="1" selected="selected">Active</option>
                            <option value="0">In-Active</option>
                        </select>

                    </td>
                </tr>

            </table>

            <table>


                <tr>
                    <td></td>
                    <td>
                        <input id="btnSubmit" class="submit" type="submit" value="Submit" />
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
        <div id="tmp" style="height: 20px"></div>



        <script type="text/javascript">
            $(document).ready(function () {

                var valid = $("#frmManageDC").validationEngine();

                //disable special characters
                $('#frmManageDC').bind('keypress', function (e) {

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

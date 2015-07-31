<%@ Page Title="Route Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Route.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.RouteMaster" %>

<%--<%@ Import Namespace="Infosys.CabManagement.Model" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        var status = {
            activeStatus: "active",
            inActiveStatus: "inactive"
        };
        //document.write("<a href='ShiftManagement.aspx'>ShiftManagement.aspx</a>");
        var statusRunning;

        function RouteMaster(DPID, RouteName, SortOrder, DropPoint, DCID, DCName, IsActive) {
            this.DPID = DPID;
            //this.RouteID = RouteID;
            this.RouteName = RouteName;
            this.SortOrder = SortOrder;
            this.DropPoint = DropPoint;
            this.DCID = DCID;
            this.DCName = DCName;
            this.IsActive = IsActive;
        }

        $(document).ready(function () {

            $("#pageloaddiv").fadeOut(500);
            //show active list initially
            statusRunning = status.activeStatus;
            $("#spnActiveInactive").text("InActivate");
            $("#btnSubmitDropPoint").show();
            $("#btnUpdateDropPoint").hide();
            // Change Event for Route Acc to Dc
            $("#ddlDC1").change(function () {
                GetSelectedRoute();
            });
            //Getting DC List
            GetDCList();
            //code to load active all Routes list
            GetAllActiveRoutes();

            //GetAllRoutesAccoringToDC();
            //end code to load active all DC list

            //to show popup to create a new vendor   

            $("#aCreateRoute").click(function () {
                $('#overlay-back').fadeIn(500, function () {
                    $('#popup').show();
                    ClearRoute();
                });
            });
            $(".close-image").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(500);
            });

            $("#aCreateDropPoint").click(function () {
                $('#overlay-back').fadeIn(500, function () {
                    $('#popup1').show();
                    $("#btnSubmitDropPoint").show();
                    $("#btnUpdateDropPoint").hide();
                    ClearDropPoint();
                    // ClearVendor();
                });
            });
            $(".close-image").on('click', function () {
                $('#popup1').hide();
                $('#overlay-back').fadeOut(500);
            });
            //cancelling the pop up of Route
            $("#btnCancel1").on('click', function () {
                $('#popup').hide();
                $('#overlay-back').fadeOut(500);
                ClearRoute();
            });
            //cancelling the pop up of Drop Point
            $("#btnCancelRoute").on('click', function () {
                $('#popup1').hide();
                $('#overlay-back').fadeOut(500);
                ClearDropPoint();
            });

            //Filling DropPoints Drop down According to Route
            function GetSelectedRoute() {

                var objRoute = new RouteMaster();
                objRoute.DCID = $("#ddlDC1").val();
                //$('#ddlRouteName').empty();

                $.ajax({
                    type: "POST",
                    url: "Route.aspx/GetSelectedroute",
                    data: "{'ObjRouteMaster':" + JSON.stringify(objRoute) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        var dcJSON = result.d;
                        if (dcJSON != null) {
                            var select = $('#ddlRouteName');
                            select.children().remove();
                            select.append($("<option>").val(0).text('Select'));
                            $.each(dcJSON, function (index, value) {
                                $('#ddlRouteName').append($("<option></option>").val(value.RouteID).html(value.RouteName));
                            });
                        }
                    },
                    error: function (er) {
                        alert(er);
                    }
                });
            }
            
            //Fetching the DC List
            function GetDCList() {
                $.ajax({
                    type: "POST",
                    url: "Route.aspx/GetDCList",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        var select = $('#ddlDC');
                        select.children().remove();
                        select.append($("<option>").val(0).text('Select'));
                        var dcJSON = result.d;
                        if (dcJSON != null) {
                            $.each(dcJSON, function (index, value) {
                                $('#ddlDC').append($("<option></option>").val(value.DCID).html(value.DCName));
                            });
                        }
                        var select = $('#ddlDC1');
                        select.children().remove();
                        select.append($("<option>").val(0).text('Select'));
                        var dcJSON = result.d;
                        if (dcJSON != null) {
                            $.each(dcJSON, function (index, value) {
                                $('#ddlDC1').append($("<option></option>").val(value.DCID).html(value.DCName));
                            });
                        }
                    },
                    error: function (er) {
                        alert(er);
                    }
                });
            }
            //Adding New Route
            $("#btnSubmitRoute").on('click', function (e) {

                e.preventDefault();
                var valid = $("#form1").validationEngine('validate');
                if (valid) {
                    var objRoute = new RouteMaster();
                    objRoute.RouteName = $("#txtRoute").val();
                    objRoute.DCID = $("#ddlDC").val();

                    $.ajax({
                        type: "POST",
                        url: "Route.aspx/AddNewRoute",
                        data: "{'ObjRouteMaster':" + JSON.stringify(objRoute) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg) {
                                $('#popup').hide();
                                $('#overlay-back').fadeOut(500);
                                GetAllActiveRoutes();
                                statusRunning = status.activeStatus;
                                $("#spnActiveInactive").text("InActivate");
                                //GetAllRoutesAccoringToDC();
                            }
                            else {
                                alert("Route Name already exist!!!");
                            }

                        },
                        error: function (er) {
                            alert(er.responseText);
                        }
                    })
                }

            });
            // Adding New Drop Points
            $("#btnSubmitDropPoint").on('click', function (e) {

                e.preventDefault();
                var valid = $("#form1").validationEngine('validate');
                if (valid) {
                    var objRoute = new RouteMaster();
                    objRoute.RouteID = $('#ddlRouteName>option:selected').val();
                    objRoute.RouteName = $('#ddlRouteName>option:selected').text();//$("#ddlRouteName").text();
                    objRoute.DCID = $("#ddlDC1").val();
                    objRoute.DropPoint = $("#txtDropPointName1").val();
                    objRoute.SortOrder = $("#txtSortOrder").val();
                    $.ajax({
                        type: "POST",
                        url: "Route.aspx/AddNewDropPoint",
                        data: "{'ObjRouteMaster':" + JSON.stringify(objRoute) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == 1) {
                                $('#popup1').hide();
                                $('#overlay-back').fadeOut(500);
                                GetAllActiveRoutes();
                                statusRunning = status.activeStatus;
                                $("#spnActiveInactive").text("InActivate");
                                //GetAllRoutesAccoringToDC();
                            }
                            else {
                                alert("Drop Point Already Exists");
                                $('#popup1').hide();
                                $('#overlay-back').fadeOut(500);
                                GetAllActiveRoutes();
                                statusRunning = status.activeStatus;
                                $("#spnActiveInactive").text("InActivate");
                            }

                        },
                        error: function (er) {
                            alert(er);
                        }
                    })
                }

            });

            //Multiple Deleting Drop Points
            $("#btnDelete").on('click', function () {

                var SelectedRouteIDs = "";
                var chkchecked = $("#tblLstRoute input[type=checkbox]:checked").length;
                if (chkchecked > 0) {
                    if (confirm("Are you sure to delete the selected " + chkchecked + " Routes?")) {
                        var chkSelected = $("#tblLstRoute input[type=checkbox]:checked");
                        for (var i = 0; i < chkchecked; i++) {
                            var chkid = chkSelected[i].attributes["id"].value.substring(3);
                            SelectedRouteIDs += chkid + ',';
                        }
                        if (SelectedRouteIDs != null) {
                            SelectedRouteIDs = SelectedRouteIDs.substring(0, SelectedRouteIDs.length - 1);
                            ActiveInactiveRoutes(SelectedRouteIDs);
                        }
                    }
                }
                else {
                    if (statusRunning == status.activeStatus) {
                        alert("Select atleast 1 route to inactivate!!!");
                    }
                    else {
                        alert("Select atleast 1 route to activate!!!");
                    }
                }
            });

            $("#aInActiveRoutes").click(function () {
                GetAllInactiveRoutes();
                statusRunning = status.inActiveStatus;
                $("#spnActiveInactive").text("Activate");
            });

            $("#aActiveRoutes").click(function () {
                GetAllActiveRoutes();
                statusRunning = status.activeStatus;
                $("#spnActiveInactive").text("Inactivate");
            });

            $("#btnUpdateDropPoint").click(function (e) {

                e.preventDefault();
                var valid = $("#form1").validationEngine('validate');


                if (valid) {
                    var objRoute = new RouteMaster();
                    objRoute.DPID = $('#hdnDPID').text();// DPID
                    objRoute.RouteName = $('#ddlRouteName>option:selected').text(); //$("#ddlRouteName").text();
                    objRoute.DropPoint = $("#txtDropPointName1").val();
                    objRoute.SortOrder = $("#txtSortOrder").val();
                    objRoute.DCID = $("#ddlDC1>option:selected").val();
                    
                    $.ajax({
                        type: "POST",
                        url: "Route.aspx/UpdateDropPoint",
                        data: "{'ObjRouteMaster':" + JSON.stringify(objRoute) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg == '1') {
                                $('#popup1').hide();
                                $('#overlay-back').fadeOut(500);
                                //  ClearDropPoint();
                                // GetAllActiveRoutes();
                                if (statusRunning == status.activeStatus) {
                                    GetAllActiveRoutes();
                                    $("#spnActiveInactive").text("Inactivate");
                                }
                                else {
                                    GetInActiveVendorList();
                                    $("#spnActiveInactive").text("Activate");
                                }
                            }
                            else {
                                alert("Route Already Exists");
                            }

                        },
                        error: function (er) {
                            alert(er.responseText);
                        }
                    })
                }
            });

        });
        // to update the existing route


        function EditDropPoint(e) {
            
            ClearDropPoint();

            //hide validation message if any
            $("#form1").validationEngine('hideAll');
            //hide update button and show submit button
            $("#btnSubmitDropPoint").hide();
            $("#btnUpdateDropPoint").show();

            //$("#hdnDPID").val(e.id);//(e.attributes["id"].value);
            
            var vall = e.attributes["id"].value;

            $("#hdnDPID").text(vall);

            //get parent row
            var row = $(e).parent().parent();

            var tdRouteName = row[0].cells[1].innerText;//RouteName    //index 0 for checkbox
            var tdDropPoint = row[0].cells[2].innerText;//DropPoint
            var tdSortOrder = row[0].cells[3].innerText;//SortOrder
            var tdDCName = row[0].cells[4].innerText;//DCName           

            $('#overlay-back').fadeIn(100, function () {
                $('#popup1').show();
            });

            $("#txtDropPointName1").val(tdDropPoint);
            $("#txtSortOrder").val(tdSortOrder);
            $("#ddlDC1 option").each(function () {
                console.log("ddl TEXT :'" + $(this).text().trim() + "'       DCName:" + tdDCName.trim());
                if ($(this).text().trim() == tdDCName.trim()) {
                    $(this).attr('selected', 'selected');
                    $(this).change();
                }
            });
            //$("#ddlRouteName").val(tdRouteName.trim()).change();
            $("#ddlRouteName option").each(function () {
                console.log("ddl TEXT :'" + $(this).text().trim() + "'       Route:'" + tdRouteName.trim() + "'");
                if ($(this).text().trim() == tdRouteName.trim()) {
                    $(this).attr('selected', 'selected');
                }
            });

            
            //ActiveInactiveRoutes(SelectedRouteIDs);

            //$("#ddlRouteName option").each(function () {
            //    console.log("ddl TEXT :'" + $(this).text().trim() + "'       Route:'" + tdRouteName.trim()+"'");
            //    if ($(this).text().trim() == tdRouteName.trim()) {
            //        $(this).attr('selected', 'selected');
            //    }
            //});
            //set ddl

        }


        function ActiveInactiveRoutes(SelectedRouteIDs) {

            var isActive = (statusRunning != status.activeStatus);

            var objRoute = new RouteMaster();
            objRoute.IsActive = isActive;
            objRoute.RouteIDs = SelectedRouteIDs;
            $.ajax({
                type: "POST",
                url: "Route.aspx/DeleteRoutes",
                data: "{'ObjRouteMaster':" + JSON.stringify(objRoute) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                        if (statusRunning == status.activeStatus) {
                            GetAllActiveRoutes();
                            $("#spnActiveInactive").text("Inactivate");
                        }
                        else {
                            GetAllInactiveRoutes();
                            $("#spnActiveInactive").text("Activate");
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

        //Fetching All Routes and filling the table
        function GetAllActiveRoutes() {
            $.ajax({
                type: "POST",
                url: "Route.aspx/GetAllActiveRoutesList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listRoute = result.d;
                    if (listRoute == null)
                        listRoute = [];
                    $('#tblLstRoute').dataTable({
                        destroy: true,
                        paging: true,
                        "bsorting": true,
                        "data": listRoute,
                        "aoColumns": [
                            {
                                "data": "DPID", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox' class='chkSelect' style='width: 50px;'>";
                                }
                            },
                           // { "data": "RouteID" },
                            { "data": "RouteName" },
                            { "data": "DropPoint" },
                            { "data": "SortOrder" },
                            { "data": "DCName" },
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
                                "data": "DPID", "bSortable": false, render: function (data, type, row) {
                                    //var strReturn = "<a id='" + data + "' href='#' onClick='EditDropPoint(this)'>Edit</a>";
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditDropPoint(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected route?\")) ActiveInactiveRoutes(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected route?\")) ActiveInactiveRoutes(" + data + ");else return false;'>Activate</a>";
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

        function GetAllInactiveRoutes() {
            $.ajax({
                type: "POST",
                url: "Route.aspx/GetAllInactiveRoutesList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var listRoute = result.d;
                    if (listRoute == null)
                        listRoute = [];
                    $('#tblLstRoute').dataTable({
                        destroy: true,
                        paging: true,
                        "bsorting": true,
                        "data": listRoute,
                        "aoColumns": [
                            {
                                "data": "DPID", render: function (data, type, row) {
                                    return "<input id='chk" + data + "' type='checkbox' class='chkSelect' style='width: 50px;'>";
                                }
                            },
                            //{ "data": "RouteID" },
                            { "data": "RouteName" },
                            { "data": "DropPoint" },
                            { "data": "SortOrder" },
                            { "data": "DCName" },
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
                                "data": "DPID", "bSortable": false, render: function (data, type, row) {
                                    var strReturn = "<a id='" + data + "' href='#' onClick='EditDropPoint(this)'>Edit</a>";
                                    if (row.IsActive) {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to inactivate the selected route?\")) ActiveInactiveRoutes(" + data + ");else return false;'>Inactivate</a>";
                                    }
                                    else {
                                        strReturn += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='Active_Inactive_" + data + "' href='#' onClick='if(confirm(\"Are you sure to activate the selected route?\")) ActiveInactiveRoutes(" + data + ");else return false;'>Activate</a>";
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
        //Clear Route
        function ClearRoute() {
            $("#txtRoute").val("");
            $("#ddlDC").val("0");
            //$('#ddlDC').empty();
        }
        // Clear Drop Point
        function ClearDropPoint() {
            //$("#txtDropPointName1").selectedIndex=0;
            //$("#ddlDC1").selectedIndex = 0;
            //$("#ddlRouteName").selectedIndex = 0;
            $("#txtDropPointName1").val("");
            $("#ddlDC1").val("0");
            $("#ddlRouteName").val("0");
            $("#txtSortOrder").val("");
            $("#txtDropPointName1").val("");
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
                    <td><a href="#" id="aCreateRoute">Add New Route</a></td>
                    <td class="width20"></td>
                    <td><a href="#" id="aCreateDropPoint">Add New Drop Point</a></td>
                    <td class="width20"></td>
                    <td><a href="#" id="aActiveRoutes">View Active Routes</a></td>
                    <td class="width20"></td>
                    <td><a href="#" id="aInActiveRoutes">View Inactive Routes</a></td>
                    <td class="width20"></td>
                    <td><a href="#" id="btnDelete"><span id="spnActiveInactive">Inactivate</span> Selected Drop Point</a></td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <br />

    <table width="100%" class="cell-border paddingtop15" id="tblLstRoute" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Select</th>
                <th>RouteName</th>
                <th>DropPoint</th>
                <th>SortOrder</th>
                <th>DC Name</th>
                <th class="width37">Status
                </th>
                <th class="width73">Action</th>
            </tr>
        </thead>
    </table>


    <div id="popup">
        <img class="close-image" src="../Images/close.png" />
        <fieldset>
            <label>
                <b>Create a New Route</b>
            </label>
        </fieldset>
        <table>
            <tr>
                <td>DC Related to:</td>
                <td>
                    <select id="ddlDC" class="validate[required]"></select></td>
            </tr>
            <tr>
                <td>Route Name:</td>
                <td>
                    <input id="txtRoute" class="validate[required] text-input" type="text" maxlength="50" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input id="btnSubmitRoute" class="submit" type="submit" value="Submit" />
                    &nbsp;&nbsp;<input id="btnCancel1" type="button" value="Cancel" />
                </td>

            </tr>
        </table>
    </div>

    <div id="popup1">
        <img class="close-image" src="../Images/close.png" />
        <fieldset>
            <label>
                <b>Create a New Drop Point</b>
            </label>
        </fieldset>
        <table>
            <tr class="displayNone">
                <td></td>
                <td><%--<input id="hdnRouteId" type="hidden" value="" />--%>
                    <input id="hdnDPID" type="hidden" value="" />
                </td>
            </tr>
            <tr>
                <td>DC Related to:</td>
                <td>
                    <select id="ddlDC1" class="validate[required]"></select></td>
            </tr>
            <tr>
                <td>Route Name:</td>
                <td>
                    <select id="ddlRouteName" class="validate[required]"></select>
                </td>
            </tr>
            <tr>
                <td>SortOrder:</td>
                <td>
                    <input id="txtSortOrder" class="validate[required] text-input" type="text" maxlength="2" />
                </td>
            </tr>
            <tr>
                <td>Drop Point:</td>
                <td>
                    <input id="txtDropPointName1" class="validate[required] text-input" type="text" maxlength="50" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input id="btnSubmitDropPoint" type="submit" class="submit" value="Submit" />
                    <input id="btnUpdateDropPoint" type="button" value="Update" />
                    &nbsp;&nbsp;<input id="btnCancelRoute" type="button" value="Cancel" />
                </td>

            </tr>
        </table>
    </div>

    <div id="overlay-back"></div>
    <div id="pageloaddiv"></div>
    <script type="text/javascript">
        $(document).ready(function () {

            //disable special characters
            $('#txtSortOrder').bind('keypress', function (e) {
                if (parseInt(e.key) < 1) {
                    e.preventDefault();
                    return;
                }
                var key = e.which;
                var ok = key >= 48 && key <= 57;
                // key >= 65 && key <= 90 || // A-Z
                // key >= 97 && key <= 122 || // a-z
                // key >= 48 && key <= 57 || //0-9
                //key == 35 || // #
                // key == 46 || //.
                // key == 44 || //,
                // key == 64 || //@
                // key == 58 || //:
                // key == 40 || //(
                // key == 41 || //)
                // key == 32  //space
                ;

                if (!ok) {
                    e.preventDefault();
                }

            });
        });
    </script>
</asp:Content>

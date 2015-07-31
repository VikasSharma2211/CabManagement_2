<%@ Page   EnableEventValidation="false"  Title="Roster Management" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RoosterManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.RosterManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .tablecss {
            width: auto;
            height: auto;
        }

        .tdcss {
            padding-left: 10px;
        }

        .Rostertableclass {
            height: 50px !important;
            overflow:hidden !important;
        }

        .textwrap {
            width: 100px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            color: red;
        }

       .print_class{

            background:yellow;
        }
        #btnSubmit {
            height: 26px;
        }
    </style>
    <link href="../CSS/style.css" rel="stylesheet" />
    <%--datepicker--%>
    <link href="../CSS/jquery-ui.css" rel="stylesheet" />
    <link href="../CSS/uploadfile.css" rel="stylesheet" />

    <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

    <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
    <link href="../CSS/datatable/dataTables.tableTools.min.css" rel="stylesheet" />
    <!-- jQuery -->

    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/jquery.js"></script>
    <script src="../Scripts/jquery.uploadfile.js"></script>

    <%--validation--%>
    <script src="../Scripts/jquery.validationEngine-en.js"></script>

    <script type="text/javascript" src="../Scripts/jquery.validationEngine.js"></script>

    <%--datepicker--%>
    <script src="../Scripts/DatePicker/jquery-ui.js"></script>

    <!-- DataTables -->
    <script src="../Scripts/DataTable/jquery.dataTables.js"></script>
    <script src="../Scripts/DataTable/dataTables.tableTools.min.js"></script>
    <script src="../Scripts/CabManagementScript/RoosterManagement.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="accordion">
        <h3>Actions></h3>

        <div class="Rostertableclass">
       
            <table class="tablecss">

                <tr class="displayNone">
                    <td></td>
                    <td>
                        <input id="hdnid" type="hidden" value="" /></td>
                </tr>
                <tr>
                 <td> 
                     <a href="#" id="Reprint">Reprint</a>

                 </td>
                    <td style="display:none">  </td>
                    <td class="tdcss">                   
                     <asp:LinkButton ID="RoosterPdf"  runat="server" OnClick="RoosterPdf_Click">Generate PDF</asp:LinkButton>
                 </td>
 
                    <td class="tdcss">Select Roster File:

                    </td>

                    <td class="tdcss">

                        <div id="fileuploader">Upload</div>

                    </td>

                    <td>

                        <input id="btnSubmit" class="submit" type="button" value="Validate" onclick="ValidateUploadedRoster()" />
                    </td>
                  
                    <td>
                        <div class="XLError"></div>
                    </td>

                </tr>

            </table>

            <div id="reprintdiv" style="display:none">



            </div>


        </div>
    </div>
    <br />

    <table  class="display compact" id="tblLstrosterunmapped" cellspacing="0" width="100%" style="margin-top:10px">
        <thead>
            <tr class="tablerow">
                <th>CabNo</th>
                <th>CabCapacity</th>
                <th>RouteName</th>
            <%--    <th>CabValid</th>--%>
             <%--   <th>EmpValid</th>--%>
                <th>RoosterDate</th>
                <th>EmpNumber</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Address</th>
                <th>LandMark</th>
                <th>Contact</th>
                <th>PickUpTime</th>
                <th>PickUporder</th>
                 <th>ShiftTime</th>
                <th>Vendor</th>
                <th>CabType</th>
                <th>Sign</th>

            </tr>
        </thead>

    </table>
     <form>
        <div id="overlay-back"></div>
        <div id="pageloaddiv"></div>
        <input type="hidden" id="hdnRooster" name="hdnRooster"/>
    </form>
</asp:Content>
    
   

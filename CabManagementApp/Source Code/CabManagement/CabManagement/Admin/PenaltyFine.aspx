<%@ Page Title="Penalty/Fine" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PenaltyFine.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.PenaltyFine" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
         <!-- jQuery -->
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <%--validation--%>
    <script src="../Scripts/jquery.validationEngine-en.js"></script>
    <script src="../Scripts/jquery.validationEngine.js"></script>
    

  
    <!-- DataTables -->    
    <script src="../Scripts/DataTable/jquery.dataTables.js"></script>


    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
     <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.validationEngine-en.js"></script>
    <script src="Scripts/jquery.validationEngine.js"></script>
    <script type="text/javascript">

        function PenaltyDetails(DCID, RequestedDate,CabID, RequestedTime, PenaltyAmount, PenaltyRemarks) {
           
            this.CabID = CabID;
            this.DCID = DCID;            
            this.RequestedDate = RequestedDate;
            this.RequestedTime = RequestedTime;
            this.PenaltyAmount = PenaltyAmount;
            this.PenaltyRemarks = PenaltyRemarks;           
        }
        $(document).ready(function () {
            $("#pageloaddiv").fadeIn(500);
            $('#overlay-back').fadeIn(500);
            $("#frmImposePenalty").validationEngine('hideAll');

            $('#popupPenalty').hide();
            $(".close-image").on('click', function () {
                $('#popupPenalty').hide();
                $('#overlay-back').fadeOut(100);
            });

            //to popup impose penalty.
            $("#aImposeFine").click(function () {
                //hide validation message if any
                $("#frmImposePenalty").validationEngine('hideAll');
              
                //hide update button and show submit button
                $("#btnReqSubmit").show();
              

                $('#overlay-back').fadeIn(100, function () {
                    $('#popupPenalty').show();
                    GetDC();
                   
                });
            });
           
    
         //On Changing the DC Cab assosiated to that DC populated in dropdown of DC
    $("#ddlDcName").change(function () {
        GetAllCabListByDC();
            });
    $("#btnReqSubmit").click(function (e) {

        e.preventDefault();


        //$("#form1").validationEngine();
        var valid = $("#frmImposePenalty").validationEngine('validate');
        if (valid) {
            e.preventDefault();
            ImposePenalty();
                   }
    });
     });
       

        function hideValidation() {
            $('#txtEmpanelDate').validationEngine('hide');
        }
        function ClearImposePenalty() {
            $("#txtPenaltyAmount").val("");
            $("#txtPenaltyRemarks").val("");
            $("#ddlDcName").val("");
            $("#ddlCabNumber").val("");
           
        }


        //impose penality to a cab
     function ImposePenalty() {
         //alert("call impose penalty");
         ClearImposePenalty();
         var objPenaltyDetails = new PenaltyDetails();
         objPenaltyDetails.PenaltyAmount = $("#txtPenaltyAmount").val();
         objPenaltyDetails.PenaltyRemarks = $("#txtPenaltyRemarks").val();
         objPenaltyDetails.DCID = $('#ddlDcName').val();
         objPenaltyDetails.CabID = $('#ddlCabNumber>option:selected').val();         

         $.ajax({
             type: "Post",
             url: "PenaltyFine.aspx/PenaltyOnCab",
             data: "{'PenaltyImpose':" + JSON.stringify(objPenaltyDetails) + "}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: function (result) {
                 var Output = result.d;
                 if (Output != null && Output == true) {
                     $('#popupPenalty').hide();
                     $('#overlay-back').fadeOut(100);
                     $("#errMsg").text("Fine/Penalty Successfully Imposed")
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

        //get DC list
     function GetDC() {

         $.ajax({
             type: "POST",
             url: "PenaltyFine.aspx/GetAllDC",
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

        //Get All cabs for selected DC
     function GetAllCabListByDC() {
         var DCID = $('#ddlDcName').val();
         
         $.ajax({
             type: "POST",
             url: "PenaltyFine.aspx/GetAllCabListByDC",
             data: "{'DCID':'" + DCID + "'}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: function (result) {
                 var Output = result.d;
                 if (Output != null) {
                     $('#ddlCabNumber').children().remove();
                     $('#ddlCabNumber').append($("<option>").val(0).text('–Select–'));
                     $.each(Output, function (index, value) {
                         $('#ddlCabNumber').append($("<option></option>").val(value.CabID).html(value.CabNumberFull));
                     });
                 }
             },
             error: function (er) {
                 alert(er);
             }
         });
     }
         </script>
    <%-- <script>
         $(function () {
             $("#accordion").accordion({
                 collapsible: true
             });
         });
  </script>--%>
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
        .auto-style5 {
              font-size: large;
          }
 .width20
         {
             width:20px;
         }

          </style>


</asp:Content>
   
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
  <h3 tabindex="0" class="ui-accordion-header ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons" id="ui-id-1" role="tab" aria-expanded="true" aria-selected="true" aria-controls="ui-id-2">Penalty/Fine</h3>
   
    <div id="accordion">
  <h3>Actions></h3>
  <div>
          <table>
          <tr>
              <td> <a href="#" id="aImposeFine">Impose Fine</a></td>
              <td class="width20"></td>
              <td> <a href="#" id="aImposedCabs">View ImposedFine Cabs</a></td>
              <td class="width20"></td>
              
          </tr>
      </table>
  </div>
      

        <p tabindex="0" class="ui-accordion-header ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons" role="tab" aria-expanded="true" aria-selected="true" aria-controls="ui-id-2">&nbsp;</p>
    </div>
     <br />
    <br />

    <table width="100%" class="cell-border paddingtop15" id="tblFineImposed" cellspacing="0">
        <thead>
            <tr class="tablerow">
                <th>Cab Number</th>
                <th>Penalty Discription</th>
                <th>Penalty Amount</th>
                <th>Penalty Date</th>                  
                
            </tr>
        </thead>

    </table>

    <div id="popupPenalty"><img class="close-image" src="../Images/close.png" />
        
         <form id="frmImposePenalty" method="post">
    <fieldset>
        <label>
           <b>Enter Penalty Details:</b>
        </label>
    </fieldset>
    <table style="border:1px solid;" class="sorting" id="tblApplyPenalty">
        <tr>
<td colspan="8"><div style="color:red;font-weight:bold;width:100%;" id="errMsg">&nbsp;</div></td>
        </tr>   

        <tr  style="border:1px solid;">
            <th class="sorting">
                DC Name :
            </th>
             <td style="width:20px;">&nbsp;</td>
            <td><select id="ddlDcName"  style="width:151px;" name="D2">                
                </select> <span class="auto-style5" style= "color:red">*</span></td>

        </tr>
        <tr  style="border:1px solid;">
            <th class="sorting">
               Cab Number:
            </th>
             <td style="width:20px;"></td>
            <td><select id="ddlCabNumber"  style="width:151px;">                
                </select>&nbsp;<span class="auto-style5" style= "color:red">*</span></td>      
        </tr>
           <tr>
           
            <th class="newStyle2">Amount :              
            </th>
             <td style="width:20px;"></td>
            <td> <input id="txtMobile" name="txtAmount" class="validate[required] text-input" type="text" maxlength="10" />&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
        </tr>
         <tr>
           <th class="sorting">  Penalty Discription:             
            </th>
             <td style="width:20px;"></td>
            <td>
                <textarea name="txtAddress" rows="2" id="txtPenaltyDiscription" class="validate[required]" maxlength="50"></textarea><span class="auto-style5" style= "color:red">*</span></td>
            <td>
                &nbsp;</td>              
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
              
            <div id="submit" style="position: relative; z-index: auto; width: 296px; left:200px; top: 50px;">
        <input type="button" id="btnReqSubmit" value="Submit" />
    </div>

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

        });
    </script>   

    </form>
    
</asp:Content>

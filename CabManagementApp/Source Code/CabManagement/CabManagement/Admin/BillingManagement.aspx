<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="BillingManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.BillingManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <!-- DataTables CSS -->
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />
     <link href="../CSS/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.validationEngine-en.js"></script>
    <script src="Scripts/jquery.validationEngine.js"></script>
    <script type="text/javascript">

         
       

        function GetDC() {

            $.ajax({
                type: "POST",
                url: "OnDemandRequest.aspx/GetAllDC",
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
         </script>
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
          .auto-style8 {
            text-align: left;
            width: 149px;
            height: 36px;
        }
        .auto-style9 {
            width: 36px;
            height: 36px;
        }
        .auto-style10 {
            height: 36px;
        }
        .auto-style11 {
            text-align: left;
            width: 149px;
            height: 37px;
        }
        .auto-style12 {
            width: 36px;
            height: 37px;
        }
        .auto-style13 {
            height: 37px;
        }
        .auto-style14 {
            text-align: left;
            width: 149px;
            height: 34px;
        }
        .auto-style15 {
            width: 36px;
            height: 34px;
        }
        .auto-style16 {
            height: 34px;
        }
        .auto-style17 {
            text-align: left;
            width: 149px;
            height: 38px;
        }
        .auto-style18 {
            width: 36px;
            height: 38px;
        }
        .auto-style19 {
            height: 38px;
        }
        .auto-style20 {
            text-align: left;
            width: 149px;
            height: 33px;
        }
        .auto-style21 {
            width: 36px;
            height: 33px;
        }
        .auto-style22 {
            height: 33px;
        }
        .auto-style23 {
            text-align: left;
            width: 149px;
            height: 27px;
        }
        .auto-style24 {
            width: 36px;
            height: 27px;
        }
        .auto-style25 {
            height: 27px;
        }
          </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="accordion" > 
  <h3 tabindex="0" class="ui-accordion-header ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons" id="ui-id-1" role="tab" aria-expanded="true" aria-selected="true" aria-controls="ui-id-2">Penalty/Fine<table style="border:1px solid;" class="sorting">
        <tr>
<td colspan="4"><div style="color:red;font-weight:bold;width:100%;" id="errMsg">&nbsp;</div></td>
        </tr>   

        <tr  style="border:1px solid;">
            <th class="auto-style8">
                DC Name :
            </th>
             <td class="auto-style9"></td>
            <td class="auto-style10"><select id="ddlDcName"  style="width:151px;" name="D3">                
                </select> <span class="auto-style5" style= "color:red">*</span></td>

        </tr>

         <tr  style="border:1px solid;">
            <th class="auto-style11">
                Vendore Name :
            </th>
             <td class="auto-style12"></td>
            <td class="auto-style13"><select id="ddlVendoreName"  style="width:151px;" name="D2">                
                </select> <span class="auto-style5" style= "color:red">*</span></td>

        </tr>

         <tr  style="border:1px solid;">
            <th class="auto-style14">
              Month :
            </th>
             <td class="auto-style15"></td>
            <td class="auto-style16"> 

                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>

            </td>


        <tr  style="border:1px solid;">
            <th class="auto-style17">
               Cab Number:
            </th>
             <td class="auto-style18"></td>
            <td class="auto-style19"><select id="ddlCabNumber"  style="width:151px;" name="D4">                
                </select>&nbsp;<span class="auto-style5" style= "color:red">*</span></td>      
        </tr>
           <tr>
           
            <th class="auto-style20">Total Trips :              
            </th>
             <td class="auto-style21"></td>
            <td class="auto-style22"> <input id="txtTrips" name="txtTrips1" class="validate[required] text-input" type="text" maxlength="10" size="20" />&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
        </tr>
         <tr>
           <th class="auto-style8">  Amount Per Trip :             
            </th>
             <td class="auto-style9"></td>
            <td class="auto-style10">
                <input id="txtAmount" name="txtTrips" class="validate[required] text-input" type="text" maxlength="10" />&nbsp;<span class="auto-style5" style= "color:red">*</span></td>
             
                <td class="auto-style10">
                </td>              
        </tr>
         
         <tr>
            <th class="auto-style23">  Total  Amount&nbsp;&nbsp; :             
            </th>
             <td class="auto-style24"> </td>
            <td class="auto-style25">
                <asp:Label ID="lblAmount" runat="server" Text="Label"></asp:Label>
             </td>
            <td class="auto-style25"></td>
        </tr>

         <tr>
            <th class="auto-style23">  Status&nbsp;&nbsp; :             
            </th>
             <td class="auto-style24"> </td>
            <td class="auto-style25">
                <asp:Label ID="lblStatus" runat="server" Text="Label"></asp:Label>
             </td>
            <td class="auto-style25"></td>
        </tr>

         <tr>
           <td colspan="4">               
               <asp:Label ID="lblErrorMsg" runat="server" Text="Field Marked * Are Mandatory" ForeColor="#FF3300"></asp:Label>
            </td>
        </tr>
    </table>
        </h3>
    </div>

    <div id="submit" style="position: relative; z-index: auto; width: 296px; left:208px; top: 28px;">
        <input type="button" id="btnReqSubmit" value="Submit" />
    </div>





</asp:Content>

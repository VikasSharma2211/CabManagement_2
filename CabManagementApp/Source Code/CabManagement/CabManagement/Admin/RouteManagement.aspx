<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RouteManagement.aspx.cs" Inherits="Infosys.CabManagement.UI.Admin.RouteManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr><td>Employee ID</td><td><asp:TextBox ID="txtEmployeeID" runat="server"></asp:TextBox></td>
            <td>Route</td><td><asp:DropDownList ID="ddlRoute" runat="server"></asp:DropDownList></td>
        </tr>

         <tr><td>Employee Name</td><td><asp:TextBox ID="txtEmployeeName" runat="server"></asp:TextBox></td>
            <td>Shift</td><td><asp:DropDownList ID="ddlShift" runat="server"></asp:DropDownList></td>
        </tr>

         <tr><td>Address</td><td><asp:TextBox ID="txtAddress" runat="server"></asp:TextBox></td>
            <td>Cab</td><td><asp:DropDownList ID="ddlCab" runat="server"></asp:DropDownList></td>
        </tr>

         <tr><td><asp:Button ID="btnSave" runat="server" Text="Save" /></td>
            <td><asp:Button ID="btnCancel" runat="server" Text="Cancel" /></td>
        </tr>
    </table>
</asp:Content>

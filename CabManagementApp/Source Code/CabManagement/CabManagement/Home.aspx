<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Infosys.CabManagement.UI.Home.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
       .txtdiv {

           position: absolute;
    top: 50%;
    left: 40%;
    margin-top: -50px;
    margin-left: -50px;
    width: 400px;
    height: 400px;
-moz-border-radius: 15px;
border-radius: 15px;

} 
       .maindiv
       {
           height:auto;

       }
        P { text-align: center ;
            font-family:Verdana;
            font-size:medium;
               
        }
H2 { text-align: center }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div >
        <div class=" txtdiv">
         <p>  Welcome In Cab Management System</p>
        </div>

    </div>


</asp:Content>

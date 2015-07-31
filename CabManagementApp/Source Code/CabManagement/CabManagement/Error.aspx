<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Infosys.CabManagement.UI.Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="CSS/demo.css" rel="stylesheet" />
    <link href="CSS/navbar.css" rel="stylesheet" />
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
     <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type = "text/javascript" >
        history.pushState(null, null, 'Error.aspx');
        window.addEventListener('popstate', function (event) {
            history.pushState(null, null, 'Error.aspx');
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   <div class=" txtdiv">
         <p>  UnAuthorized Access..</p>
       <p><a href="Home.aspx">Go to Home</a></p>
        </div>
    </div>
    </form>
</body>
</html>

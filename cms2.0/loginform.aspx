<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginform.aspx.cs" Inherits="cms2._0.loginform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>login form</title>
     <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="login-page">
    <div class="login-card">

        <div class="login-logo">
            <h1>College Management System</h1>
          
        </div>

        <div class="form-group">
            <label>Role</label>
            <asp:DropDownList ID="ddlRole" runat="server">
                <asp:ListItem Text="— Select your role —" Value="" />
                <asp:ListItem Text="Admin"     Value="admin"     />
                <asp:ListItem Text="Professor" Value="professor" />
                <asp:ListItem Text="Student"   Value="student"   />
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>Username</label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username" />
        </div>

        <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password" />
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false" />

        <asp:Button ID="btnLogin" runat="server" Text="log In" CssClass="btn-login"
                    OnClick="btnLogin_Click" />

    </div>
        </div>
    </form>
</body>
</html>

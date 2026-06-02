<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminDesk.aspx.cs" Inherits="cms2._0.adminDesk" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Desk – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
    <div class="header">
        <h1><u>Admin Desk</u></h1>
        <a class="btn-link" href="loginform.aspx" title="logout" onclick="Session.Abandon()">Logout</a>
    </div>

    <div class="id-card">
        <div class="card-header">
            <div class="photo" aria-hidden="true"></div>
            <div>
                <div class="name">
                    <asp:Literal ID="litName" runat="server" /></div>
                <div class="small">Administrator</div>
            </div>
        </div>
        <div class="card-body">
            <div class="meta">Personal Information</div>
            <ul>
                <li><strong>ID:</strong>      <asp:Literal ID="litId"      runat="server" /></li>
                <li><strong>Email:</strong>   <asp:Literal ID="litEmail"   runat="server" /></li>
                <li><strong>Phone:</strong>   <asp:Literal ID="litPhone"   runat="server" /></li>
                <li><strong>Address:</strong> <asp:Literal ID="litAddress" runat="server" /></li>
            </ul>
        </div>
    </div>

    <div class="admin-actions" style="margin-top:18px;">
        <a class="btn-link" href="manageStudent.aspx">Manage Students</a>
        <a class="btn-link" href="manageprofessor.aspx">Manage Professors</a>
    </div>
</form>
</body>
</html>

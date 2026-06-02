<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="professordesk.aspx.cs" Inherits="cms2._0.professordesk" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Professor Desk – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
    <div class="header">
        <h1>Professor Desk</h1>
        <a class="btn-link" href="loginform.aspx">Logout</a>
    </div>

    <h2>Personal Details</h2>
    <div class="id-card">
        <div class="card-header">
            <div class="photo" aria-hidden="true"></div>
            <div>
                <div class="name"><asp:Literal ID="litName" runat="server" /></div>
                <div class="small">Professor</div>
            </div>
        </div>
        <div class="card-body">
            <div class="meta">ID card — personal information (read-only)</div>
            <ul>
                <li><strong>ID:</strong>         <asp:Literal ID="litId"      runat="server" /></li>
                <li><strong>Email:</strong>      <asp:Literal ID="litEmail"   runat="server" /></li>
                <li><strong>Phone:</strong>      <asp:Literal ID="litPhone"   runat="server" /></li>
                <li><strong>Department:</strong> <asp:Literal ID="litDept"    runat="server" /></li>
                <li><strong>Address:</strong>    <asp:Literal ID="litAddress" runat="server" /></li>
            </ul>
        </div>
    </div>

    <div class="admin-actions" style="margin-top:18px;">
        <a class="btn-link" href="managemarks.aspx">Manage Marks</a>
        <a class="btn-link" href="manageAttendance.aspx">Manage Attendance</a>
        <a class="btn-link" href="managehomework.aspx">Manage Homework</a>
        <a class="btn-link" href="managedoubt.aspx">Manage Doubts</a>
    </div>
</form>
</body>
</html>

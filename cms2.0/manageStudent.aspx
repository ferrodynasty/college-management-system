<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageStudent.aspx.cs" Inherits="cms2._0.manageStudent" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Students – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
<div class="container">
    <div class="header">
        <div>
            <h2 style="margin:0">Manage Students</h2>
            <div class="count">Total: <asp:Literal ID="litCount" runat="server" Text="0" /></div>
        </div>
        <div>
            <a class="back-link" href="adminDesk.aspx" style="margin-right:10px;">&#8592; Back</a>
            <asp:Button ID="btnToggle" runat="server" CssClass="btn" Text="+ Add Student"
                OnClick="btnToggle_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:Panel ID="pnlAdd" runat="server" CssClass="form-panel" Visible="false" style="margin-bottom:16px;">
        <h4 style="margin:0 0 8px">Add Student</h4>
        <label>Student ID</label>
        <asp:TextBox ID="txtId"    runat="server" placeholder="e.g. S2402" /><br />
        <label style="margin-top:8px;">Full Name</label>
        <asp:TextBox ID="txtName"  runat="server" placeholder="Full name" /><br />
        <label style="margin-top:8px;">Username</label>
        <asp:TextBox ID="txtUser"  runat="server" placeholder="Login username" /><br />
        <label style="margin-top:8px;">Password</label>
        <asp:TextBox ID="txtPass"  runat="server" TextMode="Password" placeholder="Password" /><br />
        <label style="margin-top:8px;">Email</label>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="email@domain.com" /><br />
        <label style="margin-top:8px;">Phone</label>
        <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone number" /><br />
        <label style="margin-top:8px;">Class</label>
        <asp:TextBox ID="txtClass" runat="server" placeholder="e.g. CS 101" /><br />
        <div style="margin-top:10px;">
            <asp:Button ID="btnAdd"    runat="server" CssClass="btn" Text="Add" OnClick="btnAdd_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel"
                OnClick="btnCancel_Click" CausesValidation="false" style="margin-left:8px;" />
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false" Style="font-size:14px;margin-top:8px;display:block;" />
    </asp:Panel>

    <div id="grid" class="card-grid">
        <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
            <ItemTemplate>
                <div class="mini-card">
                    <div class="name"><%# Eval("student_id") %> — <%# Eval("full_name") %></div>
                    <div class="meta"><%# Eval("class") %> &bull; <%# Eval("email") %></div>
                    <asp:LinkButton CommandName="Delete" CommandArgument='<%# Eval("student_id") %>'
                        runat="server" style="font-size:12px;color:#c0392b;margin-top:6px;display:inline-block;"
                        OnClientClick="return confirm('Delete this student?');">Delete</asp:LinkButton>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
</form>
</body>
</html>

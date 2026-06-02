<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="managehomework.aspx.cs" Inherits="cms2._0.managehomework" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Homework – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">
    <a class="back-link" href="professordesk.aspx">&#8592; Back</a>
    <h1>Homework Assignments</h1>

    <!-- Add new -->
    <div class="card">
        <div class="section-title">Post New Assignment</div>
        <div class="form-row">
            <div class="form-group" style="flex:1;">
                <label>Title</label>
                <asp:TextBox ID="txtTitle" runat="server" placeholder="Assignment title" style="width:100%" />
            </div>
            <div class="form-group">
                <label>Class</label>
                <asp:TextBox ID="txtClass" runat="server" placeholder="e.g. CS 101" />
            </div>
            <div class="form-group">
                <label>Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" placeholder="e.g. Mathematics" />
            </div>
            <div class="form-group">
                <label>Due Date</label>
                <asp:TextBox ID="txtDue" runat="server" TextMode="Date" />
            </div>
        </div>
        <div class="form-group" style="margin-top:10px;">
            <label>Description</label>
            <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="3"
                placeholder="Assignment instructions…" style="width:100%;padding:8px;border:1px solid #ccc;border-radius:6px;" />
        </div>
        <div style="margin-top:12px;">
            <asp:Button ID="btnPost" runat="server" Text="Post Assignment" CssClass="btn-save" OnClick="btnPost_Click" />
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false" Style="margin-top:8px;font-size:14px;display:block;" />
    </div>

    <!-- List -->
    <div class="section-title" style="margin-bottom:12px;">Posted Assignments</div>
    <asp:Repeater ID="rptHW" runat="server" OnItemCommand="rptHW_ItemCommand">
        <ItemTemplate>
            <div class="tile" style="width:auto;margin-bottom:14px;">
                <h3><%# Eval("title") %></h3>
                <div class="meta">Due: <%# ((DateTime)Eval("due_date")).ToString("dd MMM yyyy") %> &bull; <%# Eval("class") %> &bull; <%# Eval("subject") %></div>
                <p><%# Eval("description") %></p>
                <div class="actions">
                    <asp:LinkButton CommandName="Delete" CommandArgument='<%# Eval("hw_id") %>'
                        runat="server" CssClass="btn secondary"
                        OnClientClick="return confirm('Delete this assignment?');">Delete</asp:LinkButton>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Label ID="lblEmpty" runat="server" Visible="false"
        Text="No assignments posted yet." Style="color:#aaa;font-size:14px;" />
</div>
</form>
</body>
</html>

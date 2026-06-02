<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homework.aspx.cs" Inherits="cms2._0.homework" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Homework – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
    <div class="page-container">
        <a class="back-link" href="studentDesk.aspx">&#8592; Back</a>
        <h1>Assignments</h1>

        <asp:Repeater ID="rptHW" runat="server">
            <ItemTemplate>
                <div class="assignment-card">
                    <h3><%# Eval("title") %></h3>
                    <div class="meta">
                        Due: <%# ((DateTime)Eval("due_date")).ToString("dd MMM yyyy") %>
                        &bull; Class: <%# Eval("class") %>
                        &bull; Subject: <%# Eval("subject") %>
                    </div>
                    <p><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Label ID="lblEmpty" runat="server" Visible="false"
            Text="No assignments posted yet." Style="color:#aaa;font-size:14px;" />

        <!-- Doubt / question chat for student -->
        <div class="chat-wrap" style="margin-top:24px;">
            <div class="chat-header">
                <div class="row">
                    <div class="placeholder-photo" aria-hidden="true"></div>
                    <div>
                        <div class="title">Ask a Doubt</div>
                        <div class="subtitle">Submit questions about any assignment</div>
                    </div>
                </div>
            </div>
            <div id="chatBody" class="chat-body" role="log" aria-live="polite">
                <div class="msg agent">
                    <div class="bubble">Welcome! Use the form below to ask a question about any assignment.</div>
                </div>
            </div>
            <div class="chat-footer">
                <div class="chat-input">
                    <asp:TextBox ID="txtDoubtSubject" runat="server" placeholder="Subject (e.g. Mathematics)" Width="200px" />
                    <asp:TextBox ID="txtDoubtQuestion" runat="server" TextMode="MultiLine" Rows="2"
                        placeholder="Type your question here…" Width="400px" />
                </div>
                <asp:Button ID="btnAskDoubt" runat="server" Text="Submit" CssClass="btn-send"
                    OnClick="btnAskDoubt_Click" />
            </div>
            <asp:Label ID="lblDoubtMsg" runat="server" Visible="false"
                Style="color:green;padding:8px 16px;font-size:14px;display:block;" />
        </div>
    </div>
</form>
</body>
</html>

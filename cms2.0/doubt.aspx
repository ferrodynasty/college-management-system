<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="doubt.aspx.cs" Inherits="cms2._0.doubt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Doubts – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
    <style>
        .doubt-card{background:#fff;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,.07);padding:18px 22px;margin-bottom:16px}
        .doubt-card .q{font-weight:600;color:#2b5797;margin-bottom:6px}
        .doubt-card .meta{font-size:13px;color:#777;margin-bottom:8px}
        .doubt-card .ans{background:#e6f9ee;border-left:3px solid #1a7a3c;padding:10px 14px;border-radius:6px;color:#1a3a2a;font-size:14px}
        .pending{color:#a07000;font-weight:600}
        .answered{color:#1a7a3c;font-weight:600}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">
    <a class="back-link" href="studentDesk.aspx">&#8592; Back</a>
    <h1>My Doubts</h1>

    <!-- Submit new doubt -->
    <div class="card" style="margin-bottom:24px;">
        <div class="section-title">Ask a New Doubt</div>
        <div class="form-row">
            <div class="form-group">
                <label>Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" placeholder="e.g. Mathematics" />
            </div>
            <div class="form-group" style="flex:1;">
                <label>Question</label>
                <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Rows="2"
                    placeholder="Type your question…" style="width:100%" />
            </div>
            <div class="form-group">
                <label>&nbsp;</label>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-save"
                    OnClick="btnSubmit_Click" />
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false" Style="margin-top:8px;display:block;font-size:14px;" />
    </div>

    <!-- List of doubts -->
    <div class="section-title">My Questions</div>
    <asp:Repeater ID="rptDoubts" runat="server">
        <ItemTemplate>
            <div class="doubt-card">
                <div class="q"><%# Eval("subject") %> – <%# Eval("question") %></div>
                <div class="meta">
                    Asked: <%# ((DateTime)Eval("asked_on")).ToString("dd MMM yyyy") %>
                    &nbsp;|&nbsp;
                    Status: <span class='<%# Eval("status").ToString() == "Answered" ? "answered" : "pending" %>'><%# Eval("status") %></span>
                </div>
                <%# Eval("status").ToString() == "Answered"
                    ? $"<div class='ans'><strong>Answer:</strong> {Eval("answer")}</div>"
                    : "" %>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Label ID="lblEmpty" runat="server" Visible="false"
        Text="No doubts submitted yet." Style="color:#aaa;font-size:14px;" />
</div>
</form>
</body>
</html>

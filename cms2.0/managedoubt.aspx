<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="managedoubt.aspx.cs" Inherits="cms2._0.managedoubt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Doubts – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
    <style>
        .doubt-card{background:#fff;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,.07);padding:18px 22px;margin-bottom:16px}
        .doubt-card .q{font-weight:600;color:#2b5797;margin-bottom:6px}
        .doubt-card .meta{font-size:13px;color:#777;margin-bottom:8px}
        .pending{color:#a07000;font-weight:600}.answered{color:#1a7a3c;font-weight:600}
        .ans-row{display:flex;gap:8px;margin-top:10px;}
        .ans-row textarea{flex:1;padding:8px;border:1px solid #ccc;border-radius:6px;font-size:14px;}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">
    <a class="back-link" href="professordesk.aspx">&#8592; Back</a>
    <h1>Student Doubts</h1>

    <asp:Repeater ID="rptDoubts" runat="server" OnItemCommand="rptDoubts_ItemCommand">
        <ItemTemplate>
            <div class="doubt-card">
                <div class="q"><%# Eval("subject") %> – <%# Eval("question") %></div>
                <div class="meta">
                    Student: <strong><%# Eval("full_name") %></strong> (<%# Eval("student_id") %>)
                    &nbsp;|&nbsp; Asked: <%# ((DateTime)Eval("asked_on")).ToString("dd MMM yyyy") %>
                    &nbsp;|&nbsp; <span class='<%# Eval("status").ToString()=="Answered"?"answered":"pending" %>'><%# Eval("status") %></span>
                </div>
                <%# Eval("status").ToString()=="Answered"
                    ? $"<div style='background:#e6f9ee;border-left:3px solid #1a7a3c;padding:10px 14px;border-radius:6px;font-size:14px;'><strong>Your answer:</strong> {Eval("answer")}</div>"
                    : "" %>

                <%# Eval("status").ToString()!="Answered" ? "<div class='ans-row'>" : "" %>
                <%# Eval("status").ToString()!="Answered"
                    ? $"<textarea name='ans_{Eval("doubt_id")}' placeholder='Type your answer…'></textarea>" : "" %>
                <%# Eval("status").ToString()!="Answered" ? "" : "" %>
                <asp:LinkButton Visible='<%# Eval("status").ToString()!="Answered" %>'
                    CommandName="Answer" CommandArgument='<%# Eval("doubt_id") %>'
                    runat="server" CssClass="btn-save" style="white-space:nowrap;">Answer</asp:LinkButton>
                <%# Eval("status").ToString()!="Answered" ? "</div>" : "" %>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Label ID="lblEmpty" runat="server" Visible="false"
        Text="No doubts submitted by students yet." Style="color:#aaa;font-size:14px;" />
    <asp:Label ID="lblMsg" runat="server" Visible="false" Style="font-size:14px;margin-top:8px;display:block;" />
</div>
</form>
</body>
</html>

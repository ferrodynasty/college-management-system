<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="marks.aspx.cs" Inherits="cms2._0.marks" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Marks – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
    <style>
        .badge{display:inline-block;padding:3px 10px;border-radius:12px;font-size:12px;font-weight:600}
        .b-hi{background:#e6f9ee;color:#1a7a3c}.b-mid{background:#fff8e0;color:#a07000}.b-low{background:#ffeaea;color:#c0392b}
        .marks-table{width:100%;border-collapse:collapse}
        .marks-table th{background:#eef2ff;color:#2b5797;font-weight:600;padding:10px 14px;text-align:left;border-bottom:2px solid #c8d3f5}
        .marks-table td{padding:10px 14px;border-bottom:1px solid #eee;font-size:14px}
        .marks-table tr:hover td{background:#f7f9ff}
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="page-wrap">
        <a class="back-link" href="studentDesk.aspx">&#8592; Back</a>
        <h1>My Marks</h1>

        <!-- Summary -->
        <div class="summary-row">
            <div class="summary-box">
                <div class="num"><asp:Literal ID="litTotal" runat="server" Text="0" /></div>
                <div class="lbl">Subjects</div>
            </div>
            <div class="summary-box sbox-present">
                <div class="num"><asp:Literal ID="litAvg" runat="server" Text="0" /></div>
                <div class="lbl">Average %</div>
            </div>
            <div class="summary-box sbox-pct">
                <div class="num"><asp:Literal ID="litHighest" runat="server" Text="0" /></div>
                <div class="lbl">Highest</div>
            </div>
        </div>

        <div class="card">
            <div class="section-title">Score Sheet</div>
            <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="false"
                CssClass="marks-table" GridLines="None">
                <Columns>
                    <asp:BoundField  DataField="subject" HeaderText="Subject" />
                    <asp:BoundField  DataField="marks"   HeaderText="Marks"   />
                    <asp:TemplateField HeaderText="Grade">
                        <ItemTemplate>
                            <%# GradeBadge(Eval("marks")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <p style="color:#aaa;padding:12px;">No marks recorded yet.</p>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</form>
</body>
</html>

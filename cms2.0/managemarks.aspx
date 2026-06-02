<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="managemarks.aspx.cs" Inherits="cms2._0.managemarks" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Marks – CMS 2.0</title>
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
    <a class="back-link" href="professordesk.aspx">&#8592; Back</a>
    <h1>Marks</h1>

    <div class="tabs">
        <asp:Button ID="btnTabEnter" runat="server" CssClass="tab-btn active" Text="Enter Marks"
            OnClick="btnTabEnter_Click" CausesValidation="false" />
        <asp:Button ID="btnTabView"  runat="server" CssClass="tab-btn" Text="View All Marks"
            OnClick="btnTabView_Click" CausesValidation="false" />
    </div>

    <!-- ENTER MARKS PANEL -->
    <asp:Panel ID="pnlEnter" runat="server">
        <div class="card">
            <div class="section-title">Add / Update Marks</div>
            <div class="form-row">
                <div class="form-group">
                    <label>Student ID</label>
                    <asp:TextBox ID="txtSid"   runat="server" placeholder="e.g. S2401" />
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <asp:TextBox ID="txtSub"   runat="server" placeholder="e.g. Mathematics" />
                </div>
                <div class="form-group">
                    <label>Marks (0–100)</label>
                    <asp:TextBox ID="txtMarks" runat="server" placeholder="85" style="width:100px;" />
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" />
                </div>
            </div>
            <asp:Label ID="lblMsg" runat="server" Visible="false" Style="margin-top:10px;font-size:14px;display:block;" />
        </div>
    </asp:Panel>

    <!-- VIEW MARKS PANEL -->
    <asp:Panel ID="pnlView" runat="server" Visible="false">
        <div class="card">
            <div class="section-title">All Marks</div>
            <asp:GridView ID="gvMarks" runat="server" AutoGenerateColumns="false"
                CssClass="marks-table" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="student_id" HeaderText="Student ID" />
                    <asp:BoundField DataField="full_name"  HeaderText="Name" />
                    <asp:BoundField DataField="subject"    HeaderText="Subject" />
                    <asp:BoundField DataField="marks"      HeaderText="Marks" />
                    <asp:TemplateField HeaderText="Grade">
                        <ItemTemplate>
                            <%# GradeBadge(Eval("marks")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate><p style="color:#aaa;padding:12px;">No marks recorded yet.</p></EmptyDataTemplate>
            </asp:GridView>
        </div>
    </asp:Panel>
</div>
</form>
</body>
</html>

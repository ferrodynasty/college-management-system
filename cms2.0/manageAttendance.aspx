<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageAttendance.aspx.cs" Inherits="cms2._0.manageAttendance" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">
    <a class="back-link" href="professordesk.aspx">&#8592; Back</a>
    <h1>Attendance</h1>

    <div class="tabs">
        <asp:Button ID="btnTabMark" runat="server" CssClass="tab-btn active" Text="Mark Attendance"
            OnClick="btnTabMark_Click" CausesValidation="false" />
        <asp:Button ID="btnTabView" runat="server" CssClass="tab-btn" Text="View Attendance"
            OnClick="btnTabView_Click" CausesValidation="false" />
    </div>

    <!-- MARK ATTENDANCE -->
    <asp:Panel ID="pnlMark" runat="server">
        <div class="card">
            <div class="section-title">Mark Attendance</div>
            <div class="form-row">
                <div class="form-group">
                    <label>Student ID</label>
                    <asp:TextBox ID="txtSid"    runat="server" placeholder="e.g. S2401" />
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <asp:TextBox ID="txtSub"    runat="server" placeholder="e.g. Mathematics" />
                </div>
                <div class="form-group">
                    <label>Date</label>
                    <asp:TextBox ID="txtDate"   runat="server" TextMode="Date" />
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Text="Present" Value="Present" />
                        <asp:ListItem Text="Absent"  Value="Absent" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>&nbsp;</label>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" />
                </div>
            </div>
            <asp:Label ID="lblMsg" runat="server" Visible="false" Style="margin-top:10px;font-size:14px;display:block;" />
        </div>
    </asp:Panel>

    <!-- VIEW ATTENDANCE -->
    <asp:Panel ID="pnlView" runat="server" Visible="false">
        <div class="summary-row">
            <div class="summary-box">
                <div class="num"><asp:Literal ID="litTotal"   runat="server" Text="0" /></div>
                <div class="lbl">Total</div>
            </div>
            <div class="summary-box sbox-present">
                <div class="num"><asp:Literal ID="litPresent" runat="server" Text="0" /></div>
                <div class="lbl">Present</div>
            </div>
            <div class="summary-box sbox-absent">
                <div class="num"><asp:Literal ID="litAbsent"  runat="server" Text="0" /></div>
                <div class="lbl">Absent</div>
            </div>
        </div>
        <div class="card">
            <div class="section-title">All Attendance Records</div>
            <asp:GridView ID="gvAtt" runat="server" AutoGenerateColumns="false"
                CssClass="att-table" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="student_id" HeaderText="Student ID" />
                    <asp:BoundField DataField="full_name"  HeaderText="Name" />
                    <asp:BoundField DataField="subject"    HeaderText="Subject" />
                    <asp:BoundField DataField="att_date"   HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("status").ToString()=="Present"?"present":"absent" %>'>
                                <%# Eval("status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate><p style="color:#aaa;padding:12px;">No records yet.</p></EmptyDataTemplate>
            </asp:GridView>
        </div>
    </asp:Panel>
</div>
</form>
</body>
</html>

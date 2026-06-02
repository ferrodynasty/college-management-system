<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="attendance.aspx.cs" Inherits="cms2._0.attendance" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Attendance – CMS 2.0</title>
    <link rel="stylesheet" href="styleSheet.css" />
</head>
<body>
<form id="form1" runat="server">
    <div class="page-wrap">
        <a class="back-link" href="studentDesk.aspx">&#8592; Back</a>
        <h1>My Attendance</h1>

        <div class="summary-row">
            <div class="summary-box">
                <div class="num"><asp:Literal ID="litTotal"   runat="server" Text="0" /></div>
                <div class="lbl">Total Classes</div>
            </div>
            <div class="summary-box sbox-present">
                <div class="num"><asp:Literal ID="litPresent" runat="server" Text="0" /></div>
                <div class="lbl">Present</div>
            </div>
            <div class="summary-box sbox-absent">
                <div class="num"><asp:Literal ID="litAbsent"  runat="server" Text="0" /></div>
                <div class="lbl">Absent</div>
            </div>
            <div class="summary-box sbox-pct">
                <div class="num"><asp:Literal ID="litPct"     runat="server" Text="0%" /></div>
                <div class="lbl">Attendance %</div>
            </div>
        </div>

        <div class="card">
            <div class="section-title">Attendance Record</div>
            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="false"
                CssClass="att-table" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="subject"  HeaderText="Subject" />
                    <asp:BoundField DataField="att_date" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Eval("status").ToString() == "Present" ? "present" : "absent" %>'>
                                <%# Eval("status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <p style="color:#aaa;padding:12px;">No attendance records found.</p>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</form>
</body>
</html>


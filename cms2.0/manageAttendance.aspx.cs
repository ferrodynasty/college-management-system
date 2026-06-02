using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class manageAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "professor")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack)
                txtDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
        }

        protected void btnTabMark_Click(object sender, EventArgs e)
        {
            pnlMark.Visible = true; pnlView.Visible = false;
            btnTabMark.CssClass = "tab-btn active"; btnTabView.CssClass = "tab-btn";
        }

        protected void btnTabView_Click(object sender, EventArgs e)
        {
            pnlMark.Visible = false; pnlView.Visible = true;
            btnTabMark.CssClass = "tab-btn"; btnTabView.CssClass = "tab-btn active";
            LoadAllAttendance();
        }

        private void LoadAllAttendance()
        {
            string sql = @"SELECT a.att_id, a.student_id, s.full_name, a.subject, a.att_date, a.status
                           FROM attendance a JOIN student s ON s.student_id = a.student_id
                           ORDER BY a.att_date DESC";
            DataTable dt = DbHelper.Query(sql);
            gvAtt.DataSource = dt;
            gvAtt.DataBind();

            int total = dt.Rows.Count, present = 0;
            foreach (DataRow r in dt.Rows)
                if (r["status"].ToString() == "Present") present++;
            litTotal.Text = total.ToString();
            litPresent.Text = present.ToString();
            litAbsent.Text = (total - present).ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string sid = txtSid.Text.Trim();
            string sub = txtSub.Text.Trim();
            string dateTxt = txtDate.Text.Trim();
            string status = ddlStatus.SelectedValue;

            if (string.IsNullOrEmpty(sid) || string.IsNullOrEmpty(sub) || string.IsNullOrEmpty(dateTxt))
            {
                Show("Please fill all fields.", false); return;
            }
            if (!DateTime.TryParse(dateTxt, out DateTime date))
            {
                Show("Invalid date.", false); return;
            }

            object exists = DbHelper.Scalar("SELECT COUNT(*) FROM student WHERE student_id=:id", DbHelper.P("id", sid));
            if (Convert.ToInt32(exists) == 0) { Show("Student ID not found.", false); return; }

            // Prevent duplicates: update if same student/subject/date already recorded
            object cnt = DbHelper.Scalar(
                "SELECT COUNT(*) FROM attendance WHERE student_id=:sid AND subject=:sub AND att_date=:dt",
                DbHelper.P("sid", sid), DbHelper.P("sub", sub), DbHelper.P("dt", date));

            if (Convert.ToInt32(cnt) > 0)
            {
                DbHelper.Execute(
                    "UPDATE attendance SET status=:st WHERE student_id=:sid AND subject=:sub AND att_date=:dt",
                    DbHelper.P("st", status), DbHelper.P("sid", sid), DbHelper.P("sub", sub), DbHelper.P("dt", date));
                Show($"Attendance updated for {sid}.", true);
            }
            else
            {
                DbHelper.Execute(
                    "INSERT INTO attendance (student_id,subject,att_date,status) VALUES (:sid,:sub,:dt,:st)",
                    DbHelper.P("sid", sid), DbHelper.P("sub", sub), DbHelper.P("dt", date), DbHelper.P("st", status));
                Show($"Attendance marked for {sid} on {date:dd MMM yyyy}.", true);
            }

            txtSid.Text = ""; txtSub.Text = "";
        }

        private void Show(string msg, bool ok)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = ok ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }
}

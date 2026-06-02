using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class managemarks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "professor")
            { Response.Redirect("loginform.aspx"); return; }
        }

        protected void btnTabEnter_Click(object sender, EventArgs e)
        {
            pnlEnter.Visible = true;
            pnlView.Visible = false;
            btnTabEnter.CssClass = "tab-btn active";
            btnTabView.CssClass = "tab-btn";
        }

        protected void btnTabView_Click(object sender, EventArgs e)
        {
            pnlEnter.Visible = false;
            pnlView.Visible = true;
            btnTabEnter.CssClass = "tab-btn";
            btnTabView.CssClass = "tab-btn active";
            LoadAllMarks();
        }

        private void LoadAllMarks()
        {
            string sql = @"SELECT m.mark_id, m.student_id, s.full_name, m.subject, ROUND(m.marks,2) AS marks
                           FROM marks m JOIN student s ON s.student_id = m.student_id
                           ORDER BY m.student_id, m.subject";
            DataTable dt = DbHelper.Query(sql);
            gvMarks.DataSource = dt;
            gvMarks.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string sid = txtSid.Text.Trim();
            string subject = txtSub.Text.Trim();
            string marksRaw = txtMarks.Text.Trim();

            if (string.IsNullOrEmpty(sid) || string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(marksRaw))
            {
                Show("Please fill all fields.", false); return;
            }
            if (!double.TryParse(marksRaw, out double m) || m < 0 || m > 100)
            {
                Show("Marks must be a number between 0 and 100.", false); return;
            }

            // Check student exists
            object exists = DbHelper.Scalar("SELECT COUNT(*) FROM student WHERE student_id = :id", DbHelper.P("id", sid));
            if (Convert.ToInt32(exists) == 0) { Show("Student ID not found.", false); return; }

            // Upsert: update if exists, else insert
            object cnt = DbHelper.Scalar(
                "SELECT COUNT(*) FROM marks WHERE student_id=:sid AND subject=:sub",
                DbHelper.P("sid", sid), DbHelper.P("sub", subject));

            if (Convert.ToInt32(cnt) > 0)
            {
                DbHelper.Execute(
                    "UPDATE marks SET marks=:m WHERE student_id=:sid AND subject=:sub",
                    DbHelper.P("m", m), DbHelper.P("sid", sid), DbHelper.P("sub", subject));
                Show($"Marks updated for {sid} – {subject}.", true);
            }
            else
            {
                DbHelper.Execute(
                    "INSERT INTO marks (student_id,subject,marks) VALUES (:sid,:sub,:m)",
                    DbHelper.P("sid", sid), DbHelper.P("sub", subject), DbHelper.P("m", m));
                Show($"Marks saved for {sid} – {subject}.", true);
            }

            txtSid.Text = "";
            txtSub.Text = "";
            txtMarks.Text = "";
        }

        private void Show(string msg, bool ok)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = ok ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }

        protected string GradeBadge(object marksObj)
        {
            double m = Convert.ToDouble(marksObj);
            string label, css;
            if (m >= 90) { label = "A+"; css = "b-hi"; }
            else if (m >= 80) { label = "A"; css = "b-hi"; }
            else if (m >= 70) { label = "B"; css = "b-mid"; }
            else if (m >= 60) { label = "C"; css = "b-mid"; }
            else if (m >= 50) { label = "D"; css = "b-mid"; }
            else { label = "F"; css = "b-low"; }
            return $"<span class=\"badge {css}\">{label}</span>";
        }
    }
}

using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class homework : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "student")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadHomework();
        }

        private void LoadHomework()
        {
            // Show assignments whose class matches the student's class
            string studentId = Session["UserId"].ToString();
            string sql = @"SELECT h.hw_id, h.title, h.class, h.subject, h.due_date, h.description
                           FROM homework h
                           JOIN student s ON s.class = h.class
                           WHERE s.student_id = :id
                           ORDER BY h.due_date";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", studentId));
            if (dt.Rows.Count == 0) { lblEmpty.Visible = true; return; }
            rptHW.DataSource = dt;
            rptHW.DataBind();
        }

        protected void btnAskDoubt_Click(object sender, EventArgs e)
        {
            string subject = txtDoubtSubject.Text.Trim();
            string question = txtDoubtQuestion.Text.Trim();
            string sid = Session["UserId"].ToString();

            if (string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(question))
            {
                lblDoubtMsg.Text = "Please enter both subject and question.";
                lblDoubtMsg.ForeColor = System.Drawing.Color.Red;
                lblDoubtMsg.Visible = true;
                return;
            }

            string sql = @"INSERT INTO doubt (student_id, subject, question, asked_on, status)
                           VALUES (:sid, :sub, :q, SYSDATE, 'Pending')";
            DbHelper.Execute(sql,
                DbHelper.P("sid", sid),
                DbHelper.P("sub", subject),
                DbHelper.P("q", question));

            txtDoubtSubject.Text = "";
            txtDoubtQuestion.Text = "";
            lblDoubtMsg.Text = "Your doubt has been submitted. The professor will answer it soon.";
            lblDoubtMsg.ForeColor = System.Drawing.Color.Green;
            lblDoubtMsg.Visible = true;
        }
    }
}

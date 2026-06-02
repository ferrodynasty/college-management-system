using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class doubt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "student")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadDoubts();
        }

        private void LoadDoubts()
        {
            string sql = @"SELECT doubt_id, subject, question, answer, asked_on, status
                           FROM doubt WHERE student_id = :id ORDER BY asked_on DESC";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", Session["UserId"].ToString()));
            if (dt.Rows.Count == 0) { lblEmpty.Visible = true; return; }
            rptDoubts.DataSource = dt;
            rptDoubts.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string subject = txtSubject.Text.Trim();
            string question = txtQuestion.Text.Trim();
            string sid = Session["UserId"].ToString();

            if (string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(question))
            {
                lblMsg.Text = "Please fill in subject and question.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Visible = true;
                return;
            }

            string sql = @"INSERT INTO doubt (student_id, subject, question, asked_on, status)
                           VALUES (:sid, :sub, :q, SYSDATE, 'Pending')";
            DbHelper.Execute(sql, DbHelper.P("sid", sid), DbHelper.P("sub", subject), DbHelper.P("q", question));

            txtSubject.Text = "";
            txtQuestion.Text = "";
            lblMsg.Text = "Doubt submitted successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Visible = true;
            LoadDoubts();
        }
    }
}

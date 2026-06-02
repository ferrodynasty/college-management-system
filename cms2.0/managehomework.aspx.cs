using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cms2._0
{
    public partial class managehomework : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "professor")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadHomework();
        }

        private void LoadHomework()
        {
            string sql = @"SELECT hw_id, title, class, subject, due_date, description
                           FROM homework WHERE prof_id = :pid ORDER BY due_date";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("pid", Session["UserId"].ToString()));
            lblEmpty.Visible = dt.Rows.Count == 0;
            rptHW.DataSource = dt;
            rptHW.DataBind();
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string cls = txtClass.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string dueTxt = txtDue.Text.Trim();
            string desc = txtDesc.Text.Trim();

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(cls) ||
                string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(dueTxt))
            { Show("Please fill all required fields.", false); return; }

            if (!DateTime.TryParse(dueTxt, out DateTime due))
            { Show("Invalid due date.", false); return; }

            string sql = @"INSERT INTO homework (prof_id,title,class,subject,due_date,description)
                           VALUES (:pid,:t,:c,:s,:d,:desc)";
            DbHelper.Execute(sql,
                DbHelper.P("pid", Session["UserId"].ToString()),
                DbHelper.P("t", title),
                DbHelper.P("c", cls),
                DbHelper.P("s", subject),
                DbHelper.P("d", due),
                DbHelper.P("desc", desc));

            txtTitle.Text = ""; txtClass.Text = ""; txtSubject.Text = "";
            txtDue.Text = ""; txtDesc.Text = "";
            Show("Assignment posted successfully!", true);
            LoadHomework();
        }

        protected void rptHW_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                DbHelper.Execute("DELETE FROM homework WHERE hw_id=:id",
                    DbHelper.P("id", Convert.ToInt32(e.CommandArgument)));
                Show("Assignment deleted.", true);
                LoadHomework();
            }
        }

        private void Show(string msg, bool ok)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = ok ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }
}

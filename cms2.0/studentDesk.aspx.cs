using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class studentDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "student")
            { Response.Redirect("loginform.aspx"); return; }

            LoadProfile(Session["UserId"].ToString());
        }

        private void LoadProfile(string studentId)
        {
            string sql = @"SELECT student_id, full_name, email, phone, address, class
                           FROM student WHERE student_id = :id";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", studentId));
            if (dt.Rows.Count == 0) return;
            DataRow r = dt.Rows[0];
            litId.Text = r["student_id"].ToString();
            litName.Text = r["full_name"].ToString();
            litEmail.Text = r["email"].ToString();
            litPhone.Text = r["phone"].ToString();
            litClass.Text = r["class"].ToString();
            litAddress.Text = r["address"].ToString();
        }
    }
}

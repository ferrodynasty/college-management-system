using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class professordesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "professor")
            { Response.Redirect("loginform.aspx"); return; }

            LoadProfile(Session["UserId"].ToString());
        }

        private void LoadProfile(string profId)
        {
            string sql = @"SELECT prof_id, full_name, email, phone, address, dept
                           FROM professor WHERE prof_id = :id";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", profId));
            if (dt.Rows.Count == 0) return;
            DataRow r = dt.Rows[0];
            litId.Text = r["prof_id"].ToString();
            litName.Text = r["full_name"].ToString();
            litEmail.Text = r["email"].ToString();
            litPhone.Text = r["phone"].ToString();
            litDept.Text = r["dept"].ToString();
            litAddress.Text = r["address"].ToString();
        }
    }
}

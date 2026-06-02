using System;
using System.Data;
using System.Web;
using System.Web.UI;

namespace cms2._0
{
    public partial class adminDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Auth guard
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "admin")
            {
                Response.Redirect("loginform.aspx");
                return;
            }

            string adminId = Session["UserId"].ToString();
            LoadAdminProfile(adminId);
        }

        private void LoadAdminProfile(string adminId)
        {
            string sql = @"SELECT a.admin_id, a.full_name, a.email, a.phone, a.address
                           FROM admin a WHERE a.admin_id = :id";
            try
            {
                DataTable dt = DbHelper.Query(sql, DbHelper.P("id", adminId));
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    litId.Text = r["admin_id"].ToString();
                    litName.Text = r["full_name"].ToString();
                    litEmail.Text = r["email"].ToString();
                    litPhone.Text = r["phone"].ToString();
                    litAddress.Text = r["address"].ToString();
                }
            }
            catch (Exception ex)
            {
                // Simple error display — improve in production
                litName.Text = "Error: " + ex.Message;
            }
        }
    }
}

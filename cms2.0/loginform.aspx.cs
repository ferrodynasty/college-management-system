using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace cms2._0
{
    public partial class loginform : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = ddlRole.SelectedValue.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(role) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("Please fill in all fields.");
                return;
            }

            try
            {
                string sql = @"SELECT user_id, role FROM cms_users
                               WHERE username = :uname AND password = :pwd AND role = :role";

                DataTable dt = DbHelper.Query(sql,
                    DbHelper.P("uname", username),
                    DbHelper.P("pwd", password),
                    DbHelper.P("role", role));

                if (dt.Rows.Count == 0)
                {
                    ShowError("Invalid credentials. Please try again.");
                    return;
                }

                string userId = dt.Rows[0]["user_id"].ToString();
                string userRole = dt.Rows[0]["role"].ToString();

                // Store in session
                Session["UserId"] = userId;
                Session["Role"] = userRole;
                Session["Username"] = username;

                switch (userRole)
                {
                    case "admin": Response.Redirect("adminDesk.aspx"); break;
                    case "professor": Response.Redirect("professordesk.aspx"); break;
                    case "student": Response.Redirect("studentDesk.aspx"); break;
                    default: ShowError("Unknown role."); break;
                }
            }
            catch (Exception ex)
            {
                ShowError("Database error: " + ex.Message);
            }
        }

        private void ShowError(string msg)
        {
            lblError.Text = msg;
            lblError.Visible = true;
        }
    }
}

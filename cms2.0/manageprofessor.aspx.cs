using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cms2._0
{
    public partial class manageprofessor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "admin")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadProfessors();
        }

        private void LoadProfessors()
        {
            DataTable dt = DbHelper.Query(
                "SELECT prof_id, full_name, email, phone, dept FROM professor ORDER BY prof_id");
            litCount.Text = dt.Rows.Count.ToString();
            rptProfs.DataSource = dt;
            rptProfs.DataBind();
        }

        protected void btnToggle_Click(object sender, EventArgs e) =>
            pnlAdd.Visible = !pnlAdd.Visible;

        protected void btnCancel_Click(object sender, EventArgs e) =>
            pnlAdd.Visible = false;

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string id = txtId.Text.Trim();
            string name = txtName.Text.Trim();
            string user = txtUser.Text.Trim();
            string pass = txtPass.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string dept = txtDept.Text.Trim();

            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(name) ||
                string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            { Show("ID, Name, Username and Password are required.", false); return; }

            try
            {
                DbHelper.Execute(
                    "INSERT INTO cms_users (user_id,username,password,role) VALUES (:id,:u,:p,'professor')",
                    DbHelper.P("id", id), DbHelper.P("u", user), DbHelper.P("p", pass));

                DbHelper.Execute(
                    "INSERT INTO professor (prof_id,full_name,email,phone,address,dept) VALUES (:id,:n,:e,:ph,:ad,:d)",
                    DbHelper.P("id", id), DbHelper.P("n", name), DbHelper.P("e", email),
                    DbHelper.P("ph", phone), DbHelper.P("ad", ""), DbHelper.P("d", dept));

                pnlAdd.Visible = false;
                ClearForm();
                Show("Professor added.", true);
                LoadProfessors();
            }
            catch (Exception ex)
            {
                Show("Error: " + ex.Message, false);
            }
        }

        protected void rptProfs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string pid = e.CommandArgument.ToString();
                DbHelper.Execute("DELETE FROM homework  WHERE prof_id=:id", DbHelper.P("id", pid));
                DbHelper.Execute("DELETE FROM professor WHERE prof_id=:id", DbHelper.P("id", pid));
                DbHelper.Execute("DELETE FROM cms_users WHERE user_id=:id", DbHelper.P("id", pid));
                Show("Professor deleted.", true);
                LoadProfessors();
            }
        }

        private void ClearForm() =>
            txtId.Text = txtName.Text = txtUser.Text = txtPass.Text =
            txtEmail.Text = txtPhone.Text = txtDept.Text = "";

        private void Show(string msg, bool ok)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = ok ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }
}

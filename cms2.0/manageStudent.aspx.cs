using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cms2._0
{
    public partial class manageStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "admin")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadStudents();
        }

        private void LoadStudents()
        {
            DataTable dt = DbHelper.Query(
                "SELECT student_id, full_name, email, phone, class FROM student ORDER BY student_id");
            litCount.Text = dt.Rows.Count.ToString();
            rptStudents.DataSource = dt;
            rptStudents.DataBind();
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
            string cls = txtClass.Text.Trim();

            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(name) ||
                string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            { Show("ID, Name, Username, and Password are required.", false); return; }

            try
            {
                // Insert into cms_users first
                DbHelper.Execute(
                    "INSERT INTO cms_users (user_id,username,password,role) VALUES (:id,:u,:p,'student')",
                    DbHelper.P("id", id), DbHelper.P("u", user), DbHelper.P("p", pass));

                // Then insert into student
                DbHelper.Execute(
                    "INSERT INTO student (student_id,full_name,email,phone,address,class) VALUES (:id,:n,:e,:ph,:ad,:c)",
                    DbHelper.P("id", id), DbHelper.P("n", name), DbHelper.P("e", email),
                    DbHelper.P("ph", phone), DbHelper.P("ad", ""), DbHelper.P("c", cls));

                ClearForm();
                pnlAdd.Visible = false;
                Show("Student added successfully.", true);
                LoadStudents();
            }
            catch (Exception ex)
            {
                Show("Error: " + ex.Message, false);
            }
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string sid = e.CommandArgument.ToString();
                // Delete child records first to respect FK constraints
                DbHelper.Execute("DELETE FROM doubt      WHERE student_id=:id", DbHelper.P("id", sid));
                DbHelper.Execute("DELETE FROM attendance WHERE student_id=:id", DbHelper.P("id", sid));
                DbHelper.Execute("DELETE FROM marks      WHERE student_id=:id", DbHelper.P("id", sid));
                DbHelper.Execute("DELETE FROM student    WHERE student_id=:id", DbHelper.P("id", sid));
                DbHelper.Execute("DELETE FROM cms_users  WHERE user_id=:id", DbHelper.P("id", sid));
                Show("Student deleted.", true);
                LoadStudents();
            }
        }

        private void ClearForm()
        {
            txtId.Text = txtName.Text = txtUser.Text = txtPass.Text = "";
            txtEmail.Text = txtPhone.Text = txtClass.Text = "";
        }

        private void Show(string msg, bool ok)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = ok ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }
}

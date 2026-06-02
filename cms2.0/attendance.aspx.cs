using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "student")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadAttendance(Session["UserId"].ToString());
        }

        private void LoadAttendance(string studentId)
        {
            string sql = @"SELECT subject, att_date, status
                           FROM attendance WHERE student_id = :id
                           ORDER BY att_date DESC";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", studentId));

            gvAttendance.DataSource = dt;
            gvAttendance.DataBind();

            int total = dt.Rows.Count, present = 0;
            foreach (DataRow r in dt.Rows)
                if (r["status"].ToString() == "Present") present++;
            int absent = total - present;
            int pct = total > 0 ? (int)Math.Round((double)present / total * 100) : 0;

            litTotal.Text = total.ToString();
            litPresent.Text = present.ToString();
            litAbsent.Text = absent.ToString();
            litPct.Text = pct + "%";
        }
    }
}

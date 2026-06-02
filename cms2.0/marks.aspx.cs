using System;
using System.Data;
using System.Web.UI;

namespace cms2._0
{
    public partial class marks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "student")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadMarks(Session["UserId"].ToString());
        }

        private void LoadMarks(string studentId)
        {
            string sql = @"SELECT subject, ROUND(marks,2) AS marks
                           FROM marks WHERE student_id = :id ORDER BY subject";
            DataTable dt = DbHelper.Query(sql, DbHelper.P("id", studentId));

            gvMarks.DataSource = dt;
            gvMarks.DataBind();

            if (dt.Rows.Count > 0)
            {
                double sum = 0, max = 0;
                foreach (DataRow r in dt.Rows)
                {
                    double m = Convert.ToDouble(r["marks"]);
                    sum += m;
                    if (m > max) max = m;
                }
                litTotal.Text = dt.Rows.Count.ToString();
                litAvg.Text = Math.Round(sum / dt.Rows.Count, 1).ToString();
                litHighest.Text = max.ToString();
            }
        }

        // Called from ASPX template column
        protected string GradeBadge(object marksObj)
        {
            double m = Convert.ToDouble(marksObj);
            string label, css;
            if (m >= 90) { label = "A+"; css = "b-hi"; }
            else if (m >= 80) { label = "A"; css = "b-hi"; }
            else if (m >= 70) { label = "B"; css = "b-mid"; }
            else if (m >= 60) { label = "C"; css = "b-mid"; }
            else if (m >= 50) { label = "D"; css = "b-mid"; }
            else { label = "F"; css = "b-low"; }
            return $"<span class=\"badge {css}\">{label}</span>";
        }
    }
}

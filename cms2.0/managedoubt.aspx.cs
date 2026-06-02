using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cms2._0
{
    public partial class managedoubt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["Role"]?.ToString() != "professor")
            { Response.Redirect("loginform.aspx"); return; }

            if (!IsPostBack) LoadDoubts();
        }

        private void LoadDoubts()
        {
            string sql = @"SELECT d.doubt_id, d.student_id, s.full_name,
                                  d.subject, d.question, d.answer, d.asked_on, d.status
                           FROM doubt d JOIN student s ON s.student_id = d.student_id
                           ORDER BY CASE d.status WHEN 'Pending' THEN 0 ELSE 1 END, d.asked_on DESC";
            DataTable dt = DbHelper.Query(sql);
            lblEmpty.Visible = dt.Rows.Count == 0;
            rptDoubts.DataSource = dt;
            rptDoubts.DataBind();
        }

        protected void rptDoubts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Answer")
            {
                int doubtId = Convert.ToInt32(e.CommandArgument);
                // Retrieve the answer textarea by name (plain HTML rendered in repeater)
                string answer = Request.Form["ans_" + doubtId]?.Trim();

                if (string.IsNullOrEmpty(answer))
                {
                    lblMsg.Text = "Please type an answer before submitting.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Visible = true;
                    LoadDoubts();
                    return;
                }

                DbHelper.Execute(
                    @"UPDATE doubt SET answer=:ans, answered_on=SYSDATE, status='Answered'
                      WHERE doubt_id=:id",
                    DbHelper.P("ans", answer),
                    DbHelper.P("id", doubtId));

                lblMsg.Text = "Answer submitted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Visible = true;
                LoadDoubts();
            }
        }
    }
}

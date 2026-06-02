using System;
using System.Data;
using System.Configuration;
using Oracle.ManagedDataAccess.Client;

namespace cms2._0
{
    /// <summary>
    /// Central helper for Oracle XE access.
    /// Connection string is read from Web.config → connectionStrings["OracleXE"].
    /// </summary>
    public static class DbHelper
    {
        private static string ConnStr =>
            ConfigurationManager.ConnectionStrings["OracleXE"].ConnectionString;

        public static OracleConnection GetConnection()
        {
            var con = new OracleConnection(ConnStr);
            con.Open();
            return con;
        }

        /// <summary>Run a SELECT and return a DataTable.</summary>
        public static DataTable Query(string sql, params OracleParameter[] prms)
        {
            using (var con = GetConnection())
            using (var cmd = new OracleCommand(sql, con))
            {
                foreach (var p in prms) cmd.Parameters.Add(p);
                var da = new OracleDataAdapter(cmd);
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        /// <summary>Run INSERT / UPDATE / DELETE and return rows affected.</summary>
        public static int Execute(string sql, params OracleParameter[] prms)
        {
            using (var con = GetConnection())
            using (var cmd = new OracleCommand(sql, con))
            {
                foreach (var p in prms) cmd.Parameters.Add(p);
                return cmd.ExecuteNonQuery();
            }
        }

        /// <summary>Run a query that returns a single value.</summary>
        public static object Scalar(string sql, params OracleParameter[] prms)
        {
            using (var con = GetConnection())
            using (var cmd = new OracleCommand(sql, con))
            {
                foreach (var p in prms) cmd.Parameters.Add(p);
                return cmd.ExecuteScalar();
            }
        }

        public static OracleParameter P(string name, object value) =>
            new OracleParameter(name, value ?? DBNull.Value);
    }
}

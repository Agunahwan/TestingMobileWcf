using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Library
{
    public class DataAccess
    {
        public string ConnectionString;
        public SqlConnection myConnection;
        private string _errorMessage;

        public string ErrorMessage
        {
            get { return _errorMessage; }
            set { _errorMessage = value; }
        }

        public DataAccess()
        {
            _errorMessage = "";
        }

        private string GetConnectionString(string sConfig)
        {
            return ConfigurationManager.ConnectionStrings[sConfig].ConnectionString;
        }

        public void OpenConnection(string sConfig)
        {
            ConnectionString = GetConnectionString(sConfig);

            myConnection = new SqlConnection(ConnectionString);
            try
            {
                myConnection.Open();
            }
            catch (Exception ex)
            {
                _errorMessage = ex.Message;
            }
        }

        #region Fungsi Select
        //Fungsi untuk eksekusi query select semua kolom
        public SqlDataReader Select(string sConfig, string sNamaTabel, string sWhere = "", string sOrder = "")
        {
            string SQL = "SELECT * FROM " + sNamaTabel;
            if (sWhere != "")
                SQL += " WHERE " + sWhere;
            if (sOrder != "")
                SQL += " ORDER BY " + sOrder;
            return this.GetData(sConfig, SQL);
        }

        //Fungsi untuk eksekusi query select dengan kolom spesifik
        public SqlDataReader Select(string sConfig, string[] sNamaKolom, string sNamaTabel, string sWhere = "", string sOrder = "")
        {
            string SQL = "SELECT ";
            for (int i = 0; i <= sNamaKolom.Length - 1; i++)
            {
                SQL += sNamaKolom[i];
                if (i < sNamaKolom.Length - 1)
                {
                    SQL += ",";
                }
            }
            SQL += " FROM " + sNamaTabel;
            if (sWhere != "")
                SQL += " WHERE " + sWhere;
            if (sOrder != "")
                SQL += " ORDER BY " + sOrder;
            return this.GetData(sConfig, SQL);
        }
        #endregion

        #region Fungsi Insert
        //Fungsi eksekusi query insert
        public bool Insert(string sConfig, string sNamaTabel, string[] isiTabel)
        {
            string SQL = "INSERT INTO " + sNamaTabel + " VALUES(";
            for (int i = 0; i <= isiTabel.Length - 1; i++)
            {
                SQL += "'" + isiTabel[i] + "'";
                if (i < isiTabel.Length - 1)
                {
                    SQL += ",";
                }
            }
            SQL += ")";
            return this.ExecuteCommand(sConfig, SQL);
        }

        public bool Insert(string sConfig, string sNamaTabel, Dictionary<string, string> isiTabel)
        {
            string SQL = "INSERT INTO " + sNamaTabel + " (";
            foreach (KeyValuePair<string, string> dc in isiTabel)
            {
                SQL += dc.Key + ",";
            }
            SQL = SQL.Substring(0, SQL.Length - 1);
            SQL += ") VALUES(";
            foreach (KeyValuePair<string, string> dc in isiTabel)
            {
                SQL += "'" + dc.Value + "',";
            }
            SQL = SQL.Substring(0, SQL.Length - 1);
            SQL += ")";
            return this.ExecuteCommand(sConfig, SQL);
        }
        #endregion

        #region Fungsi Update
        //Fungsi eksekusi query update
        public bool Update(string sConfig, string sNamaTabel, Dictionary<string, string> isiTabel, string sWhere = "")
        {
            string SQL = "UPDATE " + sNamaTabel + " SET ";

            foreach (KeyValuePair<string, string> dc in isiTabel)
            {
                SQL += dc.Key + "='" + dc.Value + "'";
            }
            SQL = SQL.Substring(0, SQL.Length - 1);
            if (sWhere != "")
                SQL += " WHERE " + sWhere;
            return this.ExecuteCommand(sConfig, SQL);
        }
        #endregion

        #region Fungsi Delete
        //Fungsi eksekusi query delete
        public bool Delete(string sConfig, string sNamaTabel, string sWhere = "")
        {
            string SQL = "DELETE FROM " + sNamaTabel;
            if (sWhere != "")
                SQL += " WHERE " + sWhere;
            return this.ExecuteCommand(sConfig, SQL);
        }
        #endregion

        #region Fungsi untuk menjalankan script SQL
        //Fungsi untuk mendapat data
        public SqlDataReader GetData(string sConfig, string sCommand)
        {
            SqlDataReader dr = null;
            SqlCommand cmd = null;

            string CommandText = sCommand;
            try
            {
                this.OpenConnection(sConfig);

                cmd = new SqlCommand(CommandText);
                cmd.Connection = this.myConnection;
                dr = cmd.ExecuteReader();
                return dr;
            }
            catch (SqlException ex)
            {
                _errorMessage = ex.Message;
                return null;
            }
        }

        //Fungsi eksekusi query
        public bool ExecuteCommand(string sConfig, string sCommand)
        {

            SqlCommand cmd = null;

            string CommandText = sCommand;
            try
            {
                this.OpenConnection(sConfig);

                cmd = new SqlCommand(CommandText);
                cmd.Connection = this.myConnection;
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (SqlException ex)
            {
                _errorMessage = ex.Message;
                return false;
            }
        }
        #endregion

        #region Fungsi untuk Eksekusi SP
        public SqlDataReader ExecuteSP(string sConfig, string sSP, params SqlParameter[] parameters)
        {
            SqlDataReader dr = null;
            SqlCommand cmd = null;

            string SPName = sSP;
            try
            {
                this.OpenConnection(sConfig);

                cmd = new SqlCommand(SPName);
                cmd.CommandType = CommandType.StoredProcedure;

                for (int i = 0; i < parameters.Length; i++)
                {
                    cmd.Parameters.Add(parameters[i]);
                }

                cmd.Connection = this.myConnection;
                dr = cmd.ExecuteReader();
                return dr;
            }
            catch (SqlException ex)
            {
                _errorMessage = ex.Message;
                return null;
            }
        }

        public SqlDataReader ExecuteSP(string sConfig, string sSP)
        {
            SqlDataReader dr = null;
            SqlCommand cmd = null;

            string SPName = sSP;
            try
            {
                this.OpenConnection(sConfig);

                cmd = new SqlCommand(SPName);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = this.myConnection;
                dr = cmd.ExecuteReader();
                return dr;
            }
            catch (SqlException ex)
            {
                _errorMessage = ex.Message;
                return null;
            }
        }
        #endregion
    }
}
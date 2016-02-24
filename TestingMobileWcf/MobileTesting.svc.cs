using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Data.Sql;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using Library;

namespace TestingMobileWcf
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "MobileTesting" in code, svc and config file together.
    public class MobileTesting : IMobileTesting
    {
        public string GetLogin(string username, string password)
        {
            DataAccess dataAccess = new DataAccess();
            DataTable dt = new DataTable();
            SqlDataReader dr;
            Json json = new Json();

            dr = dataAccess.ExecuteSP("connData",
                "sp_GetLogin",
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", password));
            dt.Load(dr);
            return json.DataTableToJson(dt);
        }

        public string GetSoal(string id_tipe_soal, string urutan)
        {
            DataAccess dataAccess = new DataAccess();
            SqlDataReader dr;
            DataTable dt = new DataTable();
            Json json = new Json();

            dr = dataAccess.ExecuteSP("connData",
                "sp_GetSoal",
                new SqlParameter("@IdTipeSoal", int.Parse(id_tipe_soal)),
                new SqlParameter("@Urutan", urutan));
            dt.Load(dr);
            return json.DataTableToJson(dt);
        }

        public string GetCountSoal(string id_tipe_soal)
        {
            DataAccess dataAccess = new DataAccess();
            SqlDataReader dr;

            dr = dataAccess.ExecuteSP("connData",
                "sp_GetCountSoal",
                new SqlParameter("@IdTipeSoal", int.Parse(id_tipe_soal)));
            dr.Read();
            return dr.GetInt32(0).ToString();
        }

        public string InsertJawaban(string id_user, string id_soal, string jawaban)
        {
            DataAccess dataAccess = new DataAccess();
            SqlDataReader dr;
            DataTable dt = new DataTable();
            Json json = new Json();

            dr = dataAccess.ExecuteSP("connData",
                "sp_InsertJawaban",
                new SqlParameter("@IdUser", int.Parse(id_user)),
                new SqlParameter("@IdSoal", int.Parse(id_soal)),
                new SqlParameter("@Jawaban", jawaban));
            dt.Load(dr);
            return json.DataTableToJson(dt);
        }

        public string UpdateNilai(string id_user)
        {
            DataAccess dataAccess = new DataAccess();
            SqlDataReader dr;

            dr = dataAccess.ExecuteSP("connData",
                "sp_UpdateNilai",
                new SqlParameter("@IdUser", int.Parse(id_user)));
            dr.Read();
            return dr.GetInt32(0).ToString();
        }

        public string GetNilai(string id_user)
        {
            DataAccess dataAccess = new DataAccess();
            SqlDataReader dr;
            DataTable dt = new DataTable();
            Json json = new Json();

            dr = dataAccess.ExecuteSP("connData",
                "sp_GetNilai",
                new SqlParameter("@IdUser", int.Parse(id_user)));
            dt.Load(dr);
            return json.DataTableToJson(dt);
        }
    }
}

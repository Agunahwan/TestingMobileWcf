using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;
using System.Data.SqlClient;
using System.Data;

namespace TestingMobileWcf
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IMobileTesting" in both code and config file together.
    [ServiceContract]
    public interface IMobileTesting
    {
        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "get_login/{username}/{password}")]
        string GetLogin(string username, string password);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "get_count_soal/{id_tipe_soal}")]
        string GetCountSoal(string id_tipe_soal);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "get_soal/{id_tipe_soal}/{urutan}")]
        string GetSoal(string id_tipe_soal, string urutan);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "insert_jawaban/{id_user}/{id_soal}/{jawaban}")]
        string InsertJawaban(string id_user, string id_soal, string jawaban);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "update_nilai/{id_user}")]
        string UpdateNilai(string id_user);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "get_nilai/{id_user}")]
        string GetNilai(string id_user);
    }
}

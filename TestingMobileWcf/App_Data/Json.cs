using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for Json
/// </summary>
public class Json
{
    public Json()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string DataTableToJson(DataTable dataTable)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in dataTable.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in dataTable.Columns)
            {
                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }

        return jsSerializer.Serialize(parentRow);
    }
}
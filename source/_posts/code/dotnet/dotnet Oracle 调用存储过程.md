---
title: dotnet Oracle 调用存储过程
updated: 2023-05-05 06:34:50Z
created: 2023-05-05 06:34:02Z
---

# Type1. 使用 ``OracleConnection`` 调用

```
      public void test(string connectStr)
      { 
            using (OracleConnection connection = new OracleConnection(connectStr))
            {
                connection.Open();
                OracleCommand sqlCmd = new OracleCommand("GETSEQUENCE", connection);

                OracleParameter[] parameters = new OracleParameter[2];
                parameters[0] = new OracleParameter(":SEQ_NAME", OracleDbType.Varchar2) { Value = "SEQ", Direction = System.Data.ParameterDirection.Input };
                parameters[1] = new OracleParameter(":SEQ_VALUE", OracleDbType.Int32) { Direction = System.Data.ParameterDirection.Output };
                sqlCmd.Parameters.AddRange(parameters);
                sqlCmd.CommandType = CommandType.StoredProcedure;//设置 使用存储过程
                sqlCmd.ExecuteNonQuery();
                int obj = Convert.ToInt32(parameters[1].Value.ToString());
                connection.Close();

                System.Console.WriteLine(obj);
            }
        }
```

# Type2. 使用EF
```
public int test(string connectStr)
{

    var ParaSeqName = new OracleParameter("SEQ_NAME", OracleDbType.Varchar2, SeqName, ParameterDirection.Input);
    var ParaSeqValue = new OracleParameter("SEQ_VALUE", OracleDbType.Int32, ParameterDirection.Output);
    var strSQL = "BEGIN GETSEQUENCE(:SEQ_NAME,:SEQ_VALUE); END;";
    var result = base.DbContext.Database.ExecuteSqlCommand(strSQL, ParaSeqName, ParaSeqValue);
    if (result != -1)
    {
        _logger.LogError($"End; Orcacle error code:{result}");
        return 0;
    }
           
    OracleDecimal ret = (OracleDecimal)ParaSeqValue.Value;

    Int32 orderNo = ret.IsNull ? 0 : ret.ToInt32();
    return orderNo;
}
```
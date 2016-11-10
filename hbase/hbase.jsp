<%-- 
    Document   : hbase
    Created on : 2016/3/15, 上午 09:26:26
    Author     : webserver
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <h1>HBASE CONTROLL</h1>
       <a href="http://mengze.ddnsking.com:60010">看所有table </a><br/>
         新增表格<br/>
        <form action="action/createTable.jsp">
            表格名稱：<input type="text" name="TableName" value="" /><br/>
            家族：<input type="text" name="familys" value="" /><br/>
            家族可多个,要以半形逗號隔開
            <br/>
            <input type="submit" value="新增" />
            <input type="reset" value="重設" />
        </form>
         <hr/>
         刪除表格<br/>
         <form action="action/deleteTable.jsp">
            要刪除的表格名稱<input type="text" name="TableName" value="" /><br/>
           <input type="submit" value="刪除" />
            <input type="reset" value="重設" />
         </form>
            <hr/>
         新增資料<br/>
         <form action="action/addData.jsp">
             表格名稱：<input type="text" name="TableName" value="" /><br/>
             RowKey:<input type="text" name="rowKey" value="" /><br/>
             家族：<input type="text" name="family" value="" /><br/>
             限定子：<input type="text" name="qualifier" value="" /><br/>
             值：<input type="text" name="value" value="" /><br/>
             <input type="submit" value="新增" />
            <input type="reset" value="重設" />
         </form>
            <hr/>
         刪除資料<br/>
         <form action="action/delRecord.jsp">
             表格名稱：<input type="text" name="TableName" value="" /><br/>
             RowKey:<input type="text" name="rowKey" value="" /><br/>
             <input type="submit" value="刪除" />
            <input type="reset" value="重設" />
         </form>
   <hr/>
         取得資料<br/>
         <form action="action/getonerecord.jsp">
             表格名稱：<input type="text" name="TableName" value="" /><br/>
             RowKey:<input type="text" name="rowKey" value="" /><br/>
             <input type="submit" value="取得" />
            <input type="reset" value="重設" />
         </form>
            <hr/>
         取得所有資料<br/>
         <form action="action/getAllRecord.jsp">
             表格名稱：<input type="text" name="TableName" value="" /><br/>
             <input type="submit" value="取得" />
            <input type="reset" value="重設" />
         </form>
    </body>
</html>

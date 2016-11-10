<%-- 
    Document   : delRecord
    Created on : 2016/3/8, 上午 01:07:41
    Author     : webserver
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>delRecord</title>
    </head>
    <body>
         <%
	
        String tablename = request.getParameter("TableName");
        String  rowKey = request.getParameter("rowKey");
        hbase.controll ctrlhb = new hbase.controll();
        ctrlhb.setTableName(tablename);
	out.println("Delete success");
        ctrlhb.setRowkey(rowKey);
        
        ctrlhb.delRecord();
        
        %>
        
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

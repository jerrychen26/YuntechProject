<%-- 
    Document   : addRecord
    Created on : 2016/3/8, 上午 12:52:38
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
      <%
        String tablename = request.getParameter("TableName");
        String  familys = request.getParameter("family");
        String  rowKey = request.getParameter("rowKey");
        String  qualifier = request.getParameter("qualifier");
        String  value = request.getParameter("value");
        tablename="scores";
        familys="course";
        rowKey="GG";
        qualifier="math";
        value="20";
        
        hbase.controll ctrlhb = new hbase.controll();
        ctrlhb.setTableName(tablename);
        ctrlhb.setFamily(familys);
        ctrlhb.setQualifier(qualifier );
        ctrlhb.setRowkey(rowKey);
        ctrlhb.setValue(value);
        
        ctrlhb.addRecord();
        
        %>
        
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

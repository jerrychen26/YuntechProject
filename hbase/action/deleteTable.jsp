<%-- 
    Document   : deleteTable
    Created on : 2016/3/8, 上午 12:42:32
    Author     : webserver
--%>

<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.hadoop.hbase.client.HBaseAdmin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
   <%
       
        Configuration conf = null;
        conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "master");
        String tablename = request.getParameter("TableName");
 try {
            HBaseAdmin admin = new HBaseAdmin(conf);
            admin.disableTable(tablename);
            admin.deleteTable(tablename);
            out.println("Success<br/>");
            out.println("delete table " + tablename + " ok.");
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        %>
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

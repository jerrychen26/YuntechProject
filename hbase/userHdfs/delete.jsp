<%-- 
    Document   : delete
    Created on : 2016/3/22, 下午 12:53:03
    Author     : webserver
--%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page import="org.apache.hadoop.fs.FileStatus"%>
<%@page import="org.apache.hadoop.fs.FileSystem"%>
<%@page import="org.apache.hadoop.fs.Path"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
        String  filename = request.getParameter("filename");
        Configuration conf = new Configuration();  
        conf.set("fs.default.name", "hdfs://master:9000");  
        FileSystem fs = FileSystem.get(conf);  
        Path path = new Path("hdfs://master:9000/user/"+filename);  
        fs.delete(path);  
        fs.close();  
        out.println("刪除成功");
       
       %>
       <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

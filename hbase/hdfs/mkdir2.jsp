<%-- 
    Document   : mkdir2
    Created on : 2016/6/3, 下午 03:48:35
    Author     : mengze
--%>

<%@page import="org.apache.hadoop.fs.Path"%>
<%@page import="org.apache.hadoop.fs.FileSystem"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String dirname=request.getParameter("dirname");
             Configuration conf = new Configuration();
            conf.set("fs.default.name", "hdfs://master:9000");
            FileSystem fs = FileSystem.get(conf);  
            Path path = new Path("hdfs://master:9000/user/"+dirname);  
            fs.create(path);  
            fs.close();  
            out.println("創立成功");
        
        
        %>
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

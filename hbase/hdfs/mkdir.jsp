<%-- 
    Document   : mkdir
    Created on : 2016/3/15, 下午 02:51:49
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
           String dirPath = request.getParameter("dirname");
          
           hdfs.MakeDir mk = new hdfs.MakeDir();
           mk.setDirname(dirPath);
           mk.mkdir();
        
        
        %>
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

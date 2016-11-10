<%-- 
    Document   : GetAllChildFile
    Created on : 2016/3/21, 下午 02:02:55
    Author     : webserver
--%>




<%@page import="java.io.OutputStream"%>
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
        String  dirname = request.getParameter("dirname");
        Configuration conf = new Configuration();
        conf.set("fs.default.name", "hdfs://master:9000");
            FileSystem fs = FileSystem.get(conf);  
            Path path = new Path("hdfs://master:9000/"+dirname);  
            FileStatus[] fileStatus = fs.listStatus(path);  
            for(int i=0;i<fileStatus.length;i++){  
              out.println(fileStatus[i].getPath().toString()); 
              out.println("<br/>");   
                }           
        %>
	<hr/>
	請輸入要下載的檔名：
	<form name="file" action="download.jsp">
        <input type="text" name="file" value="" />
        <input type="text" name="dirname" value="<%=dirname%>" />
	<input type="submit" value="送出"  />
        </form>		
    </body>
</html>

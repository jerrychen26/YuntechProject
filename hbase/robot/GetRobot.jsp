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
        <title>Drone Video</title>
    </head>
    <body>
        
        <%
        Configuration conf = new Configuration();
        conf.set("fs.default.name", "hdfs://master:9000");
            FileSystem fs = FileSystem.get(conf);  
            Path path = new Path("hdfs://master:9000/RobotVideo");  
            FileStatus[] fileStatus = fs.listStatus(path);  
            for(int i=0;i<fileStatus.length;i++){  
             String filepath=fileStatus[i].getPath().toString();
             String tname[] = filepath.split("/");
             String filename=tname[4];
             out.println( "<a href=\"javascript:return false\" onclick=\"PlayVideo('"+filename+"')\">"+filename+"</a>"  );
		out.println("<br/>");   
} 
	
        %>

<br/>
<div id="video"></div>
<script language="javascript">
function PlayVideo(filename){
	var path="RobotVideo/"+filename;
	document.getElementById("video").innerHTML="<embed src="+path+" width=500 height=290>";
}
</script>
	
    </body>
</html>

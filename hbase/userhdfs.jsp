<%-- 
    Document   : hdfs
    Created on : 2016/3/15, 上午 09:33:43
    Author     : webserver
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HDFS</title>
    </head>
    <body>
	<form name="upload" enctype="multipart/form-data" method="post" action="userHdfs/upload.jsp">
	<p>上傳檔案： <input type="file" name="file"  /> </p>
	<p> <input type="submit" value="上傳" /> <input type="reset" value="清除" /> </p>
	</form>
       <hr/> 
         刪除資料<br/>
        <form name="mkdir" action="userHdfs/delete.jsp" method="POST">
            檔案名稱：<input type="text" name="filename" value="" />
            <input type="submit" value="送出" />
        </form>
       <hr/>
         FileDownload<br/>
        <form name="mkdir" action="userHdfs/GetAllChildFile.jsp" method="POST">
            <input type="submit" value="送出" />
        </form>

        
        
        
    </body>
</html>

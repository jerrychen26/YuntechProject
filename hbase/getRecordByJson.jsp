<%-- 
    Document   : getRecordByJson
    Created on : 2016/5/28, 下午 08:51:47
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
        <a href="http://mengze.ddns.net:60010">看所有table </a><br/>
        <hr/>
        <h1>獲取JSON資料</h1>
        <form action="getAll">
            TableName:<input type="text" name="TableName" value="" /><br/>
            <input type="submit" value="送出" />
        </form>
    </body>
</html>

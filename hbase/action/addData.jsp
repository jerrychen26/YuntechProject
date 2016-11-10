<%-- 
    Document   : addData
    Created on : 2016/3/24, 上午 09:03:52
    Author     : webserver
--%>

<%@page import="org.apache.hadoop.hbase.client.Put"%>
<%@page import="org.apache.hadoop.hbase.util.Bytes"%>
<%@page import="org.apache.hadoop.hbase.client.HTable"%>
<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
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
        String tablename = request.getParameter("TableName");
        String  familys = request.getParameter("family");
        String  rowKey = request.getParameter("rowKey");
        String  qualifier = request.getParameter("qualifier");
        String  value = request.getParameter("value");

        
        Configuration conf = null;
        conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "master");

	        HTable table = new HTable(conf, tablename);
	        byte[] brow = Bytes.toBytes(rowKey);
	        byte[] bfamily = Bytes.toBytes(familys);
	        byte[] bcolumn = Bytes.toBytes(qualifier);
	        byte[] bvalue = Bytes.toBytes(value);
	        Put p = new Put(brow);
	        p.add(bfamily, bcolumn, bvalue);
	        table.put(p);
                          out.println("Success<br/>");
	        out.println("輸入資料："+value+"  至Table："+tablename+"  "+familys+":"+qualifier);
                                
	        table.close();
                        
        %>
       <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

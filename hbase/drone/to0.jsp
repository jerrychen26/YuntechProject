<%-- 
    Document   : to0
    Created on : 2016/6/5, 下午 03:38:41
    Author     : mengze
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.hadoop.hbase.client.Put"%>
<%@page import="org.apache.hadoop.hbase.util.Bytes"%>
<%@page import="org.apache.hadoop.hbase.client.HTable"%>
<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String tablename = "drone";
        String  rowKey = "2016";
        hbase.controll ctrlhb = new hbase.controll();
        ctrlhb.setTableName(tablename);
        ctrlhb.setRowkey(rowKey); 
        ctrlhb.delRecord();
        String  familys = "action";
        String  qualifier = "takeoff";
        String  value = "0";
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
	        table.close();
        %>
<br/><br/><input type="button" onclick="history.back()" value="回到上頁">   
 </body>
</html>

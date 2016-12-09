<%@page import="org.apache.hadoop.hbase.client.ResultScanner"%>
<%@page import="org.apache.hadoop.hbase.client.Scan"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.hadoop.hbase.KeyValue"%>
<%@page import="org.apache.hadoop.hbase.client.Result"%>
<%@page import="org.apache.hadoop.hbase.client.Get"%>
<%@page import="org.apache.hadoop.hbase.client.HTable"%>
<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Map</title>
    </head>
    <body>
	<%
	HashSet date = new HashSet();
	Configuration conf = null;
      	conf = HBaseConfiguration.create();
      	conf.set("hbase.zookeeper.quorum", "master");
        try{   
            HTable table = new HTable(conf, "drone_F2");
            Scan s = new Scan();
            ResultScanner ss = table.getScanner(s);     
            
            for(Result r:ss){
                for(KeyValue kv : r.raw()){
		date.add(new String(kv.getRow())); 
                }
            }
        } catch (IOException e){
              out.println("發生錯誤,有可能是輸入值不對");  
        }
	out.println("Date::"+date);
	%>
	<br/>
	<hr/>
        <form name="MapShow" action="DroneMap/showMap.jsp" >
            Please input the date to watch Map (eg.20161105):
	<br/>
	<input type="text" name="rowKey" value="" />
	<br/>
            <input type="submit" value="Submit" />
        </form>
    </body>
</html>


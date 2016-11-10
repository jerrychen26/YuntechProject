<%-- 
    Document   : getonerecord
    Created on : 2016/3/8, 上午 12:51:39
    Author     : webserver
--%>

<%@page import="java.io.IOException"%>
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
        <title>JSP Page</title>
    </head>
    <body>
               <table frame="border" rules="all">
  
                <%
                   
        out.println("<tr>");
        String tablename = request.getParameter("TableName");
        String  rowKey = request.getParameter("rowKey");
       
     Configuration conf = null;
      conf = HBaseConfiguration.create();
      conf.set("hbase.zookeeper.quorum", "master");
              try {
                  out.println("<tr><td>RowKey</td><td>Family</td> <td>Qualifier</td><td>Value</td> </tr>");
            HTable table = new HTable(conf, tablename);
            Get get = new Get(rowKey.getBytes());
            Result rs = table.get(get);
            
            for(KeyValue kv : rs.raw()){
                out.println("<td>");   out.println(new String(kv.getRow()) );  out.println("</td>");
                out.println("<td>");  out.println(new String(kv.getFamily()) );out.println("</td>");
                out.println("<td>");  out.println(new String(kv.getQualifier()) );out.println("</td>");
                out.println("<td>");  out.println(new String(kv.getValue())); out.println("</td>");
                 out.println("</tr>");
                
            }
        } catch (IOException e) {
            out.println("發生錯誤,有可能是輸入值不對");  
        }
    

        %>
        
         </table>
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

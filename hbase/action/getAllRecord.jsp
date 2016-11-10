
<%@page import="org.apache.hadoop.hbase.client.ResultScanner"%>
<%@page import="org.apache.hadoop.hbase.client.Scan"%>
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
        <title>Data</title>
    </head>
    <body>
        <table frame="border" rules="all">

       <%
           out.println("<tr><td>RowKey</td><td>Family</td> <td>Qualifier</td><td>Value</td> </tr>");
           out.println("<tr>");
        String tablename = request.getParameter("TableName");
        
     Configuration conf = null;
      conf = HBaseConfiguration.create();
      conf.set("hbase.zookeeper.quorum", "master");
        try{
            
            HTable table = new HTable(conf, tablename);
            Scan s = new Scan();
            ResultScanner ss = table.getScanner(s);     
            
            for(Result r:ss){
                for(KeyValue kv : r.raw()){
                  out.println("<td>");  out.println(new String(kv.getRow()) + " ");     out.println("</td>");
                  out.println("<td>"); out.println(new String(kv.getFamily()) );         out.println("</td>");
                  out.println("<td>"); out.println(new String(kv.getQualifier()) );      out.println("</td>");
                   out.println("<td>"); out.println(new String(kv.getValue()));            out.println("</td>");
                    //out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" );
                   //out.println(kv.getTimestamp() );
                   out.println("</tr>");
                   
                   
                }
            }
        } catch (IOException e){
              out.println("發生錯誤,有可能是輸入值不對");  
        }
        %>
       
        
        </table>
         <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

<%-- 
    Document   : createTable
    Created on : 2016/3/7, 下午 06:11:04
    Author     : webserver
--%>

<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.hadoop.hbase.ZooKeeperConnectionException"%>
<%@page import="org.apache.hadoop.hbase.MasterNotRunningException"%>
<%@page import="org.apache.hadoop.hbase.HColumnDescriptor"%>
<%@page import="org.apache.hadoop.hbase.TableName"%>
<%@page import="org.apache.hadoop.hbase.HTableDescriptor"%>
<%@page import="org.apache.hadoop.hbase.client.HBaseAdmin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>create table suceess</title>
    </head>
    <body>
        <%
        String tablename = request.getParameter("TableName");
        String  familys = request.getParameter("familys");
        String cfs[]=familys.split(",");

        
      Configuration conf = null;
      conf = HBaseConfiguration.create();
      conf.set("hbase.zookeeper.quorum", "master");
         try {
            HBaseAdmin admin = new HBaseAdmin(conf);
            if (admin.tableExists(tablename)) {
                out.println("table already exists!");
            } else {
                HTableDescriptor tableDesc = new HTableDescriptor(TableName.valueOf(tablename));
                for (int i = 0; i < cfs.length; i++) {
                    tableDesc.addFamily(new HColumnDescriptor(cfs[i]));
                }
                admin.createTable(tableDesc);
                admin.close();
                out.println("Success<br/>");
                out.println("create table " + tablename + " ok.");
                
            }
        } catch (MasterNotRunningException e) {
            e.printStackTrace();
        } catch (ZooKeeperConnectionException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    
        
        %>
        
        
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

<%-- 
    Document   : getonerecord
    Created on : 2016/3/8, 上午 12:51:39
    Author     : webserver
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.hadoop.hbase.KeyValue"%>
<%@page import="org.apache.hadoop.hbase.client.Result"%>
<%@page import="org.apache.hadoop.hbase.client.Get"%>
<%@page import="org.apache.hadoop.hbase.client.HTable"%>
<%@page import="org.apache.hadoop.hbase.HBaseConfiguration"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
      html, body { height: 100%; margin: 0; padding: 0; }
      #map { height: 90%; }
    </style>
        <title>Map</title>
    </head>
    <body>
    <%               
        String  rowKey = request.getParameter("rowKey");
	//rowKey="20161105";
	HashMap cdt = new HashMap();       
      Configuration conf = null;
      conf = HBaseConfiguration.create();
      conf.set("hbase.zookeeper.quorum", "master");
           try {
            HTable table = new HTable(conf, "drone_F2");
            Get get = new Get(rowKey.getBytes());
            Result rs = table.get(get);
            for(KeyValue kv : rs.raw()){
		cdt.put(new String(kv.getQualifier()),new String(kv.getValue()));
            }
        } catch (IOException e) {
            out.println("發生錯誤,有可能是輸入值不對");  
        }
            for(int i=1;i<=10;i++){
		//out.println(cdt.get("x"+String.valueOf(i)));
		//out.println("<br/>");	
		}
        %>

    <div id="map"></div>
    <script type="text/javascript">
	var map;
	function initMap() {
    var flight =[
    {lat: 23.696079, lng: 120.536804}
  ];
	<%
	for(int i=1;i<=cdt.size()/2;i++){
	if(!cdt.containsKey("x"+String.valueOf(i))) break;
	out.println( "flight.push({lat:"+cdt.get("x"+String.valueOf(i))+",lng:"+cdt.get("y"+String.valueOf(i))+"});" );
	}
	%>
    var drone ={lat: 23.696079, lng: 120.536804 }
    var pir={lat: 23.696006, lng: 120.536071 }
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 23.696006, lng: 120.536071},
    zoom: 19
  });
  var flightPath = new google.maps.Polyline({
    path: flight,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });


  marker = new google.maps.Marker({
    map: map,
    draggable: true,
    animation: google.maps.Animation.DROP,
    icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
    position: drone
  });

  marker2 = new google.maps.Marker({
    map: map,
    draggable: true,
    animation: google.maps.Animation.DROP,
    icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
    position: pir
  });
flightPath.setMap(map);

      }




    </script>
    <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBnT_q7_OIliTuFOqA1HD2ORfu2BJGvVYA&callback=initMap">
    </script>

         
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

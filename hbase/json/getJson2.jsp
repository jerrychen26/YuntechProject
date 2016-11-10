<%-- 
    Document   : getJson
    Created on : 2016/5/26, 下午 07:26:33
    Author     : webserver
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
        <script>
            $(document).ready(function(){
               $("#doAjaxBtn").click(function(){
                   $.ajax({
                        type:"POST",                    
                        url: "http://mengze.ddns.net:8084/hbase/getRecord",                                                  
                        //url: "getRecord",
                        dataType: "jsonp",
                        jsonp:'callback',             
                        success : function(data){
                            //alert("success");
                            alert(callback+data.value);
                        },
                        error:function(xhr, ajaxOptions, thrownError){
                            alert("error:"+xhr.status+"\n"+thrownError);
                        }
                    });
               });
            });  
        </script>
    </head>
    <body>
        <input type="button" id="doAjaxBtn" value="獲取HBASE資料" />     
    </body>
</html>

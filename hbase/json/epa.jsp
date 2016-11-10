

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
                        url: "http://opendata.epa.gov.tw/ws/Data/UV/?$orderby=PublishAgency&$skip=0&$top=1000&format=json",
                        dataType: "jsonp",               
                        success : function(data){
                                  for(var i in data){
                                  var UVI = data[i].UVI;
                                  var SiteName = data[i].SiteName;
                                  var PublishTime=data[i].PublishTime;
                                  //var County=data[i].County;
                                  putHbase(SiteName,UVI,PublishTime);
                                   console.log("success1");
        }
                        },
                        error:function(xhr, ajaxOptions, thrownError){
                            console.log("error1:"+xhr.status+"\n"+thrownError);
                        }
                    });
               });
            });  
            
            function putHbase(site,uvi,time)
            {
                var ur="http://localhost:8084/hbase/action/addData.jsp?TableName=epa&rowKey="+time+"&family=contry&qualifier="+site+"&value="+uvi;
                $.ajax({
                        type:"GET",                                                                    
                        url: ur,
                        dataType: "html",    
                        success : function(data){
                            console.log("success2");
                        },
                        error:function(xhr, ajaxOptions, thrownError){
                            console.log("error2:"+xhr.status+"\n"+thrownError);
                        }
                });
                
                
            }
        </script>
    </head>
    <body>
        <input type="button" id="doAjaxBtn" value="環保署putHBASE" />     
    </body>
</html>

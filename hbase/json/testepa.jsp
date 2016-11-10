

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
        <script>
            $(document).ready(function(){
               $("#doAjaxBtn").click(function(){
                   var time="3";
                   var site="UUU";
                   var uvi="7";
                   var ur="http://localhost:8084/hbase/action/addData.jsp?TableName=epa&rowKey="+time+"&family=contry&qualifier="+site+"&value="+uvi;
                   $.ajax({
                        type:"GET",                    
                        url: ur,                                                  
                        //url: "getRecord",
                        dataType: "html",             
                        success : function(data){
                            console.log(ur);
                            alert("success");
                        },
                        error:function(xhr, ajaxOptions, thrownError){
                            alert("error:"+xhr.status+"\n"+thrownError);
                            console.log(ur);
                        }
                    });
               });
            });  
        </script>
    </head>
    <body>
        <input type="button" id="doAjaxBtn" value="DO" />     
    </body>
</html>


<%-- 
    Document   : upload
    Created on : 2016/3/22, 下午 12:18:07
    Author     : webserver
--%>
<%@page import="hdfs.CopyFromLocalFile"%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page import="org.apache.hadoop.fs.FileStatus"%>
<%@page import="org.apache.hadoop.fs.FileSystem"%>
<%@page import="org.apache.hadoop.fs.Path"%>
<%@page import="java.io.IOException"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.util.Streams"%>
<%@ page import="org.apache.commons.io.FilenameUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>upload</title>
    </head>
    <body>
       <%
	    String saveDirectory = application.getRealPath("/upload");
	    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	    out.println("isMultipart="+isMultipart+"<br>");
	    ServletFileUpload upload = new ServletFileUpload();
	    ProgressListener progressListener = new ProgressListener(){
	       private long megaBytes = -1;
	       public void update(long pBytesRead, long pContentLength, int pItems) {
	           long mBytes = pBytesRead / 1000000;
	           if (megaBytes == mBytes) {
	               return;
	           }
	           megaBytes = mBytes;
	           System.out.println("We are currently reading item " + pItems);
	           if (pContentLength == -1) {
	               System.out.println("So far, " + pBytesRead + " bytes have been read.");
	           } else {
	               System.out.println("So far, " + pBytesRead + " of " + pContentLength
	                                  + " bytes have been read.");
	           }
	       }
	    };
	    upload.setProgressListener(progressListener);
            //這裡接收檔案
	    FileItemIterator iter = upload.getItemIterator(request);
            
	    while (iter.hasNext()) {
	        FileItemStream item = iter.next();
	        String name = item.getFieldName();
	        InputStream stream = item.openStream();
	        if (item.isFormField()) {
	            String value = Streams.asString(stream);
	            out.println(name + "=" + value+"<br>");
	        } else {
	            System.out.println("File field " + name + " with file name "
	                + item.getName() + " detected.");
	            String fieldName = item.getFieldName();
	            String fileName = item.getName();
	            String contentType = item.getContentType();
	            out.println("fieldName="+fieldName+"<br>");
	            out.println("fileName="+fileName+"<br>");
	            out.println("contentType="+contentType+"<br>");
	            if (fileName != null && !"".equals(fileName)) {
	                fileName= FilenameUtils.getName(fileName);
	                out.println("fileName saved="+fileName+"<br>");
	                File uploadedFile = new File(saveDirectory, fileName);
	                FileOutputStream uploadedFileStream =
	                    new FileOutputStream(uploadedFile);
	                Streams.copy(stream, uploadedFileStream, true);
                            String dstp="hdfs://master:9000/user/";
                            Configuration conf = new Configuration();
                            conf.set("fs.default.name", "hdfs://master:9000");
                            FileSystem fs = FileSystem.get(conf);  
                            Path src = new Path("/home/ubuntu/tomcat/webapps/hbase/upload/"+fileName);  
                            Path dst = new Path(dstp);  
                            fs.copyFromLocalFile(src, dst);  
                            fs.close();  
	            }
	        }
	    }

                    
	%>
        <br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

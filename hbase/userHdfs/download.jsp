<%-- 
    Document   : download
    Created on : 2016/3/22, 下午 01:09:07
    Author     : webserver
--%>
<%@page import="org.apache.hadoop.conf.Configuration"%>
<%@page import="org.apache.hadoop.fs.FileStatus"%>
<%@page import="org.apache.hadoop.fs.FileSystem"%>
<%@page import="org.apache.hadoop.fs.Path"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Download</title>
    </head>
    <body>
        <%!
     private static final int BUFSIZE = 2048;

    private void doDownload( HttpServletRequest request, HttpServletResponse response,
                             String filename, String original_filename )
        throws IOException
    {
        File                f        = new File(filename);
        int                 length   = 0;
        ServletOutputStream op       = response.getOutputStream();
        ServletContext      context  = getServletConfig().getServletContext();
        String              mimetype = context.getMimeType( filename );

        response.setContentType( (mimetype != null) ? mimetype : "application/octet-stream" );
        response.setContentLength( (int)f.length() );
        response.setHeader( "Content-Disposition", "attachment; filename=\"" + original_filename + "\"" );

        byte[] bbuf = new byte[BUFSIZE];
        DataInputStream in = new DataInputStream(new FileInputStream(f));

        while ((in != null) && ((length = in.read(bbuf)) != -1))
        {
            op.write(bbuf,0,length);
        }

        in.close();
        op.flush();
        op.close();
    }
%>
<%
	String original_filename = request.getParameter("file");
        String dirname= request.getParameter("dirname");
	String srcp="hdfs://master:9000/"+dirname+"/"+original_filename;
	
	Path dstPath= new Path(srcp);
        Configuration conf = new Configuration();
        conf.set("fs.default.name", "hdfs://master:9000");
	//FileSystem fs = FileSystem.get(conf);
        FileSystem fs = dstPath.getFileSystem(conf);
	
        Path src = new Path(srcp);
        Path dst = new Path("/home/ubuntu/tomcat/webapps/hbase/WEB-INF/export");
	fs.copyToLocalFile(false,src, dst);
        

	fs.close();

    boolean error = false;
    if (original_filename != null && !"".equals(original_filename) && !original_filename.startsWith("../")) {
    	String filename = "/home/ubuntu/tomcat/webapps/hbase/WEB-INF/export/" + original_filename;
    	File file = new File(filename);	
    	if (file.exists()) {
    	    doDownload(request, response, filename, original_filename);
    	    // delete the file after download
    	    boolean deleted = file.delete();
    	    System.out.println("File " + original_filename + " deleted: " + deleted);
    	} else {
    		error = true;
    	}
    } else {
    	error = true;
    }
    if (error) {
    
		out.println("File not found: " + original_filename);
    }
%>    
<br/><br/><input type="button" onclick="history.back()" value="回到上頁">
    </body>
</html>

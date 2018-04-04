<%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 02.04.18
  Time: 23:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.User" %>

<%
    File file ;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String filePath = "web/files/";

    String contentType = request.getContentType();

    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);

        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("/Users/quentinwendegass/temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // maximum file size to be uploaded.
        upload.setSizeMax( maxFileSize );

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();

            out.println("<html>");
            out.println("<head>");
            out.println("<title>JSP File upload</title>");
            out.println("</head>");
            out.println("<body>");

            String fileName = null;
            String title = null;
            String description = null;

            while ( i.hasNext () ) {
                FileItem fi = (FileItem)i.next();
                if ( !fi.isFormField () ) {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();

                    // Write the file
                    if( fileName.lastIndexOf("\\") >= 0 ) {
                        file = new File( filePath +
                                fileName.substring( fileName.lastIndexOf("\\"))) ;
                    } else {
                        file = new File( filePath +
                                fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                    }
                    fi.write( file ) ;

                    out.println("Uploaded Filename: " + filePath +
                            fileName + "<br>");
                }else{
                    String fieldName = fi.getFieldName();
                    String fieldValue = fi.getString();

                    if(fieldName.equals("title")){
                        title = fieldValue;
                    }else if(fieldName.equals("description")){
                        description = fieldValue;
                    }
                }
            }

            DBManager manager = new DBManager();

            try{
                User user = (User) request.getSession().getAttribute("user");
                manager.addBookToUser(title, description, fileName, user.getId());
            }catch (Exception e){

            }finally {
                manager.close();
            }

            out.println("</body>");
            out.println("</html>");
        } catch(Exception ex) {
            System.out.println(ex);
        }
    } else {
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet upload</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<p>No file uploaded</p>");
        out.println("</body>");
        out.println("</html>");
    }
%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDDocument" %>
<%@ page import="org.apache.pdfbox.rendering.PDFRenderer" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="org.apache.pdfbox.rendering.ImageType" %>
<%@ page import="org.apache.pdfbox.tools.imageio.ImageIOUtil" %>
<%@ page import="at.greywind.onlinereader.FailedToConvertThumbnailException" %>
<%@ page import="java.nio.file.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User)request.getSession().getAttribute("user");
    if(user == null){
        response.setStatus(403);
        return;
    }
    int maxFileSize = 50000 * 1024; //50Mb
    int maxMemSize = 50000 * 1024;

    ServletContext context = pageContext.getServletContext();
    String filePath = context.getInitParameter("file-upload");
    String tempFilePath = context.getInitParameter("file-upload-temp");

    System.out.println(filePath);

    String contentType = request.getContentType();

    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        factory.setRepository(new File(tempFilePath));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax( maxFileSize );

        try {
            List fileItems = upload.parseRequest(request);

            Iterator i = fileItems.iterator();

            String fileName = null;
            String title = null;
            String description = null;

            Path path = null;

            while ( i.hasNext () ) {
                FileItem fi = (FileItem)i.next();
                if ( !fi.isFormField () ) {
                    fileName = fi.getName();

                    path = Paths.get(filePath + fileName);
                    int j = 0;
                    while(Files.exists(path)){
                        path = Paths.get(filePath + j + fileName);
                        j++;
                    }

                    fi.write( path.toFile() ) ;

                    try {
                        PDDocument document = PDDocument.load(path.toFile());
                        PDFRenderer pdfRenderer = new PDFRenderer(document);

                        BufferedImage bim = pdfRenderer.renderImageWithDPI(0, 80, ImageType.RGB);

                        ImageIOUtil.writeImage(bim, path.getParent() + "/thumb/" + path.getFileName() + "-thumb.png", 80);

                        document.close();
                    }catch (Exception e){
                        try {
                            Files.delete(path);
                        } catch (Exception x) {

                        }finally {
                            throw new FailedToConvertThumbnailException();
                        }
                    }
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
                manager.addBookToUser(title, description, path.getFileName().toString(), user.getId());
            } catch (Exception e){
                throw e;
            } finally {
                manager.close();
            }
        } catch (Exception e) {
            response.setStatus(209);
            return;
        }
    } else {
        response.setStatus(204);
        return;
    }
%>

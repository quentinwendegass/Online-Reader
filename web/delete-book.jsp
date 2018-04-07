<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User)request.getSession().getAttribute("user");
    if(user == null){
        response.sendRedirect("index.jsp");
        return;
    }

    DBManager manager = new DBManager();

    try {
        String name = request.getParameter("name");

        ServletContext context = pageContext.getServletContext();
        String filePath = context.getInitParameter("file-upload");
        Files.deleteIfExists(Paths.get(filePath + name));
        Files.deleteIfExists(Paths.get(filePath + "thumb/" + name + "-thumb.png"));

        manager.deleteBookFromUser(user.getBookIdByName(name), user.getId());
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(409);
        return;
    }
%>
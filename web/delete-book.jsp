<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %><%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 06.04.18
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
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
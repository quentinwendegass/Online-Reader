<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.Book" %><%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 03.04.18
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Books</title>
    <script src="library.js"></script>
</head>
<body>
<%User user = (User)request.getSession().getAttribute("user");
    DBManager manager = new DBManager();
    try{
        user.setBooks(manager.getBooksforUser(user.getId()));
    }catch (Exception e){
        response.sendRedirect("index.jsp");
        return;
    } finally {
        manager.close();
    }
%>

<% for(Book b : user.getBooks()){%>
<div class="book" style="background-image: url('<%out.print("files/thumb/" + b.getName() + "-thumb.png");%>')" id="<%out.print(b.getName());%>">
    <div class="book-content">
        <div class="title-bar">
            <h3 class="title"><%out.print(b.getTitle());%></h3>
        </div>
    <p class="description"><%if(b.getDescription() != null)out.print(b.getDescription());%></p>
    </div>
</div>
<%}%>
<div class="add-book">
    <i class="fas fa-plus fa-8x icon"></i>
</div>


</body>
</html>

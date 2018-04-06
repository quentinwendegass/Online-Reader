<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="at.greywind.onlinereader.DBManager" %>
<%@ page import="at.greywind.onlinereader.Book" %>

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
        <i class="fas fa-times-circle delete"></i>
        <div class="title-bar">
            <h3 class="title"><%out.print(b.getTitle());%></h3>
        </div>
        <div class="description-wrapper">
            <p class="description"><%if(b.getDescription() != null)out.print(b.getDescription());%></p>
        </div>
    </div>
</div>
<%}%>
<div class="add-book">
    <i class="fas fa-plus fa-8x icon"></i>
</div>


</body>
</html>

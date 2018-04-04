<%@ page import="at.greywind.onlinereader.User" %>
<%@ page import="at.greywind.onlinereader.Book" %>
<%@ page import="at.greywind.onlinereader.DBManager" %><%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 01.04.18
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Library</title>
    <script src="library.js"></script>
    <script src="jquery-3.3.1.js"></script>
    <script src="jquery-color-2.1.2.js"></script>
    <script src="pdf.js"></script>
    <script src="pdf.worker.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" integrity="sha384-5SOiIsAziJl6AWe0HWRKTXlfcSHKmYV4RBF18PPJ173Kzn7jzMyFuTtk8JA7QQG1" crossorigin="anonymous">
    <link rel="stylesheet" href="library.css">
</head>
<body>

<%
    User user = (User)request.getSession().getAttribute("user");
    if(user == null){
        response.sendRedirect("index.jsp");
        return;
    }
%>

<div class="header">
    <span class="header-item logo">Library</span>
    <span class="header-item profile">You are logged in as <%out.print(user.getUsername());%></span>
    <span class="header-item logout">Logout</span>
</div>
<div class="library-content">

</div>

<div class="add-book-content">
    <div class="add-book-bar">
        <i id="close" class="fas fa-times-circle fa-2x icon"></i>
    </div>
    <form id="upload" action="" method="post" enctype="multipart/form-data">
    <input type="text" placeholder="Title of the Book" id="title" name="title" required>
    <textarea rows=6 maxlength="2000" placeholder="Description of the Book (optional)" id="description" name="description"></textarea>
    <input id="file-select" type = "file" name = "file" required/>
        <label for="file-select">Choose a file</label>
    <input id="submit-btn" type="submit" value="Upload"/>
    </form>
    <h5 id="test"></h5>

</div>

<script>
    requestBooks()
</script>


</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 01.04.18
  Time: 01:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/solid.css" integrity="sha384-29Ax2Ao1SMo9Pz5CxU1KMYy+aRLHmOu6hJKgWiViCYpz3f9egAJNwjnKGgr+BXDN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/fontawesome.css" integrity="sha384-Lyz+8VfV0lv38W729WFAmn77iH5OSroyONnUva4+gYaQTic3iI2fnUKtDSpbVf0J" crossorigin="anonymous">
    <link rel="stylesheet" href="index.css">
    <script src="index.js"></script>
    <title>Online Reader</title>
  </head>
  <body>

  <% try{
      if(request.getParameter("logout").equals("true")){
          request.getSession().removeAttribute("user");
    }
  }catch (Exception e){

  }%>

  <div id="content">
    <div id="bar">
      <button class="bar-button" type="button" onclick="requestForm('login')">LOG IN</button>
      <button class="bar-button" type="button" onclick="requestForm('signup')">SIGN UP</button>
    </div>
    <div id="wrapper">
    </div>
  </div>


  </body>
</html>

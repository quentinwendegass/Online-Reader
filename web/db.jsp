<%@ page import="java.sql.SQLException" %>
<%@ page import="at.greywind.onlinereader.*" %><%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 01.04.18
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>DB</title>
</head>
<body>
<%
    DBManager manager = new DBManager();

    try{

    if (request.getParameter("action").equals("login")) {
        try {
            User user = manager.login(request.getParameter("username"), request.getParameter("password"));
            if(user != null) request.getSession().setAttribute("user", user);
        } catch (WrongPasswordException e) {
            response.setStatus(409);
            out.println("This was the wrong password! Please try again.");
        } catch (NoSuchUserNameException e) {
            response.setStatus(409);
            out.println("This user doesn't exist! Please check if you misspelled it or sign up.");
        } catch (SQLException e) {
            response.setStatus(409);
        }
    } else if (request.getParameter("action").equals("signup")) {
        try {
           User user = manager.register(request.getParameter("username"), request.getParameter("email"), request.getParameter("password"), request.getParameter("confirm-password"));
           if(user != null) request.getSession().setAttribute("user", user);
        } catch (WrongPasswordException e) {
            response.setStatus(409);
            out.println("Password and confirmation does not match!");
        } catch (NoSuchUserNameException e) {
            response.setStatus(409);
            out.println("This username is already taken! Please take an other one.");
        } catch (EmailAlreadyExistsException e) {
            response.setStatus(409);
            out.println("This email address is already in use! Try to log in.");
        }catch (SQLException e) {
            response.setStatus(409);
        }
    }
    }catch (Exception e){
        e.printStackTrace();
        response.setStatus(409);
    }finally {
        manager.close();
    }
%>
</body>
</html>

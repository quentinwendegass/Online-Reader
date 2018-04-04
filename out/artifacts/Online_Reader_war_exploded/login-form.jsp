<%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 01.04.18
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <script src="index.js"></script>
</head>
<body>
        <div id="input-box">
            <table>
                <tr>
                    <td><div class="icon-wrapper"><i style="color:#161616" class="fas fa-user"></i></div></td>
                    <td> <input class="txt-field" type="text" id="username" placeholder="Username"></td>
                </tr>
                <tr>
                    <td><div class="icon-wrapper"><i style="color: #161616" class="fas fa-key"></i></div></td>
                    <td><input class="txt-field" type="password" id="password" placeholder="Password"></td>
                </tr>
            </table>
        </div>
        <input class="login-btn" type="button" value="LOGIN" onclick="submitLoginForm()">
        <p id="error" class="error"></p>
</body>
</html>

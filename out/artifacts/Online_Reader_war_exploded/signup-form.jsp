<%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 01.04.18
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Signup</title>
</head>
<body>
        <div id="input-box">
            <table>
                <tr>
                    <td><span class="sign-up-text">Username:</span></td>
                    <td><input class="txt-field" type="text" id="username" placeholder="Username"></td>
                </tr>
                <tr>
                    <td><span class="sign-up-text">Email:</span></td>
                    <td><input class="txt-field" type="email" id="email" placeholder="Email"></td>
                </tr>
                <tr>
                    <td><span class="sign-up-text">Password:</span></td>
                    <td><input class="txt-field" type="password" id="password" placeholder="password"></td>
                </tr>
                <tr>
                    <td><span class="sign-up-text">Confirm Password:</span></td>
                    <td><input class="txt-field" type="password" id="confirm-password" placeholder="password"></td>
                </tr>
            </table>
        </div>
        <input class="signup-btn" type="button" value="SIGNUP" onclick="submitSignupForm()">
        <p id="error" class="error" style="margin-top: -10px; width: 75%; margin-left: 12%"></p>
</body>
</html>

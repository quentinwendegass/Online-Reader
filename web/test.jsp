<%--
  Created by IntelliJ IDEA.
  User: quentinwendegass
  Date: 03.04.18
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <script src="jquery-3.3.1.js"></script>

    <style>

        object{
            width: 210px;
            height: 300px;
        }

    </style>
</head>
<body>
<object id="ob" data="test.pdf"></object>
<script>

    window.onload = function (ev) {
        $("#ob").scroll(function () {
            console.log("FIck");
        });
    }





</script>
</body>
</html>

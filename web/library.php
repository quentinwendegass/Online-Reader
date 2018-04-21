<?php
require_once "src/User.php";
session_start();
?>

<html>
<head>
    <?php
    $user = $_SESSION["user"];

    if($user == null){
        echo "<script>location.href='index.php';</script>";
    }
    ?>
    <title>Library</title>
    <script src="script/jquery-3.3.1.js"></script>
    <script src="script/jquery-color-2.1.2.js"></script>
    <script src="script/library.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" integrity="sha384-5SOiIsAziJl6AWe0HWRKTXlfcSHKmYV4RBF18PPJ173Kzn7jzMyFuTtk8JA7QQG1" crossorigin="anonymous">
    <link rel="stylesheet" href="style/library.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<div class="header">
    <span class="header-item logo">Library</span>
    <span class="header-item profile">You are logged in as <?php if($user != null) echo $user->getUsername(); ?></span>
    <span class="header-item logout">Logout</span>
</div>
<div id="library-wrapper">
    <div class="library-content">

    </div>
</div>

<div class="book-showcase">
    <object class="book-object" data=""></object>
</div>

<div class="add-book-content">
    <div class="add-book-bar">
        <i id="close" class="fas fa-times-circle fa-2x icon"></i>
    </div>
    <form id="upload" action="" method="post" enctype="multipart/form-data">
    <input type="text" placeholder="Title of the Book" id="title" name="title" required>
    <textarea rows=6 maxlength="2000" placeholder="Description of the Book (optional)" id="description" name="description"></textarea>
    <input id="file-select" type = "file" accept="application/pdf" name = "file" required/>
        <label for="file-select">Choose a file</label>
    <input id="submit-btn" type="submit" value="Upload"/>
    </form>
    <p id="upload-error"></p>
</div>

<script>requestBooks()</script>

</body>
</html>

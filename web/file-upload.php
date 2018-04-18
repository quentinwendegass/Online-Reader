<?php
require_once "src/User.php";
session_start();

require_once "src/DBManager.php";

$user = $_SESSION["user"];

if($user == null){
    http_response_code(401);
    return;
}


$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["file"]["name"]);
$uploadOk = 1;
$fileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

if ($_FILES["file"]["size"] == 0) {
    http_response_code(406);
    echo "Sorry, your file is too large.";
    return;
}else if($fileType != "pdf") {
    http_response_code(406);
    echo "Sorry, only PDF files are allowed.";
    return;
}

$i = 0;
while (file_exists($target_file)) {
    $target_file = pathinfo($target_file, PATHINFO_DIRNAME) . '/' . pathinfo($target_file, PATHINFO_FILENAME) . $i . "." . $fileType;
    $i++;
}

if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
    exec("convert \"" . $target_file. "[0]\" \"" . pathinfo($target_file, PATHINFO_DIRNAME) . '/thumb/' . pathinfo($target_file, PATHINFO_FILENAME) . "-thumb.png\"");
    $db = new DBManager();
    try {
        $db->addBookToUser($_POST["title"], $_POST["description"], pathinfo($target_file, PATHINFO_FILENAME), $user->getId());
    } catch (NoSuchElementException | SQLException $e) {
        http_response_code(406);
        echo "Sorry, there was an error uploading your file.";
    }
} else {
    http_response_code(406);
    echo "Sorry, there was an error uploading your file.";
}




<?php
require_once "src/User.php";
session_start();

require_once "src/Constants.php";
require_once "src/DBManager.php";

$user = $_SESSION["user"];

if($user == null){
    http_response_code(401);
    return;
}

$db = new DBManager();

try{
    $name = $_POST["name"];

    if(file_exists(UPLOAD_DIRECTORY . $name . ".pdf")){
        unlink(UPLOAD_DIRECTORY . $name . ".pdf");
    }

    if(file_exists(UPLOAD_DIRECTORY . "thumb/" . $name . "-thumb.png")){
        unlink(UPLOAD_DIRECTORY . "thumb/" . $name . "-thumb.png");
    }

    $db->deleteBookFromUser($user->getBookIdByName($name), $user->getId());
}catch(Exception $e){
    die(409);
}

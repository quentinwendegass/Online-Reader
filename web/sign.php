<?php
session_start();

require_once "src/DBManager.php";
require_once "src/User.php";
require_once "src/Exceptions.php"
?>
<html>
<head>
    <title>Sign</title>
</head>
<body>
<?php

$db = new DBManager();

try{
    if($_POST["action"] == "login"){
        try{
            $user = $db->login($_POST["username"], $_POST["password"]);
            if($user != null) $_SESSION["user"] = $user;
        }catch(NoSuchUserNameException $e){
            echo "This user doesn't exist! Please check if you misspelled it or sign up.\n";
            http_response_code(409);
        }catch(SQLException $e){
            http_response_code(409);
        }catch(WrongPasswordException $e){
            echo "This was the wrong password! Please try again.\n";
            http_response_code(409);
        }
    }else if($_POST["action"] == "signup"){
        try{
            $user = $db->register($_POST["username"], $_POST["email"], $_POST["password"], $_POST["confirm-password"]);
            if($user != null) $_SESSION["user"] = $user;
        }catch(EmailAlreadyExistsException $e){
            echo "This email address is already in use! Try to log in.\n";
            http_response_code(409);
        }catch(SQLException $e){
            http_response_code(409);
        }catch(UserAlreadyExistsException $e){
            echo "This username is already taken! Please take an other one.\n";
            http_response_code(409);
        }catch(WrongPasswordException $e){
            echo "Password and confirmation does not match!\n";
            http_response_code(409);
        }
    }
}catch (Exception $e){
    response.setStatus(409);
}
?>
</body>
</html>

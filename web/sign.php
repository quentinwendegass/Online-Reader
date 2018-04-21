<?php
require_once "src/User.php";
session_start();

require_once "src/DBManager.php";
require_once "src/Exceptions.php";


$db = new DBManager();

try{
    if($_POST["action"] == "login"){
        try{
            $user = $db->login($_POST["username"], $_POST["password"]);
            if($user != null) $_SESSION["user"] = $user;
        }catch(NoSuchUserNameException $e){
            http_response_code(406);
            echo "This user doesn't exist! Please check if you misspelled it or sign up.\n";
            return;
        }catch(SQLException $e){
            http_response_code(406);
            echo "An error occurred!\n";
            return;
        }catch(WrongPasswordException $e){
            http_response_code(406);
            echo "This was the wrong password! Please try again.\n";
            return;
        }
    }else if($_POST["action"] == "signup"){
        try{
            $user = $db->register($_POST["username"], $_POST["email"], $_POST["password"], $_POST["confirm-password"]);
            if($user != null) $_SESSION["user"] = $user;
        }catch(EmailAlreadyExistsException $e){
            http_response_code(406);
            echo "This email address is already in use! Try to log in.\n";
            return;
        }catch(SQLException $e){
            http_response_code(406);
            echo "An error occurred!\n";
            return;
        }catch(UserAlreadyExistsException $e){
            http_response_code(406);
            echo "This username is already taken! Please take an other one.\n";
            return;
        }catch(WrongPasswordException $e){
            http_response_code(406);
            echo "Password and confirmation does not match!\n";
            return;
        }
    }
}catch (Exception $e){
    http_response_code(406);
}


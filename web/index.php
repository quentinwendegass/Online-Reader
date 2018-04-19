<?php
session_start();

try{
    if($_GET["logout"] == "true"){
        session_unset();
        session_destroy();
    }
}catch (Exception $e){}
?>

<html>
  <head>
      <?php
      try{
          if($_SESSION["user"] != null){
              echo "<script>location.href='library.php';</script>";
          }
      }catch (Exception $e){

      }
      ?>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/solid.css" integrity="sha384-29Ax2Ao1SMo9Pz5CxU1KMYy+aRLHmOu6hJKgWiViCYpz3f9egAJNwjnKGgr+BXDN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.9/css/fontawesome.css" integrity="sha384-Lyz+8VfV0lv38W729WFAmn77iH5OSroyONnUva4+gYaQTic3iI2fnUKtDSpbVf0J" crossorigin="anonymous">
    <link rel="stylesheet" href="style/index.css">
    <script src="script/jquery-3.3.1.js"></script>
    <script src="script/index.js"></script>
    <title>Online Reader</title>
  </head>
  <body>

  <div id="content">
    <div id="bar">
      <button id="login" class="bar-button" type="button">LOG IN</button>
      <button id="signup" class="bar-button" type="button">SIGN UP</button>
    </div>
    <div id="login-content">
      <form id="login-form" action="" method="post">
        <div class="input-box">
          <table>
            <tr>
              <td><div class="icon-wrapper"><i style="color:#161616" class="fas fa-user"></i></div></td>
              <td> <input class="txt-field" name="username" type="text" placeholder="Username" required></td>
            </tr>
            <tr>
              <td><div class="icon-wrapper"><i style="color: #161616" class="fas fa-key"></i></div></td>
              <td><input class="txt-field" name="password" type="password" placeholder="Password" required></td>
            </tr>
          </table>
        </div>
        <input type="hidden" name="action" value="login">
        <input class="login-btn" type="submit" value="LOGIN">
        <p id="login-error" class="error"></p>
      </form>
    </div>
    <div id="signup-content">
      <form id="signup-form" action="" method="post">
        <div class="input-box">
          <table>
            <tr>
              <td><span class="sign-up-text">Username:</span></td>
              <td><input class="txt-field" type="text" name="username" placeholder="Username" required></td>
            </tr>
            <tr>
              <td><span class="sign-up-text">Email:</span></td>
              <td><input class="txt-field" type="email" name="email" placeholder="Email" required></td>
            </tr>
            <tr>
              <td><span class="sign-up-text">Password:</span></td>
              <td><input class="txt-field" type="password" name="password" placeholder="Password" required></td>
            </tr>
            <tr>
              <td><span class="sign-up-text">Confirm Password:</span></td>
              <td><input class="txt-field" type="password" name="confirm-password" placeholder="Confirm Password" required></td>
            </tr>
          </table>
        </div>
        <input type="hidden" name="action" value="signup">
        <input class="signup-btn" type="submit" value="SIGNUP">
        <p id="signup-error" class="error"></p>
      </form>
    </div>
  </div>
  </body>
</html>

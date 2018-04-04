window.onload = function (ev) {
  requestForm("login") ;
};

function submitLoginForm() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            window.location.href = "library.jsp";
        }else if (this.readyState == 4 && this.status == 409) {
            document.getElementById("error").innerHTML= this.responseText;
        }
    };
    xhttp.open("POST", "db.jsp", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    var pwd = document.getElementById("password").value
    var user = document.getElementById("username").value
    xhttp.send("username="+ user + "&password=" + pwd + "&action=login");
}

function submitSignupForm() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            window.location.href = "library.jsp?signup=true";
        }else if (this.readyState == 4 && this.status == 409) {
            document.getElementById("error").innerHTML= this.responseText;
        }
    };
    xhttp.open("POST", "db.jsp", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    var pwd = document.getElementById("password").value
    var user = document.getElementById("username").value
    var confPwd = document.getElementById("confirm-password").value
    var email = document.getElementById("email").value
    xhttp.send("username="+ user + "&password=" + pwd + "&action=signup" + "&confirm-password=" + confPwd +"&email=" + email);
}

function requestForm(id) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("wrapper").innerHTML = this.responseText;
        }
    };

    if(id == "signup"){
        xhttp.open("GET", "signup-form.jsp", true);
    }else{
        xhttp.open("GET", "login-form.jsp", true);
    }
    xhttp.send();
}


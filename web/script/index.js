$(document).ready(function(){
    $("#login").click(function () {
        $("#signup-content").css({display: "none"});
        $("#login-content").css({display: "block"});
    });

    $("#signup").click(function () {
        $("#login-content").css({display: "none"});
        $("#signup-content").css({display: "block"});
    });

    $('#login-form').submit(function (e) {
        e.preventDefault();
        sendRequest($(this).serialize(), "library.jsp", $("#login-error"));
    });

    $('#signup-form').submit(function (e) {
        e.preventDefault();
        sendRequest($(this).serialize(), "library.jsp?signup=true", $("#signup-error"));
    });
});

function sendRequest(data, href, error) {
    $.ajax({
        url: "sign.jsp",
        type: "POST",
        data: data,
        cache: false,
        success: function (data)
        {
            window.location.href = href;
        },
        error: function (jqXHR, exception) {
            error.html(jqXHR.responseText);
        }
    });
}
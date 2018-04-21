$(document).ready(function () {
    $(".logo").click(function () {
        $(".library-content").show();
        $(".book-showcase").hide();
    });

    $("#file-select").change(function (e) {
        var fileName = '';

        if( this.files && this.files.length > 1 )
            fileName = ( this.getAttribute( 'data-multiple-caption' ) || '' ).replace( '{count}', this.files.length );
        else if( e.target.value )
            fileName = e.target.value.split( '\\' ).pop();

        if( fileName )
            $(this).next("label").html(fileName);
    });

    $("#upload").on('submit', function (e) {
        e.preventDefault();
        $("#submit-btn").prop("disabled",true);
        $.ajax({
            url: "file-upload.php",
            type: "POST",
            data: new FormData(this),
            contentType: false,
            cache: false,
            processData: false,
            success: function (data)
            {
                $(".add-book-content").css({display: "none"});
                requestBooks()
                $("#file-select+label").html("Choose a file");
                $("#title").val("");
                $("#file-select").val("");
                $("#description").val("");
                $("#submit-btn").prop("disabled",false);
            },
            error: function (jqXHR, exception) {
                var msg = jqXHR.responseText;
                $("#upload-error").html(msg);
                $("#submit-btn").prop("disabled",false);
            }
        });
    });

    $("#close").click(function () {
        $(this).parent().parent().css({display: "none"});
    });

    $(".logout").click(function () {
        window.location.href = "index.php?logout=true";
    });

    $(".logout").hover(function () {
        $(this).stop();
        $(this).animate({backgroundColor: "rgb(236, 236, 236)", color: "#2b2a2b"}, "fast");
    }, function () {
        $(this).stop();
        $(this).animate({backgroundColor: "#2b2a2b", color: "rgb(236, 236, 236)"}, "fast");
    });
});

$(window).on('resize', function (e) {

var windowWidth = $(window).width();
var bookWidth = 250;
var booksInRow = ~~(windowWidth / bookWidth);

if(booksInRow * bookWidth + 150 > windowWidth){
    $(".library-content").width((booksInRow - 1) * bookWidth + 200);
}else{
    $(".library-content").width(windowWidth);
}
});

function requestBooks() {
    $.ajax({
        url: "books.php",
        type: "POST",
        data: new FormData(),
        contentType: false,
        cache: false,
        processData: false,
        success: function (data)
        {
            $(".library-content").html(data);
        }
    });
}


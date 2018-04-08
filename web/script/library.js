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

    $("#upload").one('submit', function (e) {
        e.preventDefault();
        $.ajax({
            url: "file-upload.jsp",
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
            },
            error: function (jqXHR, exception) {
                var msg = 'Something went wrong with uploading your file!';
                $("#upload-error").html(msg);
            }
        });
    });

    $("#close").click(function () {
        $(this).parent().parent().css({display: "none"});
    });

    $(".logout").click(function () {
        window.location.href = "index.jsp?logout=true";
    });

    $(".logout").hover(function () {
        $(this).stop();
        $(this).animate({backgroundColor: "rgb(236, 236, 236)", color: "#2b2a2b"}, "fast");
    }, function () {
        $(this).stop();
        $(this).animate({backgroundColor: "#2b2a2b", color: "rgb(236, 236, 236)"}, "fast");
    });
});

function requestBooks() {
    $.ajax({
        url: "books.jsp",
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


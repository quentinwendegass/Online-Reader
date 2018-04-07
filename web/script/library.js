$(document).ready(function () {
    $(".add-book").hover(function () {
        $(this).stop();
        $(this).find(".icon").stop();
        $(this).find(".icon").animate({color: "rgba(9,9,9,0.7)"}, "fast");
        $(this).animate({backgroundColor: "rgba(80,80,80,0.45)"}, "fast");
    }, function () {
        $(this).stop();
        $(this).find(".icon").stop();
        $(this).find(".icon").animate({color: "rgba(200,200,200,0.7)"}, "fast");
        $(this).animate({backgroundColor: "rgba(80,80,80,0.9)"}, "fast");
    });

    $(".book").click(function () {
        $(".library-content").hide();
        $(".add-book-content").hide();
        $(".book-showcase").show();
        $(".book-object").attr("data", "files/" + $(this).attr("id"));
    });

    $(".logo").click(function () {
        $(".library-content").show();
        $(".book-showcase").hide();
    });

    $(".book-content").hover(function () {
        $(this).find(".delete").css({display: "block"});
        $(this).stop();
        $(this).find(".description").stop();
        $(this).parent().stop();
        $(this).find(".delete").stop();
        $(this).find(".description").animate({opacity: "1"}, "slow");
        $(this).animate({backgroundColor: "rgba(80,80,80,0.65)"}, "slow");
        $(this).parent().animate({width: "300px"}, "slow");
        $(this).find(".delete").animate({opacity: "1"}, "slow");

    }, function () {
        $(this).find(".delete").css({display: "block"});
        $(this).stop();
        $(this).find(".description").stop();
        $(this).parent().stop();
        $(this).find(".delete").stop();
        $(this).find(".description").animate({opacity: "0"}, "slow");
        $(this).animate({backgroundColor: "rgba(80,80,80,0.15)"}, "slow");
        $(this).parent().animate({width: "210px"}, "slow");
        $(this).find(".delete").animate({opacity: "0"}, "fast");
    });

    $(".delete").click(function (e) {
        e.stopPropagation();
        $.ajax({
            url: "delete-book.jsp",
            type: "POST",
            data: {
                name: $(this).closest(".book").attr("id")
            },
            cache: false,
            success: function (data) {
                requestBooks();
            }
        });
    });

    $(".add-book").click(function () {
        $("#upload-error").html("");
        $(".add-book-content").css({display: "block"});
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

    $("#upload").on('submit',function (e) {
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


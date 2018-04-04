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

$(".book-content").hover(function () {
    $(this).stop();
    $(this).find(".description").stop();
    $(this).parent().stop();
    $(this).find(".description").animate({opacity: "1"}, "slow");
    $(this).animate({backgroundColor: "rgba(80,80,80,0.65)"}, "slow");
    $(this).parent().animate({width: "300px", backgroundSize: "120%"}, "slow");
}, function () {
    $(this).stop();
    $(this).find(".description").stop();
    $(this).parent().stop();
    $(this).find(".description").animate({opacity: "0"}, "slow");
    $(this).animate({backgroundColor: "rgba(80,80,80,0.15)"}, "slow");
    $(this).parent().animate({width: "210px", backgroundSize: "100%"}, "slow");
});

$(".add-book").click(function () {
    $(".add-book-content").css({display: "block"});
});


function requestBooks() {
    $.ajax({
        url: "books.jsp", // Url to which the request is send
        type: "POST",             // Type of request to be send, called as method
        data: new FormData(), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
        contentType: false,       // The content type used when sending data to the server.
        cache: false,             // To unable request pages to be cached
        processData: false,        // To send DOMDocument or non processed data file it is set to false
        success: function (data)   // A function to be called if request succeeds
        {
            $(".library-content").html(data);
        }
    });
}


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
        url: "file-upload.jsp", // Url to which the request is send
        type: "POST",             // Type of request to be send, called as method
        data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
        contentType: false,       // The content type used when sending data to the server.
        cache: false,             // To unable request pages to be cached
        processData: false,        // To send DOMDocument or non processed data file it is set to false
        success: function (data)   // A function to be called if request succeeds
        {
            $(".add-book-content").css({display: "none"});
            requestBooks()
            $("#file-select+label").html("Choose a file");
            $("#title").val("");
            $("#file-select").val("");
            $("#description").val("");


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
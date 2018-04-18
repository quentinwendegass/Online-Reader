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
        $(".book-object").attr("data", "uploads/" + $(this).attr("id") + ".pdf");
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
            url: "delete-book.php",
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
});
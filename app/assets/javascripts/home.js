$('#queryForm').submit(function(e) {
    e.preventDefault(); // don't submit multiple times

    var container = $("<div class='conv_entry'></div>");
    var query = $("<p></p>").text($('#query').val());
    var waiting = $("<span></span>").text(" (Loading...)");
    query.attr('style', 'color:yellow');
    waiting.attr('style', 'color:yellow');
    query.prepend(waiting);
    container.prepend(query);


    $('#conv_iframe').contents().find('body').prepend(container);
    resizeIframe();
    this.submit(); // use the native submit method of the form element

    setTimeout(function() { // Delay for Chrome
        $('#query').val(''); // blank the input
    }, 100);
});

$(document).ready(function() {
    // Scrolls {@code #conv_div} down to bottom of page for when content is beyond the fixed div height.
    var element = document.getElementById("chat-body");
    if (element) {
        element.scrollTop = element.scrollHeight;
    }
});

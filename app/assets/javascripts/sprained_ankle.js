$(document).ready(function() {
    var element_1 = document.getElementById("narrator_content");
    var element_2 = document.getElementById("watson_content");

    if (element_1 && element_2) {
    	$("body").scrollTop = $("body").scrollHeight;
    	element_1.scrollTop = element_1.scrollHeight;
    	element_2.scrollTop = element_2.scrollHeight;
    }
});
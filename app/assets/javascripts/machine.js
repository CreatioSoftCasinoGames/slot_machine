$(document).ready(function(){
	$("#country").change(function(){
		var k = document.getElementById("country").value;
		window.location = "?country="+k;
	});
});

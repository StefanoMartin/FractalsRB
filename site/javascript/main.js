var downloadPicture = function(){
	$.ajax({
		url: "http://127.0.0.1:4567/fractal",
		type: "POST",
    dataType: 'json',
		data: JSON.stringify({
			"repetition": 13,
			"translation": [[100,200],[200,300],[134,123]],
			"rotation": [43,-25,134],
			"size": [0.3,0.72,0.6],
			"size_square": 200,
			"width": 1800,
			"height": 1800
		}),
		success: function(data){
			$("#main_img").attr("src", "data:image/png;base64," + data["data"]);
		},
		error: function(response,b,c){
			// alert("Error: "+b+" with message: "+c);
			console.log(response+"Error: "+b+" with message: "+c);
		}
	});
}

$(document).ready(function(){
		downloadPicture();
		// clickEvents();
	}
);

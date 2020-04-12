var build = function(){
	var height = parseInt($(".box_fix").children()[0].children[1].value)
	var width = parseInt($(".box_fix").children()[1].children[1].value)
	var size_square = parseInt($(".box_fix").children()[2].children[1].value)
	var repetition = parseInt($(".box_fix").children()[3].children[1].value)

	var fractals = [];
	$.each($(".boxes").children(), function(index, value){
		fractals.push({
			"x": parseInt(value.children[0].children[1].value),
			"y": parseInt(value.children[1].children[1].value),
			"rotation": parseInt(value.children[2].children[1].value),
			"size": parseFloat(value.children[3].children[1].value),
		});
	});

	$.ajax({
		url: "http://127.0.0.1:4567/fractal",
		type: "POST",
    dataType: 'json',
		data: JSON.stringify({
			"repetition": repetition,
			"size_square": size_square,
			"width": width,
			"height": height,
			"fractals": fractals
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

var clickEvents = function(){
	$("body").on("mouseup", ".slider", change_value);
	$("body").on("mouseup", ".myButton", delete_fractal);
	$(".addButton").on("mouseup", add_fractal);
	$(".buildButton").on("mouseup", build);
}

var change_value = function(eventObject){
	eventObject.target.parentElement.children[2].innerHTML = eventObject.target.value;
}

var delete_fractal = function(eventObject){
	eventObject.target.parentElement.remove();
}

var add_fractal = function(){
	var m = `<div class="box_iteration">
			<div class="slidecontainer">
				<label>X: </label> <input type="range" min="-300" max="300" value="100" class="slider"> <label>100</label>
			</div>

			<div class="slidecontainer">
				<label>Y: </label> <input type="range" min="-300" max="300" value="100" class="slider"> <label>100</label>
			</div>

			<div class="slidecontainer">
				<label>Rotation: </label> <input type="range" min="0" max="360" value="45" class="slider"> <label>45</label>
			</div>

			<div class="slidecontainer">
				<label>Size: </label> <input type="range" min="0" max="1" value="0.5" class="slider" step="0.01"> <label>0.5</label>
			</div>

			<a href="#" class="myButton">Remove</a>
		</div>`

	$(".boxes").append(m);
}

$(document).ready(function(){
		build();
		clickEvents();
	}
);

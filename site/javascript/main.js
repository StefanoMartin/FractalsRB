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
			console.log(response+"Error: "+b+" with message: "+c);
		},
		beforeSend: function(){ $("#loading").css("visibility", "visible"); },
		complete: function(){ $("#loading").css("visibility", "hidden"); }
	});
}

var randomBuild = function(){
	$.each($(".boxes").children(), function(index, value){ value.remove(); });
	var number_obj = Math.floor(Math.random() * 5) + 1;
	for (let i = 0; i < number_obj; i++){ add_fractal(); }
	$(".box_fix").children()[0].children[1].value = 1000
	$(".box_fix").children()[0].children[2].value = $(".box_fix").children()[0].children[1].value;
	$(".box_fix").children()[1].children[1].value = 1000
	$(".box_fix").children()[1].children[2].value = $(".box_fix").children()[1].children[1].value;
	$(".box_fix").children()[2].children[1].value = Math.floor(Math.random() * 200) + 50;
	$(".box_fix").children()[2].children[2].value = $(".box_fix").children()[2].children[1].value;
	$(".box_fix").children()[3].children[1].value = 12 - number_obj;
	$(".box_fix").children()[3].children[2].value = $(".box_fix").children()[3].children[1].value;
	$.each($(".boxes").children(), function(index, value){
		value.children[0].children[1].value = Math.floor(Math.random() * 600) - 300;
		value.children[0].children[2].value = value.children[0].children[1].value;
		value.children[1].children[1].value = Math.floor(Math.random() * 600) - 300;
		value.children[1].children[2].value = value.children[1].children[1].value;
		value.children[2].children[1].value = Math.floor(Math.random() * 360);
		value.children[2].children[2].value = value.children[2].children[1].value;
		value.children[3].children[1].value = Math.random();
		value.children[3].children[2].value = value.children[3].children[1].value;
	});
	build();
}

var clickEvents = function(){
	$("body").on("input", ".slider", change_value);
	$("body").on("input", ".number_slide", change_value_slide);
	$("body").on("mouseup", ".myButton", delete_fractal);
	$(".addButton").on("mouseup", add_fractal);
	$(".buildButton").on("mouseup", build);
	$(".randomButton").on("mouseup", randomBuild);
}

var change_value = function(eventObject){
	eventObject.target.parentElement.children[1].value = eventObject.target.value;
}

var change_value_slide = function(eventObject){
	eventObject.target.parentElement.children[2].value = eventObject.target.value;
}

var delete_fractal = function(eventObject){
	eventObject.target.parentElement.remove();
}

var add_fractal = function(){
	var m = `<div class="box_iteration">
			<div class="slidecontainer">
				<label>X: </label> <input class="number_slide" type="number" value="100"> <input type="range" min="-300" max="300" value="100" class="slider">
			</div>

			<div class="slidecontainer">
				<label>Y: </label> <input class="number_slide" type="number" value="100"> <input type="range" min="-300" max="300" value="100" class="slider">
			</div>

			<div class="slidecontainer">
				<label>Rotation: </label> <input class="number_slide" type="number" value="45"> <input type="range" min="0" max="360" value="45" class="slider">
			</div>

			<div class="slidecontainer">
				<label>Size: </label> <input class="number_slide" type="number" value="0.5" step="0.01"> <input type="range" min="0" max="1" value="0.5" class="slider" step="0.01">
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

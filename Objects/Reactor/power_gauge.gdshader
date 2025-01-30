shader_type canvas_item;

uniform float percentFull : hint_range(0, 1);

void fragment() {
	float shiftedPercent = (1.0-percentFull)*0.75+0.125;
	if (COLOR == vec4(0,0,0,1) && UV.y > shiftedPercent){
		COLOR = vec4(percentFull,1.0-percentFull,1.0-percentFull,1);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

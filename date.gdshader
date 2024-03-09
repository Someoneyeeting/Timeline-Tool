shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(length(UV - vec2(0.5,0.5)) >= 0.43)
		COLOR.rgb = vec3(0.);
	if(length(UV - vec2(0.5,0.5)) >= 0.5)
		COLOR.a = 0.0;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}

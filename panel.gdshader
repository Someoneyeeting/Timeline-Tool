shader_type canvas_item;


uniform sampler2D image;
uniform float stretch = 1.0;
uniform float off = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 s = vec2(1.0,stretch);
	//if(stretch > 1.){
		//s = vec2(1./stretch,1.0); 
		////off = vec2(((stretch - 1.0) / 2.0),0);
	//}
	float o = off * 1.-(stretch);
	vec4 clr = texture(image,UV * s + vec2(0.,off));
	COLOR.rgb = clr.rgb;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}

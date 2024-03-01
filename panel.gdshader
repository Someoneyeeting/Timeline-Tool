shader_type canvas_item;


uniform sampler2D image;
uniform float stretch = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 s = vec2(1.0,stretch);
	vec2 off = vec2(0.,0.);
	if(stretch > 1.){
		s = vec2(1./stretch,1.0); 
		off = vec2(((stretch - 1.0) / 2.0),0);
	}
	vec4 clr = texture(image,(UV + off) * s);
	COLOR.rgb = clr.rgb;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}

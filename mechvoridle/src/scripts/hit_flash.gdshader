shader_type canvas_item;
uniform float flash_amount = 0.0; // 0 = normal, 1 = full white flash
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
    vec4 white = vec4(1.0);
    COLOR = mix(tex_color, white, flash_amount);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

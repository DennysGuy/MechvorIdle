shader_type spatial;
render_mode unshaded, depth_draw_never, blend_mix;

uniform vec4 shine_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float cycle_interval : hint_range(0.5, 5.0) = 1.0;
uniform float shine_speed : hint_range(1.0, 5.0) = 3.0;
uniform float shine_width : hint_range(1.0, 100.0) = 3.0;

uniform float shine_strength : hint_range(0.0, 1.0) = 0.0;

void fragment()
{
	vec3 vertex = (VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;

	// Soft traveling wave (never zero unless shine_strength is zero)
	float wave = sin(
		vertex.z * cycle_interval +
		TIME * shine_speed * cycle_interval
	) * 0.5 + 0.5;

	// Width controls contrast, not visibility
	float mask = smoothstep(
		0.5 - shine_width * 0.005,
		0.5 + shine_width * 0.005,
		wave
	);

	ALBEDO = shine_color.rgb;

	ALPHA = clamp(
		mask
		* shine_color.a
		* shine_strength,
		0.0,
		1.0
	);
}

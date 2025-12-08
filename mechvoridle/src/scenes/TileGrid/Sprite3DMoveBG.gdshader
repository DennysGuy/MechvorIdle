shader_type spatial;
render_mode unshaded; // optional, remove if you want lighting

uniform sampler2D texture_albedo : source_color;

uniform vec2 direction = vec2(1.0, 0.0);
uniform float speed_scale = 0.01;

void fragment() {
    vec2 move = direction * TIME * speed_scale;

    vec4 tex = texture(texture_albedo, UV + move);

    ALBEDO = tex.rgb;
    ALPHA = tex.a;
}

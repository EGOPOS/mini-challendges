shader_type canvas_item;

uniform sampler2D alpha_mask;
uniform vec2 uv_scale;

void fragment() {
	vec4 multiplier = texture(alpha_mask, UV * uv_scale);
	COLOR *= multiplier;
}

shader_type canvas_item;

uniform vec4 my_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float alpha : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = my_color * alpha;
	COLOR.w = texture(TEXTURE, UV).w;
}

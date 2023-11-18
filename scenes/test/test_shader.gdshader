shader_type spatial;

uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;

uniform sampler2D height_map;
uniform vec2 tiling;
uniform float height_mul;
uniform float cold_mul;

void vertex()
{
	VERTEX.y = texture(height_map, UV * tiling).r * height_mul;
}
void fragment()
{
	float cold_mul_clamped = clamp(cold_mul, 0, 1.0);
	float height = texture(height_map, UV * tiling + (0.5 - sin(TIME * 2.0 + (UV.x + UV.y) * 10.0) * 0.05) * 0.2).r;
	vec3 red_black = mix(color2, color3, clamp(height * 1.4, 0, 1.0));
	ALBEDO = mix(color1,red_black, clamp(height * 2.0, 0, 1.0));
}

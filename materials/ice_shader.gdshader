shader_type spatial;

uniform sampler2D roughness_map;
uniform sampler2D thickness_map;
uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec2 tiling = vec2(1,1);
void fragment()
{
	float thickness = texture(thickness_map, UV * tiling).r;
	float roughness = texture(roughness_map, UV * tiling).r;
	ALBEDO = mix(mix(color1, color2, thickness), color3, roughness);
	ROUGHNESS = clamp(roughness, 0.3, 1.0);
	SPECULAR = clamp(roughness, 0, 0.5);
}

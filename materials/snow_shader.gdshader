shader_type spatial;

uniform sampler2D reflection_map;//its a snowflakes map
uniform sampler2D snowflake_normal_map;
uniform sampler2D height_map;//its a normal_map
uniform vec2 tiling = vec2(1,1);
void fragment()
{
	ALBEDO = vec3(1,1,1);
	METALLIC = 0.0;
	SPECULAR = 1.0;
	float snowflake_map = texture(reflection_map, UV * tiling * 5.0).r;
	vec3 snowflake_normal = texture(snowflake_normal_map, UV * tiling).rgb;
	float roughness = dot(VIEW, snowflake_normal * snowflake_map);
	ROUGHNESS = 1.0 - roughness;
	vec3 normal = texture(height_map, UV * tiling).rgb;
	NORMAL_MAP = normal;
	
}

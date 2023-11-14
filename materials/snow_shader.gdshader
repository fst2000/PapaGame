shader_type spatial;

uniform sampler2D height_map;

void fragment()
{
	ALBEDO = vec3(1,1,1);
	METALLIC = 0.0;
	SPECULAR = dot(NORMAL, VIEW);
	vec3 normal = texture(height_map, UV).rgb;
	NORMAL = normal * 0.2;
}

shader_type spatial;
render_mode diffuse_burley;

uniform sampler2D glass_map;
uniform vec2 glass_tiling = vec2(1,1);
uniform sampler2D light_map;
uniform vec2 light_tiling = vec2(1,1);
uniform sampler2D window_texture;
uniform vec2 tex_tiling = vec2(1,1);

void fragment()
{
	float glass_value = texture(glass_map, UV * glass_tiling).r;
	vec3 light = texture(light_map, UV * light_tiling).rgb;
	ALBEDO = texture(window_texture, UV * tex_tiling).rgb;
	if(glass_value < 0.5)
	{
		SPECULAR = 1.0;
		ROUGHNESS = 0.2;
	}
	else
	{
		SPECULAR = 0.0;
		ROUGHNESS = 1.0;
	}
	EMISSION = light;
}

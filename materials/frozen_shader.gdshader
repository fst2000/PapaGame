shader_type spatial;

uniform sampler2D froze_texture;
uniform sampler2D froze_normal;
uniform vec2 tiling = vec2(1,1);
uniform vec3 color;
uniform float metallic;
uniform float specular;
uniform float roughness;
uniform float frozeness;

void fragment()
{
	vec3 froze_col = texture(froze_texture, UV * tiling).rgb;
	float froze_value = froze_col.b;
	if(froze_value <= frozeness)
	{
		ALBEDO = mix(color, froze_col, 0.4);
		ROUGHNESS = 0.1;
		NORMAL_MAP = texture(froze_normal, UV * tiling).rgb;
	}
	else
	{
		ALBEDO = color;
		METALLIC = metallic;
		SPECULAR = specular;
		ROUGHNESS = roughness;
	}
}

shader_type spatial;

uniform sampler2D depth_texture : source_color, hint_depth_texture;
uniform sampler2D screen_texture : source_color, hint_screen_texture;

uniform sampler2D normalMap;
uniform sampler2D heightMap;
uniform sampler2D floorNormalMap;
uniform sampler2D floorHeightMap;
uniform sampler2D foam_noise;

uniform vec3 color;
uniform vec3 foam_color;
uniform vec2 tiling;
uniform vec2 direction;
uniform float waveHeightMul;
uniform float floorHeightMul;
uniform float speed;
uniform float waterClarity;
uniform float minClarity;
uniform float shore_foam_mul;
uniform float wave_foam_mul;
void vertex()
{
	float waveHeight = texture(heightMap, UV * tiling + direction * TIME * speed).r * waveHeightMul; 
	float floorHeight = texture(floorHeightMap, UV * tiling).r * floorHeightMul;
	VERTEX.y += mix(waveHeight, floorHeight, 0.5);
}

void fragment()
{
	float waveHeight = texture(heightMap, UV * tiling + direction * TIME * speed).r;
	vec3 waveNormal = texture(normalMap, UV * tiling + direction * TIME * speed).rgb;
	float floorHeight = texture(floorHeightMap, UV * tiling).r;
	vec3 floorNormal = texture(floorNormalMap, UV * tiling).rgb;
	float waterHeight = waveHeight + floorHeight;
	vec3 waterNormal = mix(waveNormal, floorNormal, 0.5);
	SPECULAR = 0.5;
	METALLIC = 0.5;
	ROUGHNESS = 0.1;
	NORMAL_MAP = waterNormal;
	float depth = texture(depth_texture, SCREEN_UV).x;
  	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;
	vec3 vertex_world = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec4 world = INV_VIEW_MATRIX * INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
  	vec3 world_position = world.xyz / world.w;
	float water_depth = length(vertex_world - world_position);
	float alpha = clamp(pow(water_depth * 0.1, waterClarity), minClarity ,1.0);
	float foam = texture(foam_noise, UV * tiling).r;
	if((water_depth >= shore_foam_mul * foam) && ((floorHeight * 0.5) * waveHeight < (1.0 - wave_foam_mul) * foam))
	{
		ALPHA = alpha;
		ALBEDO = color;
	}
	else
	{
		ALBEDO = foam_color;
		METALLIC = 0.0;
	}
}

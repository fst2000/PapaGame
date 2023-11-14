shader_type spatial;

uniform sampler2D heightMap;
uniform vec3 color;
uniform vec2 tiling;
uniform vec2 direction;
uniform float waveHeight;
uniform float speed;

void vertex()
{
	VERTEX.y += texture(heightMap, UV * tiling + (direction * TIME * speed)).r * waveHeight;
}

void fragment()
{
	vec3 heightMapRGB = texture(heightMap, UV * tiling + direction * TIME * speed).rgb;
	SPECULAR = 1.0;
	ROUGHNESS = 0.0;
	NORMAL_MAP = heightMapRGB;
	ALBEDO = color * heightMapRGB.r;
}

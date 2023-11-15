shader_type spatial;

uniform sampler2D normalMap;
uniform sampler2D heightMap;
uniform sampler2D floorNormalMap;
uniform sampler2D floorHeightMap;
uniform sampler2D floorTexture;

uniform vec3 color;
uniform vec2 tiling;
uniform vec2 direction;
uniform float waveHeightMul;
uniform float floorHeightMul;
uniform float speed;
uniform float waterClarity;

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
	vec2 floorUV = mix(-waterNormal.xz, vec3(UV.x, -1.0, UV.y).xz, 0.8);
	vec3 floorRGB = texture(floorTexture, floorUV * tiling).rgb;
	SPECULAR = 1.0;
	METALLIC = 0.0;
	ROUGHNESS = 0.0;
	NORMAL_MAP = waterNormal;
	ALBEDO = mix(color * waveHeight, floorRGB, clamp(waterClarity / waterHeight, 0, 1));
}

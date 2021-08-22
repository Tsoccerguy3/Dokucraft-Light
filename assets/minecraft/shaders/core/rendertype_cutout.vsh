#version 150

#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;
uniform sampler2D Sampler0;
uniform float GameTime;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;
out vec4 glpos;

void main() {
    vec3 position = Position + ChunkOffset;
    float animation = GameTime * 4000.0;

    float xs = 0.0;
    float ys = 0.0;
    float zs = 0.0;
    if (texture(Sampler0, UV0).a * 255 == 1.0 || texture(Sampler0, UV0).a * 255 == 253.0 ) {
        xs = sin(position.x + position.y + animation) * -1.0;
        zs = cos(position.z + position.y + animation) * -1.0;

    } else if (texture(Sampler0, UV0).a * 255 == 2.0) {
        xs = sin(position.x + position.y + animation) * -2.0;
        zs = cos(position.z + position.y + animation) * -2.0;

    } else if (texture(Sampler0, UV0).a * 255 == 3.0) {
        xs = sin(position.x + position.y + animation) * -1.0;
        zs = cos(position.z + position.y + animation) * -1.0;
        ys = sin(position.y + (animation / 1.5)) / 9.0;
    }

    gl_Position = ProjMat * ModelViewMat * (vec4(position, 1.0) + vec4(xs / 32.0, ys, zs / 32.0, 0.0));

    vertexDistance = length((ModelViewMat * vec4(Position + ChunkOffset, 1.0)).xyz);
    vertexColor = Color * minecraft_sample_lightmap(Sampler2, UV2);
    texCoord0 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
    glpos = gl_Position;
}

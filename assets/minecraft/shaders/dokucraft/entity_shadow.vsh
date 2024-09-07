#version 330

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 glpos;

void main() {
  gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
  glpos = gl_Position;

  vertexDistance = fog_distance(Position, FogShape);
  vertexColor = Color;
  texCoord0 = UV0;
}

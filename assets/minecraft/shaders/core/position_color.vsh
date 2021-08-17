#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;
out float isHorizon;

#define HORIZONDIST 128

//fix for float ==
bool aproxEqual(float a, float b)
{
	return (a < b+0.00001 && a > b-0.00001);
}

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexColor = Color;
	
    isHorizon = 0.0;

    if ((ModelViewMat * vec4(Position, 1.0)).z > -HORIZONDIST - 10.0) {
        isHorizon = 1.0;
    }
	
	//is tooltip?
	if (Color.g == 0.0)
	{
		//is background?
		if(aproxEqual(Color.a,0.94118) && aproxEqual(Color.r, 0.06275) && aproxEqual(Color.b, 0.06275))
		{
			//12 ~ 17
			if(gl_VertexID > 7 && gl_VertexID < 12)
			{
				vertexColor.rgba = vec4(vec3(22, 18, 16)/255.0,0.9);
			}
			else
			{
				vertexColor.a = 0.9;
			}
		}
		
		//is outline?
		else if(aproxEqual(Color.a,0.31373))
		{
			//is outline light?
			if(aproxEqual(Color.b,1.0) && aproxEqual(Color.r,0.31373))
			{
				vertexColor.rgb = vec3(0.996, 0.996, 0.992);
				vertexColor.a = 0.6;
			}
			
			//is outline dark?
			else if(aproxEqual(Color.b,0.49804) && aproxEqual(Color.r,0.15686))
			{
				vertexColor.rgb = vec3(0.71, 0.71, 0.69);
				vertexColor.a = 0.3;
			}
		}
	}
}

Shader "Hidden/Pallete"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _color1 ("Pallete color 1",Color) = (1,1,1,1)
        _color2 ("Pallete color 2",Color) = (1,1,1,1)
        _color3 ("Pallete color 3",Color) = (1,1,1,1)
        _color4 ("Pallete color 4",Color) = (1,1,1,1)
        _color5 ("Pallete color 5",Color) = (1,1,1,1)
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass{

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            uniform sampler2D _MainTex;
            float4 _color1;
            float4 _color2;
            float4 _color3;
            float4 _color4;
            float4 _color5;

            struct vertexInput{
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD0;
            };

            struct vertexOutput{
                float4 pos : SV_POSITION;
                float4 tex : TEXCOORD0;
                float4 pallete[5] : TEXCOORD1;
            };

            vertexOutput vert(vertexInput input){
                vertexOutput output;
                output.tex = input.texcoord;
                output.pos = UnityObjectToClipPos(input.vertex);
                output.pallete[0] = _color1;
                output.pallete[1] = _color2;
                output.pallete[2] = _color3;
                output.pallete[3] = _color4;
                output.pallete[4] = _color5;
                return output;
            }

            float4 frag(vertexOutput input) : COLOR{
                float4 texColor = tex2D(_MainTex,input.tex.xy);
                float4 newColor = input.pallete[0];
                float colorDistance = distance(texColor,newColor);
                for(int i = 1;i<5;i++){
                    float d = distance(texColor,input.pallete[i]);
                    if(d < colorDistance){
                        colorDistance = d;
                        newColor = input.pallete[i];
                    }
                }
                return newColor;
            }
            
            ENDCG
        }
    }
}

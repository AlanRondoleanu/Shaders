Shader "Cg shader with all built-in vertex input parameters" {
    SubShader{
       Pass {
          CGPROGRAM

          #pragma vertex vert  
          #pragma fragment frag 

          struct vertexInput {
             float4 vertex : POSITION;
             float4 tangent : TANGENT;
             float3 normal : NORMAL;
             float4 texcoord : TEXCOORD0;
             float4 texcoord1 : TEXCOORD1;
             float4 texcoord2 : TEXCOORD2;
             float4 texcoord3 : TEXCOORD3;
             fixed4 color : COLOR;
          };
          struct vertexOutput {
             float4 pos : SV_POSITION;
             float4 col : TEXCOORD0;
          };

          vertexOutput vert(vertexInput input)
          {
             vertexOutput output;

             output.pos = UnityObjectToClipPos(input.vertex);
             output.col = input.texcoord; // set the output color

             // other possibilities to play with:

             // output.col = input.vertex;
             // output.col = input.tangent;
             // output.col = float4(input.normal, 1.0);
             // output.col = input.texcoord;
             // output.col = input.texcoord1;
             // output.col = input.texcoord2;
             // output.col = input.texcoord3;
             // output.col = input.color;

             // the float 4 has floats that go over 1.0 which is the largest possible float for a color i.e 0.0f - 1.0f
             //output.col = input.texcoord - float4(1.5, 2.3, 1.1, 0.0);

             // the color of textcoord z is black, so inputting black for all the output colors will turn everything black
             //output.col = input.texcoord.zzzz;

             // Cant divide by 0
             //output.col = input.texcoord / tan(0.0);

             //output.col = dot(input.normal, input.tangent.xyz) * input.texcoord;

             return output;
          }

          float4 frag(vertexOutput input) : COLOR
          {
             return input.col;
          }

          ENDCG
       }
    }
}
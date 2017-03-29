﻿
Shader "Custom/Affine UV fix Cg" {
 
    Properties {
 
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
 
    SubShader {
     
        pass{
            CGPROGRAM
 
            uniform sampler2D _MainTex;
         
            #pragma vertex vert          
            #pragma fragment frag
         
 
        struct vertexInput {
            float4 vertex : POSITION;        
            float4 texcoord  : TEXCOORD0;
            float4 texcoord1  : TEXCOORD1;      
        };
 
        struct vertexOutput {
            float4 pos : SV_POSITION;
            float2 uv  : TEXCOORD0;
            float2 uv2  : TEXCOORD1;        
        };
 
        vertexOutput vert(vertexInput input)
        {
            vertexOutput output;
            output.pos = mul(UNITY_MATRIX_MVP,  input.vertex);
         
            output.uv = input.texcoord;
            output.uv2  = input.texcoord1 ;
         
            return output;
        }
 
        float4 frag(vertexOutput input) : COLOR
        {    
            return  tex2D(_MainTex, float2(input.uv)/float2(input.uv2 ));    
        }
     
         ENDCG // here ends the part in Cg
    }
    }
 
}
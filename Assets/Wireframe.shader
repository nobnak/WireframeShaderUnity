Shader "Custom/Wireframe" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Gain ("Gain", Float) = 1.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" "LightMode"="Vertex" }
		LOD 200
		
		Pass {
			CGPROGRAM
			#pragma target 3.0
			#pragma glsl
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float _Gain;
			
			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};
			
			struct vs2ps {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 bary;
			};
			
			vs2ps vert(appdata IN) {
				vs2ps o;
				o.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				o.bary = IN.tangent.xyz;
				o.uv = IN.uv;
				return o;
			}
			
			float4 frag(vs2ps IN) : COLOR {
				float d = fwidth(IN.bary);
				float3 a3 = smoothstep(float3(0.0), _Gain * d, IN.bary);
				float t = min(min(a3.x, a3.y), a3.z);
				
				float4 c = tex2D(_MainTex, IN.uv);
				
				return t * c;
			}

			ENDCG
		}
	} 
	FallBack "Diffuse"
}

Shader "Custom/Wireframe" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Wireframe_Gain ("Gain", Float) = 1.5
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
			#include "Packages/jp.nobnak.wireframe/ShaderLIbrary/Wireframe.cginc"

			sampler2D _MainTex;
			
			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};
			
			struct vs2ps {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 bary : TEXCOORD1;
			};
			
			vs2ps vert(appdata IN) {
				vs2ps o;
				o.vertex = UnityObjectToClipPos(IN.vertex);
				o.bary = IN.tangent.xyz;
				o.uv = IN.uv;
				return o;
			}
			
			float4 frag(vs2ps IN) : COLOR {
				float t = wireframe(IN.bary);
				
				float4 c = tex2D(_MainTex, IN.uv);
				
				return t * c;
			}

			ENDCG
		}
	} 
	FallBack "Diffuse"
}

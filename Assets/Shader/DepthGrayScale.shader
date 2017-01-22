Shader "Hidden/DepthGrayscale" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}		
		_depthThreshold("Depth for GreyScale", Float) = 0
	}
	SubShader{
		Tags{ "RenderType" = "Opaque" }

		Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"

		sampler2D _CameraDepthTexture;		
		sampler2D _MainTex;
		float _depthThreshold;
		
		struct appdata {
			float4 position : POSITION;
			float2 uv: TEXCOORD0;
		};

		struct v2f {
			float4 pos : SV_POSITION;
			float2 uv:TEXCOORD0;
		};

		//Vertex Shader
		v2f vert(appdata v) {
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.position);
			#if defined (UNITY_UV_STARTS_AT_TOP)
			o.uv = float2(v.uv.x, 1 - v.uv.y);
			#else
			o.uv = v.uv;
			#endif	
			return o;
		}

		//Fragment Shader
		float4 frag(v2f_img i) : COLOR{
			float depthValue = Linear01Depth(tex2D(_CameraDepthTexture, UNITY_PROJ_COORD(i.uv)).x);
			
			#if defined (UNITY_UV_STARTS_AT_TOP)
			i.uv.y = 1 - i.uv.y;
			#endif

			float4 c = tex2D(_MainTex, i.uv);
			//GreyScale
			if (depthValue >= _depthThreshold)
			{				
				float grey = c.r*.2989 + c.g*.5870 + c.b*.1140;				
				c.rgb = float3(grey, grey, grey);
			}			
			return c;			
		}
			ENDCG
		}
	}
	FallBack "Diffuse"
}

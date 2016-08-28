Shader "Custom/Gray"
{
	Properties
	{
		_MainTex ("Base (RGB) Mask (A)", 2D) = "white" {}
		_Color ("Tint Color", Color) = (1,1,1,1)
	}
	
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		LOD 200
		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Offset -1, -1
		ColorMask RGB
		AlphaTest Greater .01
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMaterial AmbientAndDiffuse
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _Color;
			
			struct appdata_t
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag (v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.texcoord) * i.color;
				float v = col.r * 0.8 + col.g * 0.8 + col.b *0.8;
				return half4( v, v, v, col.a );
			}
			ENDCG
		}
	}
}

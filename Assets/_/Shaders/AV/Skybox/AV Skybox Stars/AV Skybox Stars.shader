// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AV/Skybox/Stars"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 2
		[Enum(Night,0,Day,1,Both,2)]_Cycle("Cycle", Float) = 2
		[Enum(Pre,0,Post,1)]_Normalize("Normalize", Float) = 0
		[HDR]_Color("Color", Color) = (0.5,0.75,1,0)
		_StarSize("Star Size", Range( 50 , 350)) = 200
		_StarSpeed("Star Speed", Range( 0 , 1)) = 0.1
		_Parallax("Parallax", Range( -0.05 , 0.05)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" }
		Cull [_CullMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float3 viewDir;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform int _CullMode;
		uniform float _Parallax;
		uniform float _Normalize;
		uniform float _StarSize;
		uniform float _StarSpeed;
		uniform float4 _Color;
		uniform float _Cycle;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float3 normalizeResult434 = normalize( i.viewDir );
			float3 temp_output_475_0 = ( normalizeResult434 + ( _WorldSpaceCameraPos * _Parallax ) );
			float3 normalizeResult482 = normalize( temp_output_475_0 );
			float3 lerpResult481 = lerp( temp_output_475_0 , normalizeResult482 , _Normalize);
			float mulTime470 = _Time.y * _StarSpeed;
			float simplePerlin3D471 = snoise( ( ( lerpResult481 * _StarSize ) + mulTime470 ) );
			float smoothstepResult472 = smoothstep( 0.65 , 0.75 , simplePerlin3D471);
			float simplePerlin3D435 = snoise( ( lerpResult481 * 2 ) );
			simplePerlin3D435 = simplePerlin3D435*0.5 + 0.5;
			float simplePerlin3D413 = snoise( ( _Time.x + lerpResult481 ) );
			float viewdirnoise424 = ( simplePerlin3D413 * 0.5 );
			float temp_output_382_0 = ( smoothstepResult472 * saturate( ( simplePerlin3D435 + viewdirnoise424 ) ) );
			float _176_g2 = temp_output_382_0;
			float3 temp_cast_0 = (_176_g2).xxx;
			float simplePerlin3D357 = snoise( lerpResult481 );
			simplePerlin3D357 = simplePerlin3D357*0.5 + 0.5;
			float3 temp_cast_1 = (saturate( ( simplePerlin3D357 + viewdirnoise424 ) )).xxx;
			float3 temp_output_448_0 = max( temp_cast_1 , (_Color).rgb );
			float3 _1171_g2 = temp_output_448_0;
			float ENUM173_g2 = _Cycle;
			float3 lerpResult132_g2 = lerp( temp_cast_0 , _1171_g2 , saturate( ENUM173_g2 ));
			float3 temp_cast_2 = (temp_output_382_0).xxx;
			float3 temp_cast_3 = (saturate( ( simplePerlin3D357 + viewdirnoise424 ) )).xxx;
			float3 lerpResult365 = lerp( temp_cast_2 , temp_output_448_0 , saturate( ( sin( _Time.x ) * 2.0 ) ));
			float3 _2170_g2 = lerpResult365;
			float temp_output_142_0_g2 = ( ENUM173_g2 - 1.0 );
			float3 lerpResult131_g2 = lerp( lerpResult132_g2 , _2170_g2 , saturate( temp_output_142_0_g2 ));
			half3 THREE27_g2 = lerpResult131_g2;
			c.rgb = saturate( THREE27_g2 );
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
}
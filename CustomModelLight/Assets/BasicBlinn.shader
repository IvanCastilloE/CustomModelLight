Shader "Custom/BasicBlinn"
{
	Properties
	{
		_Albedo("Albedo", Color) = (1, 1, 1, 1)
	}

		SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
		}

		CGPROGRAM
			#pragma surface surf BasicBlinn

			half4 LightingBasicBlinn(SurfaceOutput s,
			half3 lightDir,half3 viewDir, half atten)
			{
				half3 h = normalize(lightDir + viewDir);
				half diff = max(0, dot(s.Normal, lightDir));
				float nh = max(0, dot(s.Normal, h));
				float spec = pow(nh, 48.0);
				half4 c;
				c.rgb = ((s.Albedo*_LightColor0.rgb)*diff*(spec*_LightColor0.rgb))*atten;
				c.a = s.Alpha;
				return c;

				/*half NdotL = dot(s.Normal, lightDir);
				half4 c;
				c.rgb = s.Albedo*_LightColor0.rgb*(NdotL*atten);
				c.a = s.Alpha;
				return c;*/
			}
			
			float4 _Albedo;
			struct Input 
			{
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o) 
			{
				o.Albedo = _Albedo.rgb;
			}
		ENDCG
	}
}

Shader "Unlit/First Test"
{

    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100


            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #define TAU 6.283185307179586

                // make fog work
                #pragma multi_compile_fog

                #include "UnityCG.cginc"

                float4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normals : NORMAL;
            };

            struct v2f
            {
                //float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.normal = UnityObjectToWorldNormal(v.normals);
                o.normal = v.normals;
                o.uv = v.uv;
                return o;
            }
            float inverseLerp(float a, float b, float v) {
                return(v - a) / (b - a);
            }

            fixed4 frag(v2f i) : SV_Target
            {

                //float t = i.uv.x;
                //float t = abs(frac(i.uv.x * 5) * 2 - 1);
                float xOffset = cos (i.uv.y * TAU * 8 * 0.2f);
                float t = cos((i.uv.x + xOffset + _Time.y) * TAU * 5) * 0.5 + 0.5;
                return  t;
            }
            ENDCG
        }
    }
}

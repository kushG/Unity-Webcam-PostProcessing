using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class GreyScale : MonoBehaviour {

    private Material mat;
    [Range(0, 1)]
    public float depthThreshold;

    void Awake()
    {
        mat = new Material(Shader.Find("Hidden/DepthGrayscale"));
        
    }

    private void Start()
    {
        //Camera.main.depthTextureMode = DepthTextureMode.Depth;
    }
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        mat.SetFloat("_depthThreshold", depthThreshold);
        Graphics.Blit(source, destination, mat);     
    }
}

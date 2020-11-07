using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof (Camera))]
public class Pallete : MonoBehaviour
{   
    public Material postProcessingMaterial;
    // Start is called before the first frame update
    void Start()
    {
        if (postProcessingMaterial == null ||
        postProcessingMaterial.shader == null ||
        !postProcessingMaterial.shader.isSupported){
            enabled = false;
        }
        else{
            enabled = true;
        }
        
    }
    void OnRenderImage(RenderTexture source, RenderTexture destination){

        Graphics.Blit(source, destination, postProcessingMaterial);

    }

}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AI_Enemigo : MonoBehaviour
{
    public Transform Objetivo;
    public float Velocidad;
    public NavMeshAgent IA;

    public Animation Anim;
    public string NombreAnimacionCaminar;
    public string NombreAnimacionAtacar;

    public float Daño;

    void Update()
    {
        IA.speed = Velocidad;
        IA.SetDestination(Objetivo.position);


        if(IA.velocity == Vector3.zero)
        {
          Anim.CrossFade(NombreAnimacionAtacar);
        }
        else
        {
          Anim.CrossFade(NombreAnimacionCaminar);
        }
    }

    public void Ataque()
    {
        Objetivo.GetComponent<Codigo_Salud>().RecibirDaño(Daño);
    }
}

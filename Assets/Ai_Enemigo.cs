
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

// Este script controla el movimiento, las animaciones y el ataque del enemigo.
public class AI_Enemigo : MonoBehaviour
{
    // Referencia al jugador que el enemigo debe perseguir.
    public Transform Objetivo;

    // Velocidad de movimiento del enemigo.
    public float Velocidad;

    // Componente que permite al enemigo moverse por el escenario.
    public NavMeshAgent IA;

    // Animaciones del enemigo.
    public Animation Anim;
    public string NombreAnimacionCaminar;
    public string NombreAnimacionAtacar;

    // Cantidad de daño que puede causar al jugador.
    public float Daño;

    void Update()
    {
        // Actualiza la velocidad del enemigo.
        IA.speed = Velocidad;

        // Hace que el enemigo se dirija hacia la posición del jugador.
        IA.SetDestination(Objetivo.position);

        // Comprueba si el enemigo está detenido o en movimiento.
        if(IA.velocity == Vector3.zero)
        {
            // Reproduce la animación de ataque cuando está detenido.
            Anim.CrossFade(NombreAnimacionAtacar);
        }
        else
        {
            // Reproduce la animación de caminar mientras se mueve.
            Anim.CrossFade(NombreAnimacionCaminar);
        }
    }

    // Esta función se encarga de aplicar daño al jugador.
    public void Ataque()
    {
        // Busca el sistema de salud y le resta la cantidad de daño.
        Objetivo.GetComponent<Codigo_Salud>().RecibirDaño(Daño);
    }
}

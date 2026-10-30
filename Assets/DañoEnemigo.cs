
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Este script permite ejecutar la acción de ataque del enemigo.
public class DañoEnemigo : MonoBehaviour
{
    // Referencia al script que controla la inteligencia artificial del enemigo.
    public AI_Enemigo Enemigo;

    // Esta función activa el ataque del enemigo.
    public void Daño()
    {
        // Llama al método Ataque del script AI_Enemigo.
        Enemigo.Ataque();
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DañoEnemigo : MonoBehaviour
{

    public AI_Enemigo Enemigo;

    public void Daño()
    {
        Enemigo.Ataque();
    }
    

}

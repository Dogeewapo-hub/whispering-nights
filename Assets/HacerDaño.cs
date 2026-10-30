using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class HacerDaño : MonoBehaviour
{
    // Cantidad de daño que se aplicará al jugador.
    public float CantidadDaño;

    // Detecta cuando otro objeto entra en la zona de colisión.
    private void OnTriggerEnter(Collider other)
    {
        // Verifica que el objeto sea el jugador y tenga el sistema de salud.
        if (other.CompareTag("Player") && other.GetComponent<Codigo_Salud>())
        {
            // Resta la cantidad de daño a la vida del jugador.
            other.GetComponent<Codigo_Salud>().RecibirDaño(CantidadDaño);
        }
    }
}

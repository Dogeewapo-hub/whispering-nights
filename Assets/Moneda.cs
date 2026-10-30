
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Este script controla las monedas que aparecen en el juego.
public class Coin : MonoBehaviour
{
    // Guarda la cantidad total de monedas en el escenario.
    public static int coinCount = 0;

    private void Start()
    {
        // Suma una moneda al contador cuando aparece en el juego.
        coinCount++;

        // Muestra en la consola la cantidad de monedas.
        Debug.Log("Empieza el juego con " + coinCount + " monedas");
    }

    private void OnTriggerEnter(Collider otherCollider)
    {
        // Verifica que solamente el jugador pueda recoger monedas.
        if (otherCollider.CompareTag("Player"))
        {
            // Resta una moneda del contador.
            coinCount--;

            // Muestra cuántas monedas quedan por recoger.
            Debug.Log("Recogida de moneda. Quedan " + coinCount + " monedas");

            // Elimina la moneda cuando el jugador la recoge.
            Destroy(gameObject);

            // Comprueba si el jugador recogió todas las monedas.
            if (coinCount == 0)
            {
                // Muestra un mensaje cuando ya no quedan monedas.
                Debug.Log("El juego ha terminado");
            }
        }
    }
}

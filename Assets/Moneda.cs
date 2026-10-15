using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coin : MonoBehaviour
{
    public static int coinCount = 0;

    private void Start()
    {
        coinCount++;
        Debug.Log("Empieza el juego con " + coinCount + " monedas");
    }

    private void OnTriggerEnter(Collider otherCollider)
    {
        // Condicional para que la moneda sea recogida solo por el jugador
        if (otherCollider.CompareTag("Player"))
        {
            coinCount--;
            Debug.Log("Recogida de moneda. Quedan " + coinCount + " monedas");

            // Destruir la moneda una vez recogida
            Destroy(gameObject);

            // Verificar si ya no hay monedas
            if (coinCount == 0)
            {
                Debug.Log("El juego ha terminado");
            }
        }
    }
}


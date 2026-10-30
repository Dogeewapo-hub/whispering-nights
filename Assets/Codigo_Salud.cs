
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

// Este script controla la vida del jugador y su interfaz.
public class Codigo_Salud : MonoBehaviour
{
    // Vida actual y vida máxima del personaje.
    public float Salud = 100;
    public float SaludMaxima = 100;

    [Header("Interfaz")]
    // Elementos visuales que muestran la salud del jugador.
    public Image BarraSalud;
    public Text TextoSalud;
    public CanvasGroup OjosRojos;

    [Header("Muerto")]
    // Objeto que aparece cuando el jugador pierde toda su vida.
    public GameObject Muerto;

    void Update()
    {
        // Hace que el efecto rojo desaparezca poco a poco.
        if (OjosRojos.alpha > 0)
        {
            OjosRojos.alpha -= Time.deltaTime;
        }

        // Actualiza la barra y el texto de salud.
        ActualizarInterfaz();
    }

    public void RecibirDaño(float daño)
    {
        // Resta la cantidad de daño recibido a la vida.
        Salud -= daño;

        // Activa el efecto rojo cuando el jugador recibe daño.
        OjosRojos.alpha = 1;

        // Comprueba si el jugador se quedó sin vida.
        if (Salud <= 0)
        {
            // Muestra la pantalla de muerte.
            Instantiate(Muerto);

            // Elimina al personaje de la escena.
            Destroy(gameObject);
        }
    }

    void ActualizarInterfaz()
    {
        // Actualiza el porcentaje de la barra de vida.
        BarraSalud.fillAmount = Salud / SaludMaxima;

        // Muestra la cantidad de vida sin decimales.
        TextoSalud.text = "+ " + Salud.ToString("f0");
    }
}



import java.util.*;
import java.io.*;

public class utilArray
{
	/* Prototipo: void imprimirArray (Object [] array)
	 * Breve comentario: Imprimir un array
	 * Precondiciones: Ninguna
	 * Entradas: Un array de Object
	 * Salidas: Ninguna
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Ninguna
	 * 
	 * Resguardo: public static void imprimirArray (Object [] array)
	 * {
	 * 		System.out.println("Llamada al metodo imprimirArray");
	 * }
	 */
	public static void imprimirArray (Object [] array)
	{
		for (int i = 0; i < array.length; i++)
		{
			System.out.println(array [i]);
		}
	}
	//Fin_imprimirArray
	
	/* Prototipo: int [] arrayPar (int [] array)
	 * Breve comentario: Dado un array cargado aleatoriamente, generar a partir de él otro
	 * array que contenga los elementos pares que se encuentran en el primero.
	 * Precondiciones: Ninguna
	 * Entradas: Un array de enteros
	 * Salidas: Un array de enteros
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Un array de enteros con los numeros pares del primero.
	 * 
	 * Resguardo: public static int [] arrayPar (int [] array)
		{
			System.out.println("Llamada al metodo arrayPar");
			System.out.println("Variables: "+array);
			return array;
		}
	 */
	public static int [] arrayPar (int [] array)
	{
		int arraySize = (int) Math.round((double) array.length / 2.0); //Dividir el tama�o del array original entre dos para crear el nuevo. Hay que redondearlo para evitar fallos de tama�o en el array. Math.round devuelve un double.
		
		int [] resultado = new int [arraySize]; //Crear nuevo array con el tama�o antes obtenido
		//int j = 0;
		
		for (int i = 0, j = 0; i < array.length; i = i+2, j++)
		{
				resultado [j] = array [i];
				//j++;
		}
		return resultado;
	}
	
	/* Prototipo: int [] arrayAleatorio ()
	 * Breve comentario: Crear un array de 20 elementos, con n�meros aleatorios comprendidos entre 100 y 300, de forma que no se repita ning�n elemento.
	 * Precondiciones: Ninguna
	 * Entradas: Ninguna
	 * Salidas: Un array de enteros
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Un array con 20 enteros aleatorios entre 100 y 300.
	 * 
	 * Resguardo: public static int [] arrayAleatorio ()
		{
			int [] resultado = new int [20];
			
			System.out.println("Llamada al metodo arrayAleatorio");
			
			return resultado;
		}
	 */
	public static int [] arrayAleatorio ()
	{
		Random aleatorio = new Random ();
		int numeroAleatorio = 0;
		int [] resultado = new int [20];
		
		for (int i = 0; i < resultado.length; i++)
		{
			numeroAleatorio = aleatorio.nextInt (200) + 100;
			
			if (i == 0)
			{			
				resultado [i] = numeroAleatorio;
			}
			
			else
			{
				if (numeroAleatorio != resultado [i - 1])
				{
					resultado [i] = numeroAleatorio;
				}
				
				else
				{
					i--;
				}
			}
		}
		
		return resultado;
	}
	
	/* Prototipo:
	 * Breve comentario: Dado un array de n�meros enteros, 
	 * generar a partir de �l un nuevo array donde se almacenen los elementos del primero que sean primos.
	 * Precondiciones:
	 * Entradas:
	 * Salidas:
	 * Entradas/Salidas:
	 * Postcondiciones:
	 * 
	 * Resguardo:
	 */
	
	//Se hace f�cil con un arrayList. Preguntar si podemos usarlos.
	
	
	/* Prototipo: int [] alrrayVes (int [] array)
	 * Breve comentario: A partir de un array generar otro con los elementos al rev�s.
	 * Precondiciones: Ninguna
	 * Entradas: Un array de enteros
	 * Salidas: Un array de enteros
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Ninguna
	 * 
	 * Resguardo: public static int [] alrrayVes (int [] array)
		{
			int [] resultado = new int [1];
			
			System.out.println("Llamada al metodo allrayVes");
			System.out.println("Variables: "+array);
			
			return resultado; 
		}
	 */
	public static int [] alrrayVes (int [] array)
	{
		int [] resultado = new int [array.length];
		
		for (int i = array.length - 1, j = 0; i > 0; i--, j++)
		{
			resultado [j] = array [i];
		}
		
		return resultado; 
	}
	//Fin_alrrayVes
	
	/* Prototipo: int dondeEstaWaldo (int [] array, int numero)
	 * Breve comentario: Funcionalidad que reciba un array de enteros y un n�mero y devuelva la 
	 * posici�n en la que lo encuentre y -1 si el n�mero no est� en el array. En el array 
	 * no puede haber n�meros repetidos.
	 * Precondiciones: Ninguna
	 * Entradas: Un array de enteros y un n�mero
	 * Salidas: Un entero
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Un entero indicando la posici�n en la que se encuentra, -1 si el n�mero
	 * no est� en el array y -2 si hay elementos iguales.
	 * 
	 * Resguardo: public static int dondeEstaWaldo (int [] array, int numero)
		{
			int resultado = 0;
			
			System.out.println("Llamada al metodo dondeEstaWaldo");
			
			return resultado;
		}
	 */
	public static int dondeEstaWaldo (int [] array, int numero)
	{
		int resultado = 0;
		int [] arrayCopia = array;
		int j = 0;
		
		for (int i = 0; i < array.length; i++)
		{
			if (arrayCopia [j] == array [i])
			{
				i = -1;
				resultado = -2;
			}
			else if (i == array.length)
			{
				j++;
			}
		}
		
		return resultado;
	}
	//Fin_dondeEstaWaldo
	
}//fin_clase

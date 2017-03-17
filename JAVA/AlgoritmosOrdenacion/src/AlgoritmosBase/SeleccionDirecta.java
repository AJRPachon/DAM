package AlgoritmosBase;

public class SeleccionDirecta 
{
	/* Prop�sito: ordenaci�n ascendente de un array unidimensional de tama�o tam.

	 * Entradas: un array. En principio tambi�n se necesita el tama�o, pero al

	 * implementar en Java lo conocemos, por estar impl�cito al crearlo.

	 * Precondiciones: el array no debe estar vac�o.

	 * Salida: el mismo array modificado.

	 * Postcondiciones: array [0], ..., array[tam-1] est� ordenado seg�n el criterio de ordenaci�n establecido.
	 */
	
	public static int [] seleccionDirectaInt (int [] array)
	{
		int minimo = 0;
		int aux = 0;
		int i;
		int j;
		
		for (i = 0; i < array.length; i++)
		{
			minimo = i;
			
			for (j = i + 1; j < array.length; j++)
			{
				if (array [j] < array [minimo])
				{
					minimo = j;
				}
			}
			
			aux = array [i];
			array [i] = array [minimo];
			array [minimo] = aux;
			
		}
		
		return array;
	}
	
	public static void main (String [] args)
	{
		int [] array = {35, 23, 11, 5, 13};
		
		System.out.println("-----------");
		System.out.println("Sin ordenar");
		System.out.println("-----------");
		
		for (int i = 0; i < array.length; i++)
		{
			System.out.println(array [i]);
		}
		
		seleccionDirectaInt (array);
		
		System.out.println("-----------");
		System.out.println("Ya ordenado");
		System.out.println("-----------");
		
		for (int i = 0; i < array.length; i++)
		{
			System.out.println(array [i]);
		}
	}
}

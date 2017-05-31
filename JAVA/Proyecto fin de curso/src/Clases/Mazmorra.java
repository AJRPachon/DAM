package Clases;

import java.io.Serializable;
import java.util.Objects;

import Interfaces.Habitacion;

/* Propiedades:
 * 		Basicas:	Habitacion [] [] mapa		----------		Consultable/Modificable
 * 		Derivadas:
 * 		Compartidas:
 * 
 * Getters y setters:
 * 
 * Habitacion [] [] getMapa ();
 * void setMapa (Habitacion [] [] mapa);
 * 
 * Metodos a�adidos:
 * 
 * generarMazmorraAleatoria ();
 */

public class Mazmorra implements Serializable, Cloneable
{
	private static final long serialVersionUID = 5099384049691550127L;
	Habitacion [] [] mapa;
	
	//Constructores
	public Mazmorra ()
	{
		mapa = new Habitacion [][] {};
	}
	
	public Mazmorra (Mazmorra mazmorra)
	{
		this.mapa = mazmorra.mapa;
	}
	
	public Mazmorra (Habitacion [][] mapa)
	{
		this.mapa = mapa;
	}
	//Fin Constructores
	
	//Getters y setters
	public Habitacion [] [] getMapa ()
	{
		return mapa;
	}
	
	public void setMapa (Habitacion [][] mapa)
	{
		this.mapa = mapa;
	}
	//Fin Getters y setters
	
	//Metodos a�adidos
	@Override
	public boolean equals (Object objeto)
	{
		boolean resultado = false;
		
		if (objeto != null && objeto instanceof Mazmorra)
		{
			Mazmorra mazmorra = (Mazmorra) objeto;
			
			if (this.getMapa().equals(mapa))
			{
				resultado = true;
			}
		}
		
		return resultado;
	}
	
	@Override
	public int hashCode ()
	{
		return (Objects.hash (this.getMapa()));
	}
	
	
	/* Prototipo: generarMazmorraAleatoria ()
	 * Breve comentario: Metodo dedicado a la generaci�n aleatoria de la mazmorra
	 * Precondiciones: Ninguna
	 * Entradas: Ninguna
	 * Salidas: Ninguna
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Ninguna
	 * 
	 * Resguardo: public void generarMazmorraAleatoria ()
		{
			System.out.println("Llamada al metodo generarMazmorraAleatoria");
		}
	 */
	public void generarMazmorraAleatoria ()
	{
		
	}
	//Fin generarMazmorraAleatoria
	
	//Fin Metodos a�adidos
	
}

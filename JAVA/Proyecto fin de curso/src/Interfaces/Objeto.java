package Interfaces;
/* Propiedades:
 * 
 * 		Basicas: 				String nombre		-----------		Consultable / Modificable
 * 								double precio		----------- 	Consultable / Modificable
 * 		Derivadas:
 * 		Compartidas:
 * 
 * 
 * String getNombre ();
 * void setNombre (String nombre);
 * 
 * double getPrecio ();
 * void setPrecio (double precio);
 * 
 * Metodos a�adidos: Ninguno
 * 
 * Criterio de comparaci�n : precio
 */

import Exceptions.JuegoException;

public interface Objeto 
{
	String getNombre ();
	void setNombre (String nombre) throws JuegoException;
	
	double getPrecio ();
	void setPrecio (double precio) throws JuegoException;
}

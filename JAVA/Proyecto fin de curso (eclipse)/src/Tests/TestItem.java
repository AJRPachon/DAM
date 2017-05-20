package Tests;

import Clases.Item;

public class TestItem
{
	public static void main (String []args)
	{
		Item pocion = new Item ("Pocion de vida", 30, 0.0, 0.0, 0.0, "El jugador se bebe la pocion y se cura 25 de vida");
		Item casco = new Item ("Casco de hierro", 70, 0.0, 20.0, 0.0, "Un casco de hierro que aumenta la defensa en 20 puntos");
		Item pocionCopia = new Item ();
		
		//Getes, setes y toString
		System.out.println("----------------");
		System.out.println(pocion.getNombre ());
		pocion.setNombre("Pocion de Mana");
		System.out.println(pocion.getPrecio ());
		pocion.setPrecio(20);
		System.out.println(pocion.getModificadorDmg ());
		pocion.setModificadorDmg(0.0);
		System.out.println(pocion.getModificadorDef ());
		pocion.setModificadorDef(0.0);
		System.out.println(pocion.getDuracion ());
		pocion.setDuracion(0.0);
		System.out.println(pocion.getEfecto ());
		pocion.setEfecto("El jugador se bebe la pocion y se cura 25 de mana");
		System.out.println("----------------");
		System.out.println("toString despues de los Set");
		System.out.println(pocion.toString ());
		//Fin Getes, setes y toString
		
		//hashCode
		System.out.println("----------------");
		System.out.println("hashCode: ");
		System.out.println(pocion.hashCode ());
		//Fin hashCode
		
		//Equals
		System.out.println("----------------");
		System.out.println("Equals: ");
		System.out.println(pocion.equals (pocionCopia));
		System.out.println(pocion.equals (casco));
		//Fin Equals
		
		//compareTo
		System.out.println("----------------");
		System.out.println("compareTo: ");
		System.out.println(pocion.compareTo (casco));
		System.out.println(pocion.compareTo (pocionCopia));
		System.out.println(casco.compareTo (pocion));
		//Fin compareTo
	}//fin_main
}//fin_pp

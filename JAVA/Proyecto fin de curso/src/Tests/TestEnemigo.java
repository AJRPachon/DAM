package Tests;

import Clases.EnemigoIMPL;
import Clases.ItemIMPL;
import Exceptions.JuegoException;

public class TestEnemigo
{
	public static void main (String[]args)
	{
		try
		{
			ItemIMPL ataqueDefensaX = new ItemIMPL ("Ataque y Defensa X", 40, 5, 2, 0, true, "Aumenta tu ataque en 5 puntos y tu defensa en 2");
			EnemigoIMPL aseolake = new EnemigoIMPL ("Jaranator", 100, 45, 25, ataqueDefensaX, 10, 3, false);
			EnemigoIMPL aseolake2 = new EnemigoIMPL ("ElHipervinculos", 150, 60, 35, ataqueDefensaX, 20, 7, true);
			EnemigoIMPL aseolake3;
			
			//Getes, setes y toString
			System.out.println("-------------------");
			System.out.println(aseolake.getNombre());
			aseolake.setNombre ("Pepejava");
			System.out.println(aseolake.getVida());
			aseolake.setVida (1);
			System.out.println(aseolake.getDmg());
			aseolake.setDmg (0);
			System.out.println(aseolake.getDef());
			aseolake.setDef (999);
			System.out.println(aseolake.getDropDinero());
			aseolake.setDropDinero (99999);
			System.out.println(aseolake.getNivel());
			aseolake.setNivel (1);
			
			System.out.println("-------------------");
			System.out.println("toString despues de los Set");
			System.out.println(aseolake.toString());
			System.out.println("-------------------");
			//Fin Getes, setes y toString
			
			
			//hashCode
			System.out.println("hashCode:");
			System.out.println(aseolake.hashCode ());
			System.out.println("-------------------");
			//Fin hashCode
			
			//clone
			System.out.println("Clone:");
			System.out.println(aseolake3 = aseolake.clone ());
			System.out.println("-------------------");
			//Fin clone
			
			//equals
			System.out.println("Equals:");
			System.out.println(aseolake.equals(aseolake2));
			System.out.println(aseolake.equals(aseolake3));
			System.out.println("-------------------");
			//Fin equals
			
			//compareTo
			System.out.println("compareTo:");
			System.out.println(aseolake.compareTo (aseolake2));
			System.out.println(aseolake.compareTo (aseolake3));
			System.out.println(aseolake2.compareTo (aseolake));
			System.out.println("-------------------");
			//Fin compareTo
		}
		catch (JuegoException e)
		{
			System.out.println(e);
		}
		
	}//Fin_main
}//fin_clase

package Gestoras;
import java.io.*;
import java.util.*;
import Clases.*;
import Exceptions.JuegoException;

public class GestoraJuego 
{
	/* Protipo: Partida leerPartida (int numero)
	 * Breve comentario: Subprograma dedicado a leer una partida del fichero
	 * Precondiciones: Ninguna
	 * Entradas: Un entero indicando el numero de partida deseado
	 * Salidas: Una partida
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Una partida dependiendo de la selecci�n recibida por par�metros
	 * 
	 * Resguardo:	public Partida leerPartida (int numero)
	 * {
	 * 		System.out.println("Llamada al metodo leerpartida");
	 * }
	 */
	public Partida leerPartida (int numero)
	{
		File partidas = new File ("./src/Archivos/partidas.dat");
		Partida partida = null;
		ObjectInputStream ois = null;
		int contador = 1;
		Partida resultado = null;
		
		try
		{
			ois = new ObjectInputStream (new FileInputStream (partidas))
			{
				@Override protected void readStreamHeader () {}
			};
			
			partida = (Partida) ois.readObject();
			
			while (!partida.equals(null))
			{
				if (contador == numero)
				{
					resultado = partida.clone();
				}
				
				partida = (Partida) ois.readObject ();
				contador++;
			}
		}
		
		catch (FileNotFoundException e)
		{
			System.out.println("FileNotFoundException");
		}
		
		catch (ClassNotFoundException e)
		{
			System.out.println("ClassNotFoundException");
		}
		
		catch (EOFException e)
		{
			
		}
		
		catch (IOException e)
		{
			System.out.println("IOException");
		}
		
		finally
		{
			if (ois != null)
			{
				try
				{
					ois.close();
				}
				
				catch (IOException e)
				{
					System.out.println("IOException close");
				}
			}
		}
		
		return resultado;
	}
	//Fin leerPartida
	
	/* Prototipo: Partida asignarPartida (Partida partida1, Partida partida2, Partida partida3, int numero)
	 * Breve comentario: Metodo dedicado a la asignaci�n de una partida a la partida definitiva a utilizar en el main.
	 * Precondiciones: Ninguna
	 * Entradas: Tres partidas y un entero
	 * Salidas: Una Partida
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Una partida en funci�n de la partida definitiva indicada
	 * 
	 * Resguardo: public Partida asignarPartida (Partida partida1, Partida partida2, Partida partida3, int numero)
	 * {
	 * 		System.out.println("Llamada al metodo asignarPartida");
	 * }
	 */
	public Partida asignarPartida (Partida partida1, Partida partida2, Partida partida3, int numero)
	{
		Partida partidaDefinitiva = null;
		
		switch (numero)
		{
			case 1:
				partidaDefinitiva = partida1.clone();
			break;
				
			case 2:
				partidaDefinitiva = partida2.clone();
			break;
				
			case 3:
				partidaDefinitiva = partida3.clone();
			break;
		}
		
		return partidaDefinitiva;
	}
	//fin asignarPartida
	
	/* Prototipo: Partida guardarpartida (Mazmorra mazmorra, Jugador jugador, int numeroPartida)
	 * Breve comentario: Metodo dedicado a guardar una partida
	 * Precondiciones: Ninguna
	 * Entradas: Un Jugador, una Mazmorra y la posici�n de la partida en el archivo (int).
	 * Salidas: Ninguna
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Ninguna
	 * 
	 * Resguardo: public void guardarPartida (Mazmorra mazmorra, JugadorIMPL jugador, int numeroPartida)
		{
			System.out.println("Llamada al metodo guardarPartida");
		}
	 */
	public void guardarPartida (Mazmorra mazmorra, JugadorIMPL jugador, int numeroPartida)
	{
		File partidas = new File ("./src/Archivos/partidas.dat");
		File auxiliar = new File ("auxiliar.dat");
		Partida partida = null;
		ObjectOutputStream oos = null;
		ObjectInputStream ois = null;
		int contador = 1;
		
		try
		{
			oos = new ObjectOutputStream (new FileOutputStream (auxiliar, true))
			{
				@Override protected void writeStreamHeader () {}
			};
			
			ois = new ObjectInputStream (new FileInputStream (partidas))
			{
				@Override protected void readStreamHeader () {}
			};
		
			partida = (Partida) ois.readObject();
			
			while (!partida.equals(null))
			{
				if (contador == numeroPartida)
				{
					oos.writeObject(new Partida (mazmorra, jugador));
				}
				
				else
				{
					oos.writeObject (partida);
				}
				
				partida = (Partida) ois.readObject();
				contador++;
			}
		}
		
		catch (ClassNotFoundException e)
		{
			System.out.println("ClassNotFoundException e");
		}
		
		catch (FileNotFoundException e)
		{
			System.out.println("FileNotFoundException");
		}
		
		catch (EOFException e)
		{
			
		}
		
		catch (IOException e)
		{
			System.out.println("IOException");
		}
		
		finally
		{
			if (oos != null)
			{
				try
				{
					oos.close();
				}
				
				catch (IOException e)
				{
					System.out.println("IOException close");
				}
			}
			
			if (ois != null)
			{
				try
				{
					ois.close();
				}
				
				catch (IOException e)
				{
					System.out.println("IOException close");
				}
			}
		}
		
		partidas.delete();
		auxiliar.renameTo(partidas);
	}
	//Fin crearPartida
	
	/* Prototipo: void Jugador crearJugador ();
	 * Breve comentario: Metodo dedicado a crear un jugador con datos de teclado
	 * Precondiciones: Ninguna
	 * Entradas: Ninguna
	 * Salidas: Un jugador
	 * Entradas/Salidas: NInguna
	 * Postcondiciones: Un jugador con los datos introducidos de teclado
	 * 
	 * Resguardo: public JugadorIMPL crearJugador ()
		{
			System.out.println("Llamada al metodo crearJugador");
		}
	 */
	public JugadorIMPL crearJugador ()
	{
		Scanner teclado = new Scanner (System.in);
		JugadorIMPL jugador = null;
		InputStreamReader flujo = new InputStreamReader (System.in);
		BufferedReader tecladoString = new BufferedReader (flujo);
		int puntos = 10;
		int eleccion = 0;
		int cantidad = 0;
		
		try
		{
			jugador = new JugadorIMPL ();
			jugador.setVida(100);
			jugador.setBaseDmg(50);
			jugador.setBaseDef(50);
			jugador.setOro(0);
			
			do
			{
				System.out.println("�Cu�l es tu nombre?");
				jugador.setNombre(tecladoString.readLine ());
			}
			while (jugador.getNombre().equals(null) || jugador.getNombre().equals(""));
			
			System.out.println("Dispones de 10 puntos a repartir entre los siguientes atributos. Elige sabiamente.");
			System.out.println();
			
			while (puntos > 0)
			{
			
				do
				{
					System.out.println("Te quedan "+puntos+" disponibles");
					System.out.println();
					System.out.println("1. Vida");
					System.out.println("2. Da�o base");
					System.out.println("3. Defensa base");
					System.out.println("4. Riqueza");
					eleccion = teclado.nextInt ();
				}
				while (eleccion < 0 || eleccion > 4);
				
				switch (eleccion)
				{
					case 1:
						
						do
						{
							System.out.println("�Cu�ntos puntos quieres asignar a la vida?");
							cantidad = teclado.nextInt();
						}
						while (cantidad > puntos);
						
						puntos = puntos - cantidad;
						
						jugador.setVida(jugador.getVida() + (cantidad * 10));
						
					break;
					
					case 2:
						
						do
						{
							System.out.println("�Cu�ntos puntos quieres asignar al da�o base?");
							cantidad = teclado.nextInt();
						}
						while (cantidad > puntos);
						
						puntos = puntos - cantidad;
						
						jugador.setBaseDmg (jugador.getBaseDmg() + (cantidad * 5));
						
					break;
					
					case 3:
						
						do
						{
							System.out.println("�Cu�ntos puntos quieres asignar a la defensa base?");
							cantidad = teclado.nextInt();
						}
						while (cantidad > puntos);
						
						puntos = puntos - cantidad;
						
						jugador.setBaseDef (jugador.getBaseDef() + (cantidad * 5));
						
					break;
					
					case 4:
						
						do
						{
							System.out.println("�Cu�ntos puntos quieres asignar a la riqueza?");
							cantidad = teclado.nextInt();
						}
						while (cantidad > puntos);
						
						puntos = puntos - cantidad;
						
						jugador.setOro (jugador.getOro() + (cantidad * 10));
						
					break;
				}//Fin_segun
			
			}//Fin_mientras
		}
		
		catch (JuegoException e)
		{
			System.out.println(e);
		}
		
		catch (IOException e)
		{
			System.out.println(e);
		}
		
		return jugador;
	}
	//Fin crearJugador
	
	/* Prototipo: Partida abrirCofre (Partida partida)
	 * Breve comentario: Metodo dedicado a abrir un cofre
	 * Precondiciones: Ninguna
	 * Entradas: Ninguna
	 * Salidas: Ninguna
	 * Entradas/Salidas: Una Partida
	 * Postcondiciones: Una Mazmorra con el cofre abierto y el jugador con los items del mismo
	 * 
	 * Resguardo: public Partida abrirCofre (Partida partida)
		{
			System.out.println("Llamada al metodo abrirCofre");
			return partida;
		}
	 */
	public Partida abrirCofre (Partida partida)
	{
		boolean a�adido = false;
		ItemIMPL item = new ItemIMPL ();
		
		for (int i = 0; i < partida.getMazmorra ().getMapa().length && !a�adido; i++)
		{
			for (int j = 0; j < partida.getMazmorra ().getMapa()[0].length; j++)
			{
				if (partida.getMazmorra().getMapa()[i][j].getJugador() 
					&& !partida.getMazmorra().getMapa()[i][j].getCofre().equals(new CofreIMPL ()))
				{
					a�adido = true;
					try
					{
						item = (ItemIMPL) partida.getMazmorra ().getMapa()[i][j].getCofreDrop();
						System.out.println("WOW! Has encontrado: ");
						System.out.println ();
						
						System.out.print(item.getNombre ());
						System.out.print(", valor de " + String.valueOf(item.getPrecio ()) + " monedas de oro. ");
						System.out.print("Descripci�n: " + String.valueOf(item.getEfecto()));
						
						System.out.println ();
						System.out.println ();
						System.out.println("Y "+(partida.getJugador().getOro() + partida.getMazmorra ().getMapa()[i][j].getCofreValor())+" monedas de oro");
						System.out.println ();
						System.out.println("Lo recoges y a�ades a tu inventario");
						
						partida.getJugador().addInventario(item);
						partida.getJugador().setOro (partida.getJugador().getOro() + partida.getMazmorra ().getMapa()[i][j].getCofreValor());
					}
					catch (JuegoException e)
					{
						System.out.println(e);
					}
				}
			}
		}
		
		if (!a�adido)
		{
			System.out.println("No puedes abrir un cofre en una habitaci�n que no contiene cofre. CRACK.");
		}
		
		return partida;
	}
	//Fin abrirCofre
	
	/* Prototipo: void mostrarInventario (JugadorIMPL jugador)
	 * Breve comentario: Metodo dedicado a mostrar el inventario
	 * Precondiciones: Ninguna
	 * Entradas: Un JugadorIMPL
	 * Salidas: Un entero
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Un entero indicando el n�mero de objetos que hay en el inventario
	 * 
	 * Resguardo: public void monstrarInventario (JugadorIMPL jugador)
		{
			System.out.println("Llamada al metodo mostrarInventario");
		}	
	 */
	public int monstrarInventario (JugadorIMPL jugador)
	{
		ItemIMPL item = new ItemIMPL ();
		ArmaIMPL arma = new ArmaIMPL ();
		int numeroObjetos = jugador.getInventario().size ();
		
		for (int i = 0; i < numeroObjetos; i++)
		{
			if (jugador.getInventario().get(i) instanceof ItemIMPL)
			{
				item = (ItemIMPL) jugador.getInventario().get(i);
				System.out.println ();
				
				System.out.print((i + 1) + ". " + item.getNombre ());
				System.out.print(", valor de " + String.valueOf(item.getPrecio ()) + " monedas de oro. ");
				System.out.print("Descripci�n: " + String.valueOf(item.getEfecto()));
				
				System.out.println ();
			}
			
			else if (jugador.getInventario().get(i) instanceof ArmaIMPL)
			{
				arma = (ArmaIMPL) jugador.getInventario().get(i);
				System.out.println ();
				
				System.out.print((i + 1) + ". " + arma.getNombre ());
				System.out.print(", valor de " + String.valueOf (arma.getPrecio ()) + " monedas de oro. ");
				System.out.print("Da�o: " + String.valueOf (arma.getDmg()));
				
				System.out.println ();
			}
		}
		
		System.out.println ();
		System.out.println("0. Salir del inventario");
		System.out.println ();
		
		return (numeroObjetos);
	}
	

	/* Prototipo: boolean utilizarItem (JugadorIMPL jugador, int posicion)
	 * Breve comentario: Metodo dedicado a utilizar un objeto del inventario
	 * Precondiciones: Ninguna
	 * Entradas: Un entero y un JugadorIMPL
	 * Salidas: Un booleano
	 * Entradas/Salidas: Ninguna
	 * Postcondiciones: Un booleano indicando si se ha a�adido correctamente
	 * 
	 * Resguardo: public boolean utilizarItem (JugadorIMPL jugador, int posicion)
		{
			System.out.println("Llamada al metodo utilizarItem");
		}	
	 */
	public boolean utilizarItem (JugadorIMPL jugador, int posicion)
	{
		boolean resultado = false;
		ArmaIMPL armaAntigua = new ArmaIMPL ();
		ItemIMPL armaduraAntigua = new ItemIMPL ();
		ItemIMPL item = new ItemIMPL ();
		try
		{
			for (int i = 0; i < jugador.getInventario().size (); i++)
			{
				if ((i) == (posicion - 1))
				{
					if (jugador.getInventario().get (i) instanceof ArmaIMPL)
					{
						if (!jugador.getArmaEquipada().equals (new ArmaIMPL ()))
						{
							armaAntigua = jugador.getArmaEquipada ();
							jugador.addInventario(armaAntigua);
						}
						
						jugador.setArmaEquipada ((ArmaIMPL) jugador.getInventario().get (i));
						jugador.removeInventario(i);
						
						resultado = true;
					}
					
					else if (jugador.getInventario().get (i) instanceof ItemIMPL)
					{
						item = (ItemIMPL) jugador.getInventario().get (i);
						
						if (!item.getDuracion())
						{
							if (item.getModificadorVida() != 0)
							{
								jugador.setVida(jugador.getVida() + item.getModificadorVida());
								jugador.removeInventario(i);
								resultado = true;
							}
							
							else
							{

								if (!jugador.getArmadura ().equals (new ItemIMPL ()))
								{
									armaduraAntigua = jugador.getArmadura ();
									jugador.addInventario(armaduraAntigua);
								}
								
								jugador.setArmadura(item);
								jugador.removeInventario(i);
								
								resultado = true;
							}
						}
					}
				}
			}
		}
		catch (JuegoException e)
		{
			System.out.println(e);
		}
			
		
		return resultado;
	}
	//Fin utilizarItem
	
	//Fin
	
	//Fin Metodos A�adidos
}
/* MetodosNavidad */

public class MetodosNavidad
{
	/* Prototipo: int ordenAlfabeto (char caracter1, char caracter 2)
	 * Breve resumen: Subprograma que recibe dos carácteres del alfabeto y devuelve si el primero es anterior al segundo, 
	 * posterior o igual.
	 * Precondiciones: Los caracteres deben de ser proporcionados en minúsculas
	 * Entrada: dos caracteres
	 * Salida: un entero
	 * Entrada/Salida: ninguna
	 * Postcondiciones: 0 si el resultado es igual, -1 si es anterior, 1 si es posterior y 2 si el caracter no es del alfabeto.
	 * 
	 * Resguardo: public static int ordenAlfabeto (char caracter1, char caracter2)
	 * {
	 *  	System.out.println("Llamada al método ordenAlfabeto");
	 * 		System.out.println("Variables: "+caracter1+", "+caracter2);
	 * 		return (2);
	 * }
	 */
	public static int ordenAlfabeto (char caracter1, char caracter2)
	{
	 int resultado = 0;
	 boolean resultadoAlfabeto1 = true;
	 boolean resultadoAlfabeto2 = true;
		
	resultadoAlfabeto1 = MetodosPracticaSubprogramas.Alfabeto (caracter1);
	resultadoAlfabeto2 = MetodosPracticaSubprogramas.Alfabeto (caracter2);
	
	if (resultadoAlfabeto1 == false || resultadoAlfabeto2 == false)
	{
		resultado = 2; 
	}
	else
	{
		if (caracter1 > caracter2)
		{
			resultado = 1;
		}
		
		else if (caracter1 == caracter2)
		{
			resultado = 0;
		}
		
		else if (caracter1 < caracter2)
		{
			resultado = -1;
		}
	}
	return (resultado);
	}
	 //fin subprograma ordenAlfabeto
	 
	/* Prototipo: boolean esMayuscula (char caracter)
	 * Breve resumen: Una funcionalidad que distinga si una letra del alfabeto es mayúscula o no
	 * Precondiciones: ninguna
	 * Entrada: un caracter
	 * Salida: un booleano
	 * Entrada/Salida: ninguna
	 * Postcondiciones: VERDAD si es mayúscula, FALSO si no lo es.
	 * 
	 * Resguardo: public static boolean esMayuscula (char caracter)
	 * {
	 * 		System.out.println("Llamada al método esMayuscula");
	 * 		System.out.println("Variables: "+caracter);
	 * 		return (false);
	 * }
	 * 
	 * CORRECCIÓN
	 * 
	 * Prototipo: int esMayuscula (char caracter)
	 * Breve resumen: Una funcionalidad que distinga si una letra del alfabeto es mayúscula o no
	 * Precondiciones: ninguna
	 * Entrada: un caracter
	 * Salida: un entero
	 * Entrada/Salida: ninguna
	 * Postcondiciones: 1 si es mayúscula, -1 si no lo es y 0 si no es un caracter del alfabeto.
	 * 
	 * Resguardo: public static boolean esMayuscula (char caracter)
	 * {
	 * 		System.out.println("Llamada al método esMayuscula");
	 * 		System.out.println("Variables: "+caracter);
	 * 		return (1);
	 * }
	 */
	 
	public static int esMayuscula (char caracter)
	{
		int resultado = 1;
		boolean resultadoAlfabeto = true;
		
		resultadoAlfabeto = MetodosPracticaSubprogramas.Alfabeto (caracter);
		
		if (resultadoAlfabeto == false)
		{
			resultado = 0;
		}
		
		else if (caracter < 'A' || caracter > 'Z')
		{
			 resultado = -1;
		}
		return (resultado);
	}
	 //fin subprograma esMayuscula
	 
	 
	/* Prototipo: int esMinuscula (char caracter)
	 * Breve resumen: Una funcionalidad que distinga si una letra del alfabeto es minúscula o no
	 * Precondiciones: ninguna
	 * Entrada: un caracter
	 * Salida: un entero
	 * Entrada/Salida: ninguna
	 * Postcondiciones: 1 si es minúscula, -1 si no lo es y 0 si no es un caracter del alfabeto.
	 * 
	 * Resguardo: public static boolean esMayuscula (char caracter)
	 * {
	 * 		System.out.println("Llamada al método esMinuscula");
	 * 		System.out.println("Variables: "+caracter);
	 * 		return (1);
	 * }
	 */
	public static int esMinuscula (char caracter)
	{
		int resultado = 1;
		boolean resultadoAlfabeto = true;
		
		resultadoAlfabeto = MetodosPracticaSubprogramas.Alfabeto (caracter);
		
		if (resultadoAlfabeto == false)
		{
			resultado = 0;
		}
		
		else if (caracter < 'a' || caracter > 'z')
		{
			 resultado = -1;
		}
		return (resultado);
	}
	 //fin subprograma esMinuscula
	 
	/* Prototipo: int rangoDigito (int numero)
	 * Breve resumen: Una funcionalidad que distinga si un dígito está entre 0 y 9 o no
	 * Precondiciones: ninguna
	 * Entrada: un entero
	 * Salida: un booleano
	 * Entrada/Salida: ninguna
	 * Postcondiciones: TRUE si está en el rango deseado y FALSE sino.
	 * 
	 * Resguardo: public static boolean rangoDigito (int numero)
	 * {
	 * 		System.out.println("Llamada al método rangoDigito");
	 * 		System.out.println("Variables: "+numero);
	 * 		return (false);
	 * }
	 */
	public static boolean rangoDigito (int numero)
	{
		boolean resultado = true;
		
		if (numero < 0 || numero > 9)
		{
			resultado = false;
		}
		return (resultado);
	}
	 //fin subprograma rangoDigito
	 
	/* Prototipo: boolean simboloPuntuacion (char caracter)
	 * Breve resumen: Una funcionalidad que distinga si un caracter es un símbolo de puntuación o no
	 * Precondiciones: ninguna
	 * Entrada: un caracter
	 * Salida: un booleano
	 * Entrada/Salida: ninguna
	 * Postcondiciones: TRUE si es un símbolo de puntuación y FALSE sino.
	 * 
	 * Resguardo: public static boolean simboloPuntuacion (char caracter)
	 * {
	 * 		System.out.println("Llamada al método simboloPuntuacion");
	 * 		System.out.println("Variables: "+caracter);
	 * 		return (false);
	 * }
	 */
	public static boolean simboloPuntuacion (char caracter)
	{
		boolean resultado = false;
		
		if (caracter == ',' || caracter == '.' || caracter == ';' || caracter == ':' || caracter == 168 || caracter == '?' || caracter == '!' || caracter == 173) //No he puesto los rangos en ASCII porque cada signo estaba separado.
		{
			resultado = true;
		}
		
		return (resultado);
	}
	 //fin subprograma simboloPuntuacion
	 
	/* Prototipo: boolean Compuesto (int numero)
	 * Breve resumen: Subprograma que diga si un número es compuesto o no. Compuesto es todo número natural
	 * mayor que 1 que no es primo.
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un booleano
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: VERDAD si el numero es compuesto, FALSO sino.
	 * Resguardo: public static boolean Compuesto (int numero)
	 {
		System.out.println("Llamada al método Compuesto");
		System.out.println("Variables: "+numero);
		return (false);
	 }
	 */
	public static boolean Compuesto (int numero)
	{
		boolean resultado = false;
		boolean resultadoPrimo = false;
		
		resultadoPrimo = MetodosPracticaSubprogramas.Primo (numero);
		
		if (resultadoPrimo == false && numero > 1)
		{
			resultado = true;
		}
		
		return (resultado);
	}
	 //Fin subprograma Compuesto
	 
	/* Prototipo: boolean Perfecto (int numero)
	 * Breve resumen: Subprograma que diga si un numero es perfecto.
	 * Perfecto es todo número natural que es igual a la suma de sus divisores propios. 
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un booleano
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: VERDAD si es perfecto, FALSO sino.
	 * 
	 * Resguardo: public static boolean Perfecto (int numero)
	 * {
	 * 	System.out.println("Llamada al metodo Perfecto");
	 * 	System.out.println("Variables: "+numero);
	 * 	return (false);
	 * }
	 */
	public static boolean Perfecto (int numero)
	{
		boolean resultado = false;
		int acumulador = 0;
		
		for (int contador = 1; numero > contador; contador++)
		{
			if (numero%contador == 0)
			{
				acumulador = contador + acumulador;
			}
		}
		
		if (acumulador == numero)
		{
			resultado = true;
		}
		
		return (resultado);
	}
	  //fin subprograma Perfecto
	  
	/* Prototipo: boolean Semiperfecto (int numero)
	 * Breve resumen: Subprograma que diga si un numero es semiperfecto.
	 * Semiperfecto es todo número natural que es igual a la suma de algunos de sus divisores propios. 
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un booleano
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: VERDAD si es semiperfecto, FALSO sino.
	 * 
	 * Resguardo: public static boolean Semiperfecto (int numero)
	 * {
	 * 	System.out.println("Llamada al metodo Semiperfecto");
	 * 	System.out.println("Variables: "+numero);
	 * 	return (false);
	 * }
	 */
	public static boolean Semiperfecto (int numero)
	{
		boolean resultado = false;
		int acumulador = numero;
		
		for (int contador = numero-1; contador > 0; contador--)
		{
			if (numero%contador == 0)
			{
				acumulador = acumulador - contador;
				if (acumulador < 0)
				{
					acumulador = acumulador + contador;
				}
				else if (acumulador == 0)
				{
					resultado = true;
				}
			}
		}
		
		return (resultado);
	}
	 //Fin subprograma Semiperfecto
	 
	/* Prototipo: boolean numeroFriki (int numero)
	 * Breve resumen: Subprograma que indica si un numero es friki. Un numero es friki si sus dígitos suman 13 
	 * y además son múltiplos de 7.
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un booleano
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: VERDAD si el numero es friki, FALSO sino.
	 * 
	 * Resguardo: public static boolean numeroFriki (int numero)
	 {
		System.out.println("Llamada al metodo numeroFriki");
		System.out.println("Variables: "+numero);
		return (false);
	 }
	 */
	public static boolean numeroFriki (int numero)
	{
		boolean resultado = false;
		int resultadoSuma = 0;
		int contador = 0;
		
		resultadoSuma = MetodosModificacionesNumeros.sumarDigitos (numero);
		
		while (numero >= 10)
		{
			numero = (numero - (numero%10))/10;
			if (numero % 10 == 7)
			{
				contador++;
			}
		}
		if (numero % 7 == 0)
		{
			contador++;
		}
		
		else if (resultadoSuma == 13 && contador == resultadoSuma) 
		{
			resultado = true;
		}
		
		return (resultado);
	}

	//fin subprograma numeroFriki
	 
	/* Propotipo: int mensajeGraciosillo (int numero)
	 * Breve resumen: Subprograma que reciba un dígito e imprima una frase que rime con el numero del 0 al 9.
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un entero
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: Devuelve un -1 si el numero recibido no está entre 0 y 9, y devuelve 0 si es correcto.
	 * 
	 * Resguardo:
	 */
	public static int mensajeGraciosillo (int numero)
	{
		int resultado = 0;
		
		if (numero < 0 && numero > 9)
		{
			resultado = -1;
		}
		else
		{
			switch (numero)
			{
				case 0:
				System.out.println("Este programa esta hecho con esmero");
				break;
				
				case 1:
				System.out.println("No conozco a ningun villavicenciuno");
				break;
				
				case 2:
				System.out.println("#Perezos");
				break;
				
				case 3:
				System.out.println("#Perezres");
				break;
				
				case 4:
				System.out.println("#Perezuatro");
				break;
				
				case 5:
				System.out.println("Lo siento, no estoy autorizado a responder a esta rima.");
				break;
				
				case 6:
				System.out.println("#Perezeis (No murais pls)");
				break;
				
				case 7:
				System.out.println("#Pereziete");
				break;
				
				case 8:
				System.out.println("#Pereziocho");
				break;
				
				case 9:
				System.out.println("#Perezueve");
				break;
				
			}
		}
		return (resultado);
	}
	//fin subprograma mensajeGraciosillo
	
	/* Prototipo: boolean primoProbable (int numero)
	 * Breve resumen: Subprograma que indica si un numero es primo probable. Es primo probable todo el cual que no se sabe si
	 * es primo o no, pero que verifica alguna condición que verifican todos los numeros primos.
	 * Precondiciones: ninguna
	 * Entradas: un entero
	 * Salidas: un booleano
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: VERDAD si es primo probable, FALSO sino.
	 * 
	 * Resguardo:public static boolean primoProbable (int numero)
	 {
		System.out.println("Llamada al metodo primoProbable");
		System.out.println("Variables: "+numero);
		return (false);
	 }
	 */
	public static boolean primoProbable (int numero)
	{
		boolean resultado = false;
		
		//POR ACABAR PORQUE ME DA PEREZA HACER ESTE EJERCICIO AHORA
		
		return (resultado);
	}
	//fin subprograma primoProbable
	
	/* Prototipo: int compararFechas (int dia1, int dia2, int mes1, int mes2, int agno1, int agno2)
	 * Breve resumen: Sean dos fechas expresadas por dia1, mes1, agno1 y dia2, mes2, agno2; subprograma que devuelva si la primera
	 * fecha es igual, anterior o posterior a la segunda.
	 * Precondiciones: ninguna
	 * Entradas: seis enteros
	 * Salidas: un entero
	 * Entradas/Salidas: ninguna
	 * Postcondiciones: devuelve 0 si la primera fecha es igual a la segunda, -1 anterior, 1 posterior, 2 si la primera fecha 
	 * es errónea y 3 si la segunda fecha es erronea.
	 * 
	 * Resguardo:	public static int compararFechas (int dia1, int mes1, int agno1, int dia2, int mes2, int agno2)
	 {
		System.out.println("Llamada al metodo compararFechas");
		System.out.println("Variables:");
		System.out.println("Dia 1: "+dia1+", Mes 1: "+mes1+", Anno 1: "+agno1);
		System.out.println("Dia 2: "+dia2+", Mes 2: "+mes2+", Anno 2: "+agno2);
		return (3);
	 }
	 */
	public static int compararFechas (int dia1, int mes1, int agno1, int dia2, int mes2, int agno2)
	{
		int resultado = 0;
		boolean fecha1 = false;
		boolean fecha2 = false;
		
		fecha1 = MetodosPracticaSubprogramas.validarFecha (dia1, mes1, agno1);
		fecha2 = MetodosPracticaSubprogramas.validarFecha (dia2, mes2, agno2);
		
		if (fecha1 == false)
		{
			resultado = 2;
		}		
		
		else if (fecha2 == false)
		{
			resultado = 3;
		}
		
		else
		{
			if (agno1 > agno2 || (agno1 == agno2 && mes1 > mes2) || (agno1 == agno2 && mes1 == mes2 && dia1 > dia2))
			{
				resultado = 1;
			}
			
			else if(agno1 == agno2 && mes1 == mes2 && dia1 == dia2)
			{
				resultado = 0;
			}
			else
			{
				resultado = -1;
			}
		}
		return (resultado);
	}
	//fin subprograma compararFechas
	
	/* Prototipo: void conv24hAmPm (int hora, int minutos, int resHora, int resMinutos)
	 * Breve resumen: Programa que lea una hora en formato 24 horas y la pase a formato AM/PM.
	 * Precondiciones: ninguna
	 * Entradas: ninguna
	 * Salidas: ninguna
	 * Entradas/Salidas: dos enteros
	 * Postcondiciones: ninguna
	 * 
	 * Resguardo: 	public static void conv24hAmPm (int hora, int minutos, int resHora, int resMinutos)
	{
		System.out.println("Llamada al metodo conv24hAmPm");
		System.out.println("Variables: "+hora+", "+minutos);
		//no se como poner el return en un resguardo por referencia
	}
	* 
	* 
	* COMO NO SABEMOS DEVOLVER POR REFERENCIA EN JAVA, TENDRÉ QUE ADAPTARLO A ASIGNADO AL NOMBRE.
	* 
	* Prototipo: int conv24hAmPm (int hora, int minutos)
	* Breve resumen: Programa que lea una hora en formato 24 horas y la pase a formato AM/PM.
	* Precondiciones: ninguna
	* Entradas: dos enteros
	* Salidas: un entero
	* Entradas/Salidas:
	* Postcondiciones: 0 si se ha convertido sin problemas, 1 si la hora introducida es inválida.
	* 
	* Resguardo: public static int conv24hAmPm (int hora, int minutos)
	{
		System.out.println("Llamada al metodo conv24hAmPm");
		System.out.println("Variables: "+hora+", "+minutos);
		return (1);
	}
	*/
	public static int conv24hAmPm (int hora, int minutos)
	{
		boolean resultadoValidar = false;
		int resultado = 0;
		
		resultadoValidar = MetodosPracticaSubprogramas.validarHora (hora, minutos);
		
		if (resultadoValidar == false)
		{
			resultado = 1;
		}
		
		else
		{
			if (hora <= 12)
			{
				System.out.println ("Son las: "+hora+":"+minutos+" AM");
			}
			else
			{
				switch (hora)
				{
				
				case 13:
				
				hora = 1;
				
				break;
				
				case 14:
				
				hora = 2;
				
				break;
				
				case 15:
				
				hora = 3;
				
				break;
				
				case 16:
				
				hora = 4;
				
				break;
				
				case 17:
				
				hora = 5;
				
				break;
				
				case 18:
				
				hora = 6;
				
				break;
				
				case 19:
				
				hora = 7;
				
				break;
				
				case 20:
				
				hora = 8;
				
				break;
				
				case 21:
				
				hora = 9;
				
				break;
				
				case 22:
				
				hora = 10;
				
				break;
				
				case 23:
				
				hora = 11;
				
				break;
				
				case 24:
				
				hora = 12;
				
				break;
				}//fin_segun
			System.out.println("Son las: "+hora+":"+minutos+" PM");
			}
		}
		
		return (resultado);
	}
	//fin subprograma conv24hAmPm
}//fin_pp

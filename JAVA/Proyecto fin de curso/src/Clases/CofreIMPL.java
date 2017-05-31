package Clases;

import java.io.Serializable;
import java.util.*;
import Interfaces.Cofre;

public class CofreIMPL implements Serializable, Cofre
{
	private static final long serialVersionUID = 1416960979169236387L;
	private double valor;
	private ObjetoIMPL drop;
	
	//Constructores
	public CofreIMPL ()
	{
		valor = 0.0;
		drop = new ObjetoIMPL ();
	}
	
	public CofreIMPL (CofreIMPL cofre)
	{
		this.valor = cofre.valor;
		this.drop = cofre.drop;
	}
	
	public CofreIMPL (double valor, ObjetoIMPL drop)
	{
		this.valor = valor;
		this.drop = drop;
	}
	//Fin Constructores
	
	//Getters y setters
	public double getValor ()
	{
		return valor;
	}
	
	public void setValor (double valor)
	{
		this.valor = valor;
	}
	
	public ObjetoIMPL getDrop ()
	{
		return drop;
	}
	
	public void setDrop (ObjetoIMPL drop)
	{
		this.drop = drop;
	}
	

	public String getNombre() 
	{
		return drop.getNombre();
	}

	public void setNombre(String nombre) 
	{
		drop.setNombre(nombre);
	}

	public double getPrecio() 
	{
		return drop.getPrecio();
	}

	public void setPrecio(double precio) 
	{
		drop.setPrecio(precio);
	}
	//Fin Getters y setters
	
	//Metodos a�adidos
	@Override
	public boolean equals (Object object)
	{
		boolean resultado = false;
		
		if (object != null && object instanceof Object)
		{
			CofreIMPL cofre = (CofreIMPL) object;
			
			if (this.getValor() == cofre.getValor ()
				&& this.getDrop().equals(cofre.getDrop ()))
			{
				resultado = true;
			}
		}
		
		return resultado;
	}
	
	@Override
	public String toString ()
	{
		return (this.getValor()+","+ this.getDrop().toString ());
	}
	
	@Override
	public int hashCode ()
	{
		return (Objects.hash (this.getValor(), this.getDrop()));
	}
	
	@Override
	public CofreIMPL clone ()
	{
		CofreIMPL copia = null;
		
		try
		{
			copia = (CofreIMPL) super.clone ();
		}
		
		catch (CloneNotSupportedException e)
		{
			e.printStackTrace ();
		}
		
		return copia;
	}
	
	public int compareTo (CofreIMPL cofre)
	{
		int resultado = 0;
		
		if (this.getValor() > cofre.getValor())
		{
			resultado = 1;
		}
		
		else if (this.getValor() < cofre.getValor())
		{
			resultado = -1;
		}
		
		return resultado;
	}
	//Fin Metodos a�adidos

		
}

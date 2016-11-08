package z7;

import java.io.Serializable;

public class Ksiazka implements Serializable
{
	private static final long serialVersionUID = 4661681646491395516L;
	public String Tytul, autor;
	public int wydanie;
	public String klasa;
	
	public Ksiazka(String k,String T, String a, int w)
	{
		Tytul = T; autor = a; wydanie = w; klasa = k;
	}

	public Ksiazka() { 
	
	this("Inne","Tytul", "Autor", 11111); } 

	public String toString()
	{
		return klasa+"\n" +Tytul + "\n" + autor + "\n" + Integer.toString(wydanie);
	}

}

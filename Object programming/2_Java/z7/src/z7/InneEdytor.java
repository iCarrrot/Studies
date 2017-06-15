package z7;


import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.Scanner;

import javax.swing.*;

public class InneEdytor extends JFrame implements ActionListener, Serializable
{
	private static final long serialVersionUID = 1L;
	public JButton ButtonZapisz, ButtonOtworz;
	public JTextField TextTytul, TextAutor, TextRok,TextInne;
	public Inne K;
	String klasa;
	public InneEdytor(String s)
	{
		initUI();  K = new Inne();

		if(s != "")
		{
			File file = new File(s);
			ReadFromFile(file);
		}
		
	}

	public void ReadFromBook()
	{
		TextTytul.setText(K.Tytul);
		TextInne.setText(K.klasa);
		TextAutor.setText(K.autor);
		TextRok.setText(Integer.toString(K.wydanie));
		TextTytul.setText(K.Tytul);
	}
	
	public void WriteToBook()
	{
		K = new Inne(TextInne.getText(),TextTytul.getText(), TextAutor.getText(), Integer.parseInt(TextRok.getText()));
	}
	
	public final void initUI()
	{
		setTitle("Inne");
		ButtonZapisz = new JButton("Zapisz do pliku");
		ButtonOtworz = new JButton("Otw�rz z pliku");

		ButtonZapisz.setBounds(0, 10, 200, 30);
		ButtonOtworz.setBounds(0, 50, 200, 30);
		
		this.setLayout(null);

        getContentPane().add(ButtonZapisz);
        getContentPane().add(ButtonOtworz);
        ButtonZapisz.addActionListener(this);
        ButtonOtworz.addActionListener(this);
        
		TextTytul = new JTextField("Tytul");
		TextTytul.setBounds(200, 10, 200, 30);
		getContentPane().add(TextTytul);
		
		TextAutor = new JTextField("Autor");
		TextAutor.setBounds(200, 50, 200, 30);
		getContentPane().add(TextAutor);
		
		TextRok = new JTextField("Rok Wydania");
		TextRok.setBounds(200, 90, 200, 30);
		getContentPane().add(TextRok);
		
		TextInne = new JTextField("Typ");
		TextInne.setBounds(200, 130, 200, 30);
		getContentPane().add(TextInne);
		
        setSize(500, 250);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    	setVisible(true);
    }
	
	public void SaveToFile(File file)
	{
		try
		{
			PrintWriter zapis = new PrintWriter(file);
			WriteToBook();
			zapis.println(K.toString());
			zapis.close();
		}
		catch (FileNotFoundException e1) {}
	}
	
	public void ReadFromFile(File file)
	{
		try
		{
			Scanner in = new Scanner(file);

			String k = in.nextLine();
			String T = in.nextLine();
			String A = in.nextLine();
			String R = in.nextLine();

			
			K = new Inne(k,T,A,Integer.parseInt(R));
			ReadFromBook();
			in.close();
		}
		catch (FileNotFoundException e1) {}
	}
	
	public void actionPerformed(ActionEvent e)
	{
		Object source = e.getSource();
		
		if( source == ButtonZapisz )
		{
			JFileChooser fileChooser = new JFileChooser();
			if (fileChooser.showSaveDialog(ButtonZapisz) == JFileChooser.APPROVE_OPTION)
			{
				File file = fileChooser.getSelectedFile();
				SaveToFile(file);
			}
		}
		
		if( source == ButtonOtworz )
		{
			JFileChooser fileChooser = new JFileChooser();
			
			if (fileChooser.showOpenDialog(ButtonOtworz) == JFileChooser.APPROVE_OPTION)
			{
				File file = fileChooser.getSelectedFile();
				ReadFromFile(file);
				
			}
		}
	}
}

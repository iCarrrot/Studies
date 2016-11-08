package zadanie6_1;
import java.io.*;
//import java.util.Iterator;

public class program {

	public static void main(String[] args) {
        Lista<Integer> nowa=new Lista<Integer>();
        nowa.addend(200);
        nowa.addend(27603216);
        nowa.addend(1);
        nowa.addend(2);
        nowa.addend(3);
        nowa.addend(4);
        nowa.addend(6791);
        try{
            FileOutputStream fOut=new FileOutputStream("list.ser");
            ObjectOutputStream out = new ObjectOutputStream(fOut);
            //Iterator<Integer> iter=nowa.iterator();
            out.writeObject(nowa);
            out.close();
            fOut.close();
            System.out.println("Zserializowane do list.ser");
            FileInputStream fIn=new FileInputStream("list.ser");
            ObjectInputStream in = new ObjectInputStream(fIn);
            Lista<Integer> nowsza =(Lista<Integer>)(in.readObject());
            nowsza.sprint();
            in.close();
            fIn.close();
        }catch(Exception i)
        {
            i.printStackTrace();
        }

	}

}

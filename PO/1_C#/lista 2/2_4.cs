using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class IntStream
{
    public bool eos1;
    public int licz;
    public IntStream()
    {
        eos1 = false;
        licz = -1;
    }
    public int next()
    {
        if (licz < Int32.MaxValue)
        {
            licz++;
        }
        else
        {
            eos1 = true;
        }
        return licz;
    }
    public bool eos()
    {
        return eos1;
    }
    public void reset()
    {
        eos1 = false;
        licz = -1;
    }
}
public class PrimeStream : IntStream
{
    int prime;
    public PrimeStream() : base()
    {
        prime = 1;
        licz = 1;
    }
    public bool czy_pierwsza(int a)
    {
        for (int i = 2; i * i < a+1; i++)
        {
            if (a % i == 0)
            {
                return false;
            }

        }
        return true;
    }
    public new int next()
    {
        if (licz < Int32.MaxValue)
            licz++;
        else
        {
            eos1 = true;
            return prime;
        }
        if (czy_pierwsza(licz))
        {
            prime = licz;
            return licz;
        }
        else
        {
            return this.next();
        }

    }
    public new void reset()
    {
        base.reset();
        licz = 1;
    }

}

public class ListaLeniwa
{
    public List<int> leniwa;
    public int rozm;
    public ListaLeniwa()
    {
        rozm = 0;
        leniwa = new List<int>();
    }
    public int element(int a)
    {
        Random rand = new Random();
        if (a > rozm)
        {
            for (int i = 0; i < a - rozm + 1; i++)
            {
                leniwa.Add(rand.Next(100));
            }
            rozm = a;
        }
        return leniwa[a];
    }
    public int rozmiar()
    {
        return rozm;
    }
}

class Pierwsze : ListaLeniwa
{
    PrimeStream prime;
    public Pierwsze()
    {
        prime = new PrimeStream();
    }
    public new int element (int a)
    {
        if (a > rozm)
        {
            for (int i = rozm; i < a - rozm+1; i++)
            {
                leniwa.Add(prime.next());
            }
        }
        return leniwa[a];
    }

}
namespace ConsoleApplication3
{
    class Program
    {
        static void Main(string[] args)
        {
            ListaLeniwa lista = new ListaLeniwa();
            Pierwsze p = new Pierwsze();
            Console.WriteLine(lista.element(40));
            Console.WriteLine(lista.rozmiar());
            Console.WriteLine(lista.element(0));
            Console.Read();
            Console.WriteLine(p.element(40));
            Console.WriteLine(p.element(0));
            Console.WriteLine(p.element(40));
            Console.Read();
            Console.Read();
            Console.Read();

        }
    }
}

using System;
using System.Collections.Generic;
using z2_1;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ListaLeniwa
{
    List<int> leniwa;
    int rozm;
    public ListaLeniwa()
    {
        rozm = 0;
        leniwa = new List<int>();
    }
    public int element(int a)
    {
        if (a > rozm)
        {
            for (int i=rozm; i<a - rozm; i++)
            {
                leniwa.Add(i);
            }
            rozm = a;
        }
        return leniwa[a - 1];
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
    public new int el(int a)
    {
        if (a > rozm)
        {
            for (int i = rozm; i < a - rozm; i++)
            {
                leniwa.Add(prime.next());
            }
        }
        return leniwa[a - 1];
    }

}
namespace z2_4
{
    class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Hello World! :)");
            Console.Read();
        }
    }
}


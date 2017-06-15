using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
    class Program
    {
        static void Main(string[] args)
        {
            PrimeStream prS = new PrimeStream();
            IntStream inS = new PrimeStream();
            klasa kl = new klasa();
            inS.MoveNext();
            inS.MoveNext();
            Console.WriteLine(inS.Current);
            Console.WriteLine(inS.lenght);
            Console.WriteLine(inS.ToString());
            inS.MoveNext();
            inS.MoveNext();
            Console.WriteLine(inS[2]);
            prS.MoveNext();
            prS.MoveNext();
            Console.WriteLine(prS.next());
            Console.WriteLine(inS.next());
            Console.ReadKey();

            foreach(int i in kl)
            {
                Console.WriteLine(i);
                Console.ReadKey();
            }



        }
    }
}

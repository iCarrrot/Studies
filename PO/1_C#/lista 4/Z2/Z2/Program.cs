using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Z2
{
    class Program
    {
        static void Main(string[] args)
        {
            PrimeCollection pc = new PrimeCollection();
            foreach (int p in pc)
                Console.WriteLine(p);
            Console.ReadKey();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zadanie_1
{
    class Program
    {
        static void Main(string[] args)
        {
            Lista<int> list = new Lista<int>();
            for (int i = 1; i < 20; i++) {
                list.addEnd(i);
            }
            list.wypisz_el();

        }
    }
}

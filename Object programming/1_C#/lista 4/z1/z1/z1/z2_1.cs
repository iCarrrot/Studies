using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
    public class IntStream: interfejs
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
        public bool EoS()
        {
            return eos1;
        }
        public void Reset()
        {
            eos1 = false;
            licz = -1;
        }
    }
    public class PrimeStream : IntStream,interfejs
    {
        int prime;
        public PrimeStream() : base()
        {
            prime = 1;
            licz = 1;
        }
        public bool czy_pierwsza(int a)
        {
            for (int i = 2; i * i < a + 1; i++)
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
        public new void Reset()
        {
            base.Reset();
            licz = 1;
        }

    }
   
}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace z1
{
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
        public new void reset()
        {
            base.reset();
            licz = 1;
        }

    }
    public class RandomStream : IntStream
    {
        Random los;
        public RandomStream()
        {
            los = new Random();
        }
        public new int next()
        {
            return los.Next(65, 90);
        }
    }
    public class RandomWordStream : PrimeStream
    {
        RandomStream los;
        PrimeStream p;
        public RandomWordStream()
        {
            los = new RandomStream();
            p = new PrimeStream();
        }
        public new string next()
        {
            int rozm = p.next();
            System.Text.StringBuilder slowo = new System.Text.StringBuilder();
            for (int i = 0; i < rozm; i++)
                slowo.Append((char)los.next());
            return slowo.ToString();
        }
    }
}


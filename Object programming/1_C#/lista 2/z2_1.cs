using System;
namespace z2_1 {
    public class IntStream
    {
        bool eos1;
        int licz;
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
            for(int i=2; i*i< a; i++)
            {
                if (a % i == 0 )
                {
                    return false;
                    break;
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
                return this.next;
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
            return los.Next();
        }
    }
    public class RandomWordStream :PrimeStream
    {
        RandomStream los;
        public RandomWordStream()
        {
            los = new RandomStream();
        }
        public new string next()
        {
            int rozm = base.next();
            System.Text.StringBuilder slowo = new System.Text.StringBuilder();
            for (int i = 0; i < rozm; i++)
                slowo.Append((char)rnd.next());
            return slowo.ToString();
        }
    }
}
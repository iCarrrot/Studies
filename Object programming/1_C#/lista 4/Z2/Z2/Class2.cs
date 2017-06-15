using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Z2
{
    public class Prime : IEnumerator
    {
        public int x;
        public Prime()
        {
            x = 1;
        }
        bool if_prime(int x)
        {
            for(int i=2; i*i-1<x; i++)
            {
                if ((x % i)==0)
                {
                    return false;
                }
            }
            return true;
        }
        public bool MoveNext()
        {
            if (x == int.MaxValue)
                return false;
            x++;
            while (!if_prime(x))
            {
                if (x == int.MaxValue)
                    return false;
                x++;
            }
            return true;
        }
        public void Reset()
        {
            x = 1;
        }
        public object Current
        {
            get
            {
                return x;
            }
        }
    }
}

using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
    class IntStream : interfejs, IEnumerator
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
        public bool MoveNext()
        {
            licz++;
            return (licz < int.MaxValue);
        }
        public object Current
        {
            get
            {
                return licz;
            }
        }
        public override string ToString()
        {
            return String.Format("Kolejna liczba: {0}", this.licz);
        }
        public int this[int indeks]
        {
            get
            {
                if (indeks == 0)
                {
                    return -1;
                }
                this.next();
                return this[indeks - 1]+1;
            }

        }
        public int lenght
        {
            get
            {
                return ++licz;
            }

        }
    }
}

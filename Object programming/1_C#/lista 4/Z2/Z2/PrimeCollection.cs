using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Z2
{
    public class PrimeCollection:IEnumerable
    {
        public IEnumerator GetEnumerator()
        {
            return new Prime();
        }
    }
}

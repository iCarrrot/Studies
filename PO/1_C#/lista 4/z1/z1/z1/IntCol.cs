using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
   public class klasa : IEnumerable
    {
        public IEnumerator GetEnumerator()
        {
            return new IntStream();
        }
    }
}

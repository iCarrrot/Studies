using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zadanie_1
{
    class SNode<K,V>
    {
        public K key;
        public V val;
        public SNode<K,V> next;
    }
}

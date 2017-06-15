using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zadanie_1
{
    class Slownik<K,V>
    {
        SNode<K, V> head;
        public void add(K ky, V vl)
        {
            if (head == null)
            {
                head = new SNode<K,V>();
                head.val = vl;
                head.next = null;
                head.key = ky;
            }
            else
            {
                SNode<K,V> temp= new SNode<K, V>();
                temp.key = ky;
                temp.val = vl;
                SNode<K, V> temp2 = new SNode<K, V>();
                temp2.next = head.next;
                while (temp2.next != null)
                {
                    temp2 = temp2.next;
                }
                temp2.next = temp;
                temp.next = null;

            }
        }
        public SNode<K,V> find(K ky)
        {
            SNode<K, V> temp = new SNode<K, V>();
            if (head == null)
            {
                return null;
            }
            else {
                temp = head;
                while (!ky.Equals(temp.key) || temp.next != null)
                {
                    temp = temp.next;
                }
                if (temp.next == null)
                {
                    return null;
                }
                else
                {
                    return temp;
                }
            }

        }
        public V del(K ky)
        {
            SNode<K, V> temp = new SNode<K, V>();
            SNode<K, V> temp2 = new SNode<K, V>();
            if (head == null)
            {
                return default(V);
            }
            else {
                temp = head;
                while (!ky.Equals(temp.key) || temp.next != null)
                {
                    temp2 = temp;
                    temp = temp.next;
                }
                if (temp.next == null) {
                    return default(V);
                 }
                else
                {
                    temp2.next = temp.next;
                    return temp.val;
                }
            }

        }




    }


}

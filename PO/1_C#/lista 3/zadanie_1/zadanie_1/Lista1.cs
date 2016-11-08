using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zadanie_1
{
    class Lista<T>
    {
        Node<T> head;
        public Lista()
        {
        }
        public void addEnd(T wart)
        {
            if (head == null)
            {
                head = new Node<T>();
                head.val = wart;
                head.next = head;
                head.prev = head;
            }
            else
            {
                Node<T> temp;
                temp = new Node<T>();
                temp.val = wart;
                temp.next = head;
                temp.prev = head.prev;
                head.prev.next = temp;
                head.prev=temp;
            }
        }
        public void addBeg(T wart)
        {
            if (head == null)
            {
                head = new Node<T>();
                head.val = wart;
                head.next = head;
            }
            else
            {
                Node<T> temp;
                temp = new Node<T>();
                temp.val = wart;
                temp.next = head;
                temp.prev = head.prev;
                head.prev.next = temp.prev;
                head.prev = temp;
                head = temp;
            }
        }
        public T delBeg()
        {
            if (head == null)
            {
                Console.Write("Pusta Lista\n");
                return default(T);
            }
            else if (head == head.prev)
            {
                T tVal = head.val;
                head = null;
                return tVal;

            }
            else
            {
                T tVal = head.val;
                head.prev.next = head.next;
                head.next.prev = head.prev;
                head = head.next;
                return tVal;
            }
        }
        public T delEnd()
        {
            if (head == null)
            {
                Console.Write("Pusta Lista\n");
                return default(T);
            }
            else if (head == head.prev)
            {
                T tVal = head.val;
                head = null;
                return tVal;

            }
            else
            {
                T tVal = head.val;
                head.prev.prev.next = head;
                head.prev = head.prev.prev;
                return tVal;
            }
        }
        public void wypisz_el()
        {
            Node<T> temp;
            temp = head;
            while (temp != head.prev)
            {

                Console.Write("{0}\t",temp.val);
                temp = temp.next;
            }
            Console.Write(temp.val);

            Console.ReadKey();
        }


    }
}

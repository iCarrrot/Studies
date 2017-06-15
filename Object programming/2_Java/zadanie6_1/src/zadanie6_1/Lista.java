package zadanie6_1;
import java.util.Iterator;

public class Lista<T>implements java.io.Serializable {
	 public int count;
	    private Node<T> head;
	    private Node<T> tail;
	    public void addend(T element)
	    {
	        count++;
	        if(head==null)
	        {    
	            head=new Node<T>();
	            head.wartosc=element;
	            head.next=head;
	            head.previous=head;
	            tail=head;
	        }
	        else{
	            Node<T> temp=new Node<T>();
	            temp.wartosc=element;
	            temp.next=head;
	            temp.previous=tail;
	            tail.next=temp;
	            tail=temp;
	        }
	    }
	    public T delbeg()
	    {
	        if(head==null)
	        {
	            System.out.println("Pusta Lista\n");
	            return null;
	        }
	        else if(head==tail)
	        {
	            count--;
	            Node<T> ret=head;
	            head=null;
	            tail=null;
	            return ret.wartosc;
	        }
	        else
	        {
	            count--;
	            Node<T> ret=head;
	            (head.next).previous=tail;
	            tail.next=head.next;
	            head=head.next;
	            return ret.wartosc;
	        }
	    }
	    public void addbeg(T element)
	    {
	        count++;
	        if(head==null)
	        {
	            head=new Node<T>();
	            head.wartosc=element;
	            head.next=head;
	            head.previous=head;
	            tail=head;
	        }
	        else
	        {
	            Node<T> temp=new Node<T>();
	            temp.wartosc=element;
	            temp.next=head;
	            temp.previous=tail;
	            tail.next=temp;
	            head.previous=temp;
	            head=temp;
	        }
	    }
	    public T delend()
	    {
	        if(head==null)
	        {
	            System.out.println("Pusta Lista");
	            return null;
	        }
	        else if(head==tail)
	        {
	            count--;
	            Node<T> ret=head;
	            head=null;
	            tail=null;
	            return ret.wartosc;
	        }
	        else
	        {
	            count--;
	            Node<T> ret=tail;
	            (tail.previous).next=head;
	            head.previous=tail.previous;
	            tail=tail.previous;
	            return ret.wartosc;
	        }
	    }
	    public void sprint()
	    {
	        Node<T> iterator=head;
	        while(iterator!=tail)
	        {
	            System.out.println(iterator.wartosc);
	            iterator=iterator.next;
	        }
	        System.out.println(iterator.wartosc);
	    }
	    public Iterator<T> iterator() {
	        return new ListaIterator<T>(this);
	    }
	    private static class ListaIterator<E> implements java.util.Iterator<E>
	    {
	    Node<E> current;
	    Node<E> last;
	    
	    ListaIterator(Lista<E> iter)
	    {
	        current=iter.head;
	        last=iter.head;
	    }
	    @Override
	    public boolean hasNext() {
	        return (current.next!=last);
	    }

	    @Override
	    public E next() {
	        E ret=current.wartosc;
	        current=current.next;
	        return ret;
	        }

	    @Override
	    public void remove() {
	        throw new UnsupportedOperationException("Not supported yet.");
	        }
	    }
}


public class proram extends Wyrazenie{

	public static void main(String[] args) {

			Atom X = new Var("X", 1.0);
			Atom wyrazenie = new Add(new Power (new Mult(new Value(3.0),X), new Value(1.0)), 
					new Sub(new Value(5.0),new Mult(new Div(X,new Add(X,new Value(1.0))),	X)));
			System.out.println(wyrazenie.toString() + " = " + wyrazenie.count().toString());
	}

}

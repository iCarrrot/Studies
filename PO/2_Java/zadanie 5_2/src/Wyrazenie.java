
public class Wyrazenie {
		public static abstract class Atom {
			public abstract Double count();
			public abstract String toString();
		}
		
		public static class Value extends Atom {
			private Double Value;
			
			public Value(Double Value) {
				this.Value = Value;
			}
			
			public Double count() {
				return this.Value;
			}
			
			public String toString() {
				return this.Value.toString();
			}
		}
		
		public static class Var extends Atom {
			private Double Value;
			private String Var;
			
			public Var(String Var, Double Value) {
				this.Var = Var;
				this.Value = Value;
			}
			
			public Double count() {
				return this.Value;
			}
			
			public String toString() {
				return this.Var;
			}
		}
		
		public static abstract class Operator extends Atom {
			protected Atom left;
			protected Atom right;
		
			public Operator(Atom left, Atom right) {
				this.left  = left;
				this.right = right;
			}
			
			public String toString() {
				return "(" + this.left.toString() + " " + this.sign() + " " + this.right.toString() + ")";
			}
			
			abstract protected String sign();
		}
		
		public static class Add extends Operator {
			public Add (Atom left, Atom right) {
				super(left, right);
			}
			
			public Double count() {
				return this.left.count() + this.right.count();
			}
			
			protected String sign() {
				return "+";
			}
		}
		public static class Power extends Operator{
			public Power (Atom left, Atom right){
				super(left,right);
			}
			public Double count(){
				return Math.pow(this.left.count(),this.right.count());
			}
			protected String sign(){
				return "^";
			}
		}
		
		public static class Sub extends Operator {
			public Sub (Atom left, Atom right) {
				super(left, right);
			}
			
			public Double count() {
				return this.left.count() - this.right.count();
			}
			
			protected String sign() {
				return "-";
			}
		}
		
		public static class Mult extends Operator {
			public Mult (Atom left, Atom right) {
				super(left, right);
			}
			
			public Double count() {
				return this.left.count() * this.right.count();
			}
			
			protected String sign() {
				return "*";
			}
		}
		
		public static class Div extends Operator {
			public Div (Atom left, Atom right) {
				super(left, right);
			}
			
			public Double count() {
				return this.left.count() / this.right.count();
			}
			
			protected String sign() {
				return "/";
			}
		}
}

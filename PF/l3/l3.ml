(*z4*)
let reverse x_list =
	let rec rev_acc acc x_list = 
	match x_list with
	| x::xs -> rev_acc (x::acc) xs
	| [] -> acc

in 
rev_acc [] x_list

(*z2*)
let scanl (f:'a->'b->'a) (a:'a) (b_list:'b list) : 'a list =
	let rec aux f b_list (a::acc) =
		match b_list with
			|b::bs -> aux f bs ((f a b)::a::acc) 
			|[]->reverse (a::acc) 
	in
	aux f b_list (a::[])





(*z5*)
let rec map (f:'a->'b) (x_list:'a list) : 'b list=
	match x_list with
		| x::xs -> (f x)::(map f xs)
		| [] -> []
(*z6*)
let rec all (f: 'a -> bool) (a_list: 'a list) : bool =
	match a_list with
		|x::xs->(f x)&&(all f xs)
		|[]-> true


(*  z7+a) *)

let rec any (f: 'a -> bool) (a_list: 'a list) : bool =
	match a_list with
		|x::xs->if f x then true else any f xs
		|[]-> false 

(*z8*)
type aritm_literal = Neg | Add | Sub | Mul | Div | Pow | Num of float

(*z9*)

exception IllegalOperation of (aritm_literal* float	* float)
exception TooFewOperations
exception TooMuchOperations

let eval_rpm (a_list:aritm_literal list) : float=
	let operations operator arg1 arg2 : float=
		match operator with 
			| Add -> arg1+.arg2
			| Sub -> arg1-.arg2
			| Mul ->arg1*.arg2
			| Div ->if arg2=0.0 then raise (IllegalOperation(operator,arg1,arg2)) else arg1/.arg2
			| Pow -> try arg1**arg2 with _ -> raise (IllegalOperation(operator,arg1,arg2))
			| _ -> raise (IllegalOperation(operator,arg1,arg2))
	in
		let rec aux a_list acc =
			match a_list with
			|  Num x ::xs-> aux xs (x::acc)
			| Neg::xs -> let y::ys = acc in aux xs ((-1.0*.y)::ys)
			|x::xs -> try (let y1::y2::ys =acc in aux xs ((operations x y2 y1)::ys)) with _ -> raise TooMuchOperations
			|[]-> let y::ys=acc in if ys=[] then y else raise TooFewOperations
		in
			aux a_list []


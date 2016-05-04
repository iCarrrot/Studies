roots :: (Double,Double,Double) ->[Double]
roots (a,b,c)=
 if a==0 then
   if b==0 then []
   else [-c/b]
  else
   case compare delta 0 of
    EQ -> [-b/(2*a)] 
    LT -> []
    GT -> [(-b+sqrt(delta))/(2*a),(-b-sqrt(delta))/(2*a) ]
    where delta = b*b -4*a*c

data Roots=No|One(Double)|Two(Double,Double) deriving Show

roots2 :: (Double, Double, Double)->Roots
roots2 (a,b,c)=
 if a==0 then
  if b==0 then No
  else One(-c/b)
 else
  case compare delta 0 of
   EQ -> One(-b/(2*a))
   LT -> No
   GT -> Two((-b+sqrt(delta))/(2*a),(-b-sqrt(delta))/(2*a))
   where delta =b*b -4*a*c

roots3 :: [Double] ->[Double]
roots3 [a,b,c]=
 if a==0 then
   if b==0 then []
   else [-c/b]
  else
   case compare delta 0 of
    EQ -> [-b/(2*a)] 
    LT -> []
    GT -> [(-b+sqrt(delta))/(2*a),(-b-sqrt(delta))/(2*a) ]
    where delta = b*b -4*a*c

import Data.List as L

f1 x = map (-1) x
f2 x = map -(1 x)
f3 x = [x] : [1]
f4 x = x * sin .1

loop ::a
loop = loop

ones :: [Integer]
ones = 1 : ones


ssm :: [Integer] -> [Integer]
ssm = reverse . foldl aux []

aux :: [Integer] -> Integer -> [Integer]
aux [] a = [a]
aux (x:xs) a
	|	a > x			=	a:x:xs
	|	otherwise	=	x:xs

{-
foldr (\_ x -> x+1) 0 
 foldl (\x _ -> x+1) 0 
(+++)=flip $foldr (:)
 foldr (\y x -> y++x) [] 
 foldl (\x y -> y++x) [] 
 foldl (+) 0
 -}
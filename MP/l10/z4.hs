import Data.List

merge:: Ord a => ([a],[a]) -> [a]
merge (xs,[]) = xs
merge ([],ys) = ys
merge (x:xs,y:ys) = if x<=y then x:merge(xs,y:ys) else y:merge(x:xs,ys)

msortn :: Ord a => [a] -> Int -> [a]
msortn xs 0 = [] 
msortn (x:xs) 1 = [x]
msortn xs n = merge ((msortn xs k),(msortn (drop k xs) (n-k)))
 where k = n `div` 2


import Data.List

merge_unique ::Ord a => [a] -> [a] -> [a]
merge_unique [] ys = ys
merge_unique xs [] = xs
merge_unique (x:xs) (y:ys)
    |x==y = merge_unique xs (y:ys)
    |x<y = x:(merge_unique xs (y:ys))
    |otherwise = y:(merge_unique (x:xs) ys)

merge_3_unique x y z = merge_unique x (merge_unique y z)

--d235 :: [Integer]
--d235 = 1:(merge_unique (merge_unique (map (2*) d235) (map (3*) d235)) (map (5*) d235))
d235b = 1: merge_3_unique (map (2*) d235b) (map (3*) d235b) (map (5*) d235b)
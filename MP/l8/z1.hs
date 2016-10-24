reverse :: [a] −> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]
rev :: [a] −> [a] 
rev x
	= aux [ ] x where
	aux ys [ ] = ys
	aux ys ( x : xs ) = aux ( x : ys ) xs
main = putStrLn $ show( rev [ 1 , 2 , 3 ])
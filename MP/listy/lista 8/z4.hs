fib :: Int->Integer
fib n = fibbs !! n where
 fibbs=1:1:zipWith(+) fibbs (tail fibbs)
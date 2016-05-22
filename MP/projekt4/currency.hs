--część programu wzorowana na podręczniku "INTRODUCTION TO FUNCTIONAL PROGRAMMING" by Richard Bird and Philip Wadler

module Verbally (Typeo(..), Currency(..), verbally) where
    data Typeo = None deriving Show
    data Currency = Currency {
        singular :: String,
        pluralOne :: String,
        plural :: String,
        typeo :: Typeo
    } deriving Show

    verbally :: Currency -> Integer -> String
    verbally currency number
        |number ==1 = "one "++(singular currency)
        |number ==(-1)="minus one "++(singular currency)
        |otherwise = (convert_numbers number) ++ (plural currency)

    numerki::  Integer -> Integer -> [(Integer, Integer)] -> [(Integer, Integer)]
    numerki n count xs 
       |n<=0 = xs
       |count ==0 = let k=( n `mod` 1000000 ) in numerki (n`div`1000000) (count+2) ((count,k):xs) 
       |otherwise = let k=( n `mod` 1000 ) in numerki (n`div`1000) (count+1) ((count,k):xs) 

    convert2 n = combine2 ( digits2 n)  

    digits2 n =(n `div` 10, n `mod` 10)

    units=["one" , "two" , "three" , "four" , "five" ,"six" , "seven" , "eight" , "nine"]
    teens=["ten" , "eleven" , "twelve" , "thirteen" , "fourteen" ,"fifteen" , "sixteen" , "seventeen" , "eighteen" , "nineteen"]
    tens=["twenty" , "thirty" , "forty" , "fifty" ,"sixty", "seventy", "eighty" , "ninety"]

    combine2 (0,0) = ""
    combine2 (0,u) = (units!! (u-1))
    combine2 (1,u) = (teens!! u )
    combine2 (t,0) = (tens!! (t-2) )
    combine2 (t,u) = tens!! (t-2) ++ "-" ++(units!! (u-1) )

    convert3 n = combine3 ( digits3 n)
    digits3 n = (n `div` 100, n `mod` 100)

    combine3 (0,t) = (convert2 t)
    combine3 (h,0) = (units !! (h-1)) ++ " hundred"
    combine3 (h,t) = (units !! (h-1)) ++ " hundred and "++ (convert2 t)


    convert6 n = combine6 ( digits6 n )
    digits6 n = ( n `div` 1000 , n `mod` 1000)

    combine6 (0, h) = (convert3 h)
    combine6 (m, 0) = (convert3 m) ++ " thousand "
    combine6 (m, h) = (convert3 m) ++ " thousand" ++ (link h )++ (convert3 h)

    link h
        |h<100 = " and "
        |otherwise = " "

    convert_numbers :: Integer -> [Char]

    convert_numbers n 
        |n==0 = "zero "
        |n>=(10^3003) ="lots of "
        |n<=(10^3003) ="lots of "        
        |n<0 = "minus " ++ mini_convert (numerki (-n) 0 [] )
        |otherwise = mini_convert (numerki n 0 [] )     

    mini_convert :: [(Integer, Integer)] -> [Char]

    mini_convert [(0,0)] = ""
    mini_convert [] = ""
    mini_convert ((i,n):xs)
        |i>0 = (convert3 (fromIntegral n )) ++ (bignumber (fromIntegral n) (fromIntegral(i) - 1) ) ++ (mini_convert xs)
        |otherwise = (convert6 (fromIntegral n))++" "


    przedrostek k
        |k<10 = small!! k
        |otherwise = big k

    big k = biga!!(k`mod`10)++bigb!!((k`mod`100)`div`10)++bigc!!(k`div`100)

    small=["","mi","bi","try","kwadry","kwinty","seksty","septy","okty","noni"]
    biga=["","un","do","tri","kwatuor","kwin","seks","septen","okto","nowem"]
    bigb=["","decy","wicy","trycy","kwadragi","kwintagi","seksginty","septagi","oktagi","nonagi"]
    bigc=["","centy","ducenty","trycenty","kwadryge","kwinge"," sescenty","septynge","oktynge","nonge"]


    bignumber n i
        |n==0 = ""
        |n==1 = " "++(przedrostek i )++"lion "
        |otherwise = " "++(przedrostek i) ++ "lions "

    aud = Currency "Australian Dollar" "Australian Dollars" "Australian Dollars" None
    bgn = Currency "Lev" "Levs" "Levs" None
    brl = Currency "Real" "Reals" "Reals" None
    byr = Currency "Belarusian Ruble" "Belarusian Rubles" "Belarusian Rubles" None
    cad = Currency "Canadian Dollar" "Canadian Dollars" "Canadian Dollars" None
    chf = Currency "Swiss Franc" "Swiss Francs" "Swiss Francs" None
    cny = Currency "Yuan Renminbi" "Yuans Renminbi" "Yuans Renminbi" None
    czk = Currency "Czech Koruna" "Czech Korunas" "Czech Korunas" None
    dkk = Currency "Danish Krone" "Danish Krones" "Danish Krones" None
    eur = Currency "Euro" "Euros" "Euros" None
    gbp = Currency "British Pound" "British Pounds" "British Pounds" None
    hkd = Currency "Hongkong Dollar" "Hongkong Dollars" "Hongkong Dollars" None
    hrk = Currency "Kuna" "Kunas" "Kunas" None
    huf = Currency "Forint" "Forints" "Forints" None
    idr = Currency "Indonesian Rupiah" "Indonesian Rupees" "Indonesian Rupees" None
    isk = Currency "Icelandic Krona" "Icelandic Kronas" "Icelandic Kronas" None
    jpy = Currency "Yen" "Yens" "Yens" None
    krw = Currency "South Korean Won" "South Korean Wons" "South Korean Wons" None
    mxn = Currency "Mexican Peso" "Mexican Pesos" "Mexican Pesos" None
    myr = Currency "Ringgit" "Ringgits" "Ringgits" None
    nok = Currency "Norwegian Krone" "Norwegian Krones" "Norwegian Krones" None
    nzd = Currency "New Zealand Dollar" "New Zealand Dollars" "New Zealand Dollars" None
    php = Currency "Philippine Peso" "Philippine Pesos" "Philippine Pesos" None
    pln = Currency "Zloty" "Zlotys" "Zlotys" None
    ron = Currency "Romanian Leu" "Romanian Leus" "Romanian Leus" None
    rub = Currency "Russian Ruble" "Russian Rubles" "Russian Rubles" None
    sdr = Currency "Special Drawing Rights" "Special Drawing Rights" "Special Drawing Rights" None
    sek = Currency "Swedish Krona" "Swedish Kronas" "Swedish Kronas" None
    sgd = Currency "Singapore Dollar" "Singapore Dollars" "Singapore Dollars" None
    thb = Currency "Baht" "Bahts" "Bahts" None
    try = Currency "Turkish Lira" "Turkish Liras" "Turkish Liras" None
    uah = Currency "Hryvnia" "Hryvnias" "Hryvnias" None
    usd = Currency "US Dollar" "US Dollars" "US Dollars" None
    zar = Currency "Rand" "Rands" "Rands" None




{-char_to_int n
    |n==0 = "0"
    |n==1 = "1"
    |n==2 = "2"
    |n==3 = "3"
    |n==4 = "4"
    |n==5 = "5"
    |n==6 = "6"
    |n==7 = "7"
    |n==8 = "8"
    |n==9 = "9"
    |otherwise = char_to_int (n `div` 10) ++ char_to_int (n `mod` 10)-}

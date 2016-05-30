import Verbally
import System.Environment

main = do
	list <- getArgs
	let x = read (head(list)) :: Integer
	let z =head(tail(list)) 
  	putStrLn (verbally (strToCurr z) x )

strToCurr:: String -> Currency
strToCurr z
 |z=="AUD" = Currency "Australian Dollar" "Australian Dollars" "Australian Dollars" None
 |z=="BGN" = Currency "Lev" "Levs" "Levs" None
 |z=="BRL" = Currency "Real" "Reals" "Reals" None
 |z=="BYR" = Currency "Belarusian Ruble" "Belarusian Rubles" "Belarusian Rubles" None
 |z=="CAD" = Currency "Canadian Dollar" "Canadian Dollars" "Canadian Dollars" None
 |z=="CHF" = Currency "Swiss Franc" "Swiss Francs" "Swiss Francs" None
 |z=="CNY" = Currency "Yuan Renminbi" "Yuans Renminbi" "Yuans Renminbi" None
 |z=="CZK" = Currency "Czech Koruna" "Czech Korunas" "Czech Korunas" None
 |z=="DKK" = Currency "Danish Krone" "Danish Krones" "Danish Krones" None
 |z=="EUR" = Currency "Euro" "Euros" "Euros" None
 |z=="GBP" = Currency "British Pound" "British Pounds" "British Pounds" None
 |z=="HKD" = Currency "Hongkong Dollar" "Hongkong Dollars" "Hongkong Dollars" None
 |z=="HRK" = Currency "Kuna" "Kunas" "Kunas" None
 |z=="HUF" = Currency "Forint" "Forints" "Forints" None
 |z=="IDR" = Currency "Indonesian Rupiah" "Indonesian Rupees" "Indonesian Rupees" None
 |z=="ISK" = Currency "Icelandic Krona" "Icelandic Kronas" "Icelandic Kronas" None
 |z=="JPY" = Currency "Yen" "Yens" "Yens" None
 |z=="KRW" = Currency "South Korean Won" "South Korean Wons" "South Korean Wons" None
 |z=="MXN" = Currency "Mexican Peso" "Mexican Pesos" "Mexican Pesos" None
 |z=="MYR" = Currency "Ringgit" "Ringgits" "Ringgits" None
 |z=="NOK" = Currency "Norwegian Krone" "Norwegian Krones" "Norwegian Krones" None
 |z=="NZD" = Currency "New Zealand Dollar" "New Zealand Dollars" "New Zealand Dollars" None
 |z=="PHP" = Currency "Philippine Peso" "Philippine Pesos" "Philippine Pesos" None
 |z=="PLN" = Currency "Zloty" "Zlotys" "Zlotys" None
 |z=="RON" = Currency "Romanian Leu" "Romanian Leus" "Romanian Leus" None
 |z=="RUB" = Currency "Russian Ruble" "Russian Rubles" "Russian Rubles" None
 |z=="SDR" = Currency "Special Drawing Rights" "Special Drawing Rights" "Special Drawing Rights" None
 |z=="SEK" = Currency "Swedish Krona" "Swedish Kronas" "Swedish Kronas" None
 |z=="SGD" = Currency "Singapore Dollar" "Singapore Dollars" "Singapore Dollars" None
 |z=="THB" = Currency "Baht" "Bahts" "Bahts" None
 |z=="TRY" = Currency "Turkish Lira" "Turkish Liras" "Turkish Liras" None
 |z=="UAH" = Currency "Hryvnia" "Hryvnias" "Hryvnias" None
 |z=="USD" = Currency "US Dollar" "US Dollars" "US Dollars" None
 |z=="ZAR" = Currency "Rand" "Rands" "Rands" None
 |otherwise = Currency "Unknown Dollar" "Unknown Dollars" "Unknown Dollars" None

 
{-
module Main (main) where
import Verbally (Typeo(..), Currency(..), verbally) (Typeo(..), Currency(..), verbally)

main =currency `par` number `pseq` putStrLn (verbally currency number)

-}
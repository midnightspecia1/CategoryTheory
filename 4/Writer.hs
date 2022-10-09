import Data.Char

-- type alias for pair
type Writer a = (a, String)

-- morphisms are
-- a -> Writer b

(>=>) :: (a -> Writer b) -> (b -> Writer c) -> (a -> Writer c)
m1 >=> m2 = \x ->
    let (y, s1) = m1 x
        (z, s2) = m2 y
    in (z, s1 ++ s2)

return :: a -> Writer a
return x = (x, "")

upCase :: String -> Writer String
upCase s = (map toUpper s, "upCase ")

toWords :: String -> Writer [String]
toWords s = (words s, "toWords ")

process :: String -> Writer [String]
process = upCase >=> toWords
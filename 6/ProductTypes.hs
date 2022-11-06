
--product of the two types is the pair
--pair is not strictly comutative but 
--comutative up to isomorphism so isomorphism being given by the swap function
swap :: (a,b) -> (b,a)
swap (a,b) = (b,a)

--its like using different format to store same data
--like big/little endian

--to make product of some arbitrary number of types 
--we can nest pairs into each other
--for example combining 3 types a, b, c can be 
--(a, (b,c)) and ((a,b),c)
--this types are different but elements can map directly ot each other
alpha :: (a, (b,c)) -> ((a,b),c)
alpha (a,(b,c)) = ((a,b),c)

invAlpha :: ((a,b),c) -> (a,(b,c))
invAlpha ((a,b),c) = (a,(b,c))

--we can show that unit type () is the unit of the product
--same as the 1 for the multiplication
--pair with the unit type (a,()) dont add information to a type
rho :: (a,()) -> a
rho (x,()) = x

invRho :: a -> (a,())
invRho x = (x,())

--in haskell product types can be defined with named constructors like:
data Pair a b = Pair a b

smth :: Pair String Int
smth = Pair "wossup" 9

--product types with named fields is called a records i Haskell
--and structs in C
data Element = Element { name :: String,
                         symbol :: String,
                         atomicNumber :: Int }


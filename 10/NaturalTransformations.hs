-- to construct a natural tranformation we need some type a
-- two functors F and G that maps a to Fa and Ga
-- we have a component of the natural tranformation alfa

-- alpha :: forall a . F a -> G a
-- to use forall we need 
{-# LANGUAGE ExplicitForAll #-}
import Data.Functor.Const (Const (Const))
import Data.Functor.Contravariant (Contravariant (..))

-- so for every morphism in one category we have a comuting square diagram in other category
--           alfa a
-- a    Fa ---------> Ga
-- |    |             |
-- |    |             |
-- b    Fb ---------> Gb
--           alfa b

-- naturality condition with f :: a -> b 
--      Gf . alfa a = alfa b . Ff
-- fmapG f . alfa a = alfa b . fmapF f

-- https://bartoszmilewski.com/2014/09/22/parametricity-money-for-nothing-and-theorems-for-free/

-- some examples of natural tranformation
-- between List and Maybe functors

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

-- verifying the naturality condition for those two functors
-- fmap f . safeHead = safeHead . fmap f

-- empty list
-- fmap f (safeHead []) = fmap f Nothing = Nothing
-- safeHead (fmap f []) = safeHead [] = Nothing

-- non empty lsit
-- fmap f (SafeHead (x:xs)) = fmap f (Just x) = Just (f x)
-- safeHead (fmap f (x:xs)) = safeHead (f x : fmap f xs) = Just (f x)

-- another interesting case with Cons Int functor
-- we can define lenght function like this
length :: [a] -> Const Int a
length [] = 0
length (x : xs) = Const (1 + unConst (Main.length xs))

unConst :: Const Int a -> Int
unConst (Const x) = x

-- polimorphic function from Const
scam :: Const Int a -> Maybe a
scam (Const _) = Nothing

-- Reader big role in Yonneda lemma
newtype Reader r a = Reader (r -> a)

runR :: Reader r a -> r -> a
runR (Reader f) x = f x

instance Functor (Reader e) where
    fmap :: (a -> b) -> Reader e a -> Reader e b
    fmap f (Reader g) = Reader (\x -> f (g x))
-- for every type e we can define a family of natural tranformations from Reader e to any functor f

--alpha :: Reader () a -> Maybe a

dumb :: Reader () a -> Maybe a
dumb (Reader _) = Nothing

obvios :: Reader () a -> Maybe a
obvios (Reader g) = Just (g ())

-- function types are not covariant on the argument type (they are contravariant)

newtype Op r a = Op (a -> r)

runOp :: Op r a -> a -> r
runOp (Op f) x = f x

instance Contravariant (Op r) where
    contramap :: (b -> a) -> Op r a -> Op r b
    contramap f (Op g) = Op (\x -> g (f x))


predToStr :: Op Bool a -> Op String a
predToStr (Op f) = Op (\x -> if f x then "True" else "False")

ope :: Op Bool Int
ope = Op (\x -> x == 10)

-- a = contramap f ope

-- f :: Int -> Bool
-- f x = x == 10
-- those functors are not covariants that is not natural transformation in Hask cat
-- but it is in opposite cat, and there is a opposite natuaral condition
-- contramap f . predToStr = predToStr . contramap f

-- natural tranformation can be seen as a mappings between functors
-- there is one cat for every pair of cats C and D
-- object in this cat is a Functors, morphisms are the natural tranformations

-- levels of abstractions we learned so far
-- 1 level: categories that are collections of the objects and morphisms
-- 2 level: categories where objects is the categories themselfs and morphisms are functors (Cat), homeset in Cat are a set of functors Cat
-- Cat(C,D) - set of functors from C to D
-- 3 level: functor cat [C,D] is also a set of functors with natural tranformations between them as morphisms

--10.6.1 defined natural tranformation from Maybe to List Functor
some :: Maybe a -> [a]
some Nothing = []
some (Just x) = [x]

sF :: Int -> Bool
sF i = i == 0

-- fmapG f . some = some . fmapF f
-- fmapG f (some Nothing) = fmapG f [] = []
-- some (fmapF f Nothing) = some Nothing = []

-- fmapG f (some (Just x)) = fmapG f [x] = [(f x)]
-- some (fmapF f (Just x)) = some (Just (f x)) = [(f x)]
-- naturality condition proved

--10.6.2 two different natural transformation between Reader () and [] functors

alfa :: Reader () a -> [a]
alfa (Reader g) = [g ()] 
 
betta :: Reader () a -> [a]
betta (Reader g) = []

--10.6.3 made it with Reader Bool and Maybe

gamma :: Reader Bool a -> Maybe a
gamma (Reader g) = Nothing

delta :: Reader Bool a -> Maybe a
delta (Reader g) = Just (g True)

epsilon :: Reader Bool a -> Maybe a
epsilon (Reader g) = Just (g False)

tetta :: Reader Bool a -> Reader String a
tetta (Reader g) = Reader (\x -> g True)

tF :: Bool -> String
tF True = "String"
tF False = "False"

t1 :: Reader String String
t1 = fmap tF . tetta $ (Reader not)

t2 :: Reader String String
t2 = tetta . fmap tF $ (Reader not)

--10.6.6 
-- predToStr :: Op Bool a -> Op String a
-- predToStr (Op f) = Op (\x -> if f x then "True" else "False")

-- instance Contravariant (Op r) where
--     contramap :: (b -> a) -> Op r a -> Op r b
--     contramap f (Op g) = Op (\x -> g (f x))

--newtype Reader r a = Reader (r -> a)
--newtype Op r a     = Op (a -> r)

op :: Op Bool Int
op = Op (\x -> x > 0)

f :: String -> Int
f x = read x

--contramap :: (String -> Int) -> Op r Int -> Op r String
a :: Op String String
a = zeta . contramap f $ op

b :: Op String String
b = contramap f . zeta $ op

zeta :: Op Bool a -> Op String a
zeta (Op g) = Op (\x -> if g x then "T" else "F")

testNatCond :: Bool
testNatCond = let one = runOp a "1"
                  two = runOp b "1"
              in one == two 
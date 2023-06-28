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
newtype Reader e a = Reader (e -> a)

instance Functor (Reader e) where
    fmap f (Reader g) = Reader (\x -> f (g x))
-- for every type e we can define a family of natural tranformations from Reader e to any functor f

--alpha :: Reader () a -> Maybe a

dumb :: Reader () a -> Maybe a
dumb (Reader _) = Nothing

obvios :: Reader () a -> Maybe a
obvios (Reader g) = Just (g ())

-- function types are not covariant on the argument type (they are contravariant)

newtype Op r a = Op (a -> r)

instance Contravariant (Op r) where
    contramap :: (b -> a) -> Op r a -> Op r b
    contramap f (Op g) = Op (\x -> g (f x))

predToStr :: Op Bool a -> Op String a
predToStr (Op f) = Op (\x -> if f x then "True" else "False")
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

-- fmapG f . some = some . fmapF f
-- fmapG f (some Nothing) = fmapG f [] = []
-- some (fmapF f Nothing) = some Nothing = []

-- fmapG f (some (Just x)) = fmapG f [x] = [(f x)]
-- some (fmapF f (Just x)) = some (Just (f x)) = [(f x)]
-- naturality condition proved

--10.6.2 two different natural transformation between Reader () and [] functors

natTransformOne :: Reader () a -> [a]
natTransformOne (Reader g) = [g ()]

natTransformTwo :: Reader () a -> [a]
natTransformTwo (Reader g) = []

--10.6.3 made it with Reader Bool and Maybe

natTransformThree :: Reader Bool a -> Maybe a
natTransformThree (Reader g) = Nothing

natTransformFour :: Reader Bool a -> Maybe a
natTransformFour (Reader g) = Just (g True)

natTransformFive :: Reader Bool a -> Maybe a
natTransformFive (Reader g) = Just (g False)
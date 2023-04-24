{-# LANGUAGE InstanceSigs #-}
import Data.Functor.Identity (Identity)
import Data.Functor.Const (Const)


class Bifunctor f where
    bimap :: (a -> c) -> (b -> d) -> (f a b -> f c d)
    bimap g h i = (first g . second h) i

    first :: (a -> c) -> f a b -> f c b
    first g i = bimap g id i

    second ::(b -> d) -> f a b -> f a d
    second h i = bimap id h i

    -- bifunctor is a mapping from category A and category B to category C; (A,B)->C
    -- in general case we can check functoriality of the 

instance Bifunctor (,) where
    -- bimap :: (a -> c) -> (b -> d) -> (a, b) -> (c, d)
    -- bimap f h (a, b) = (f a, h b)

    first :: (a -> c) -> (,) a b -> (,) c b
    first f (a,b) = (f a, b)

    second :: (b -> d) -> (,) a b -> (,) a d
    second f (a,b) = (a, f b)

instance Bifunctor Either where
    bimap f _ (Left a)  = Left $ f a
    bimap _ g (Right b) = Right $ g b


-- showing that the Maybe it's just ADT with two simple functors
-- Nothing - Const () a - just ignores the Maybe type argument
-- Just a  - Identity a - simple container that store one immutable value of Maybe param type
type Maybe a = Either (Const () a) (Identity a)
-- Maybe it's the composition of the bifuntor Either and two functors Const() and Identity

-- composition of the functors is also a functor
-- same is true for bifunctors
newtype BiComp bf fu gu a b = BiComp (bf (fu a) (gu b))
-- bf    - bifunctor
-- fu gu - functors
-- a b   - regular types


--a = BiComp (Either (Const ()) (Identity a))
instance (Bifunctor bf, Functor fu, Functor gu) =>
    Bifunctor (BiComp bf fu gu) where
        bimap :: (Bifunctor bf, Functor fu, Functor gu) => (a -> c) -> (b -> d) -> BiComp bf fu gu a b -> BiComp bf fu gu c d
        bimap f g (BiComp x) = BiComp (bimap (fmap f) (fmap g) x)

-- so we goind from (BiComp bf fu gu a b) -> (BiComp bf fu gu c d)
-- bimap foind trough the first layer - bifunctor layer
-- two fmaps goind though the second layer - layers of the functors

-- dont't need to prove that the maybe is a functor
-- it is folows from the fact that it's sum of the two functorial primitives

-- compiler can automaticly define Functor for the algebraic data types
-- { -# LANGUAGE DeriveFunctor #- }
-- data Maybe a = Nothing | Just a deriving Functor
-- somehow we can teach the compiler automaticly derive instances of your own type classes ????

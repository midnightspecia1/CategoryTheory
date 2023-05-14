{-# LANGUAGE InstanceSigs #-}
import Data.Bifunctor
import Data.Functor.Identity (Identity)
import Control.Applicative (Const)

--8.9.1 Show that Pair a b is a bifunctor
data Pair a b = Pair a b

-- to prove that the Pair a b is a bifunctor we need to prove functoriality (that is preserves id and composition) 
-- separatly for the first and second argument

instance Functor (Pair a) where
    fmap f (Pair a b) = Pair a (f b)

--preserving id
-- fmap id (Pair a b) ~>
-- Pair a (id b) ~>
-- Pair a b 

--preserving composititon
-- (fmap f . fmap g) (Pair a b) = fmap (f . g)
-- fmap f (fmap g (Pair a b) ~>
-- fmap f (Pair a (g b)) ~>
-- Pair a (f(g b)) ~>
-- Pair a ((f . g) b)                                  (same)
-- fmap (f . g) (Pair a b) ~>
-- Pair a ((f . g) b)                                  (same)

-- same proof goes to the second argument of the Pair a b

instance Bifunctor Pair where
    bimap :: (a -> b) -> (c -> d) -> Pair a c -> Pair b d
    bimap x y (Pair a b) = Pair (x a) (y b)

    first :: (a -> b) -> Pair a d -> Pair b d
    first x (Pair a b) = Pair (x a) b

    second :: (c -> d) -> Pair a c -> Pair a d
    second y (Pair a b) = Pair a (y b)

-- we can apply equational reasoning
-- when we define only first and second
-- in bimap x y (Pair a b) ~> 
-- (first x . second y) (Pair a b) ~>
-- second y (Pair a b) ~>
-- Pair a (y b) ~>                              (second same)
-- first x (Pair a (y b)) ~> here we can imagine (y b) as a d
-- first x (Pair a b) ~>
-- Pair (x a) (id b) ~>
-- Pair (x a) b                                  (first same)

-- when we define only bimap 
-- first x (Pair a b) ~>
-- bimap x id (Pair a b) ~>
-- Pair (x a) (id b) ~>
-- Pair (x a) b                                  (first same)

-- second y (Pair a b) ~>
-- bimap id y (Pair a b) ~>
-- Pair (id a) (y b) ~>
-- Pair a (y b)                                 (second same)

--8.9.2 Show Isomorphism with standart Maybe definition and the given desugared one
data Maybe  a = Nothing | Just a                    -- standart
type Maybe' a = Either (Const () a) (Identity a)    -- desugared

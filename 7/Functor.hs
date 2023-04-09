
-- catehegory C got two objects a and b
-- so in cathegory D we have two images of those objects Fa and Fb
-- in C we have morphism f :: a -> b
-- in D we have morphism Ff :: Fa -> Fb  so this is the functor (the image of the morphism in other cathegory)

-- if we have composition h :: f.g
-- we need an image of this ocmposition Fh :: Fh.Fg

-- we want indentity morphisms in C to be mapped to identity morphisms in D
-- Fida = idFa

-- FUNCTORS MUST PRESERVE THE STRUCTURE OF THE CATHEGORY

-- when we have morphism f :: a -> b 
-- functor of that morphism would be consist of 
-- 1. image a
-- 2. image b
-- 3. image f
-- so Maybe as example 

-- image a = Maybe a
-- image b = Maybe b
-- image f = Maybe a -> Maybe b
{-# LANGUAGE InstanceSigs #-}

fmap :: (a -> b) -> Maybe a -> Maybe b
fmap _ Nothing = Nothing
fmap f (Just a) = Just (f a)

-- to show that the fmap and Maybe type constrcutor form functor 
-- we need to prove that fmap preserves identity and composition - the functor laws

-- equational reasoning - we can replace(inline) expressions vise versa
-- like id a = a or a = id a

--starting from fmap id = id


-- LIST FUNCTOR
data List a = Nil | Cons a (List a)

instance Functor List where
    fmap :: (a -> b) -> List a -> List b
    fmap _ Nil = Nil
    fmap f (Cons x xs) = Cons (f x) (Prelude.fmap f xs)

-- READER FUNCTOR
-- instance Functor ((->) r) where
--     fmap :: (a -> b) -> (r -> a) -> (r -> b)
--     fmap f r = f . r
-- it is defined in GHC.Base

-- FUNCTORS AS CONTAINERS
-- FUNCTOR CONST
data Const a c = Const a

instance Functor (Const c) where
    fmap :: (a -> b) -> Const c a -> Const c b
    fmap _ (Const v) = Const v

constSome :: Const Int Double
constSome = Const 3

-- FUNCTOR COMPOSITION
maybeTail :: [a] -> Maybe [a]
maybeTail [] = Nothing
maybeTail (x:xs) = Just xs

square x = x * x

mis :: Maybe [Int]
mis = Just [1, 2, 3]

mis2 = (Prelude.fmap . Prelude.fmap) square mis 

-- 7.4.1 can we turn Maybe type constructor into the functor defining
-- fmap _ _ = Nothing
-- we have to prove "the functor laws" that this fmap implementation preserve identity and composition
-- identity
--   id _   = _            -we have any value here
-- fmap _ _ = Nothing      -but only nothing here - so already identity law not preserved

-- 7.4.2 functor laws for reader functor
-- IDENTITY
--      id r          = r (r :: a -> b)
-- fmap id r = id . r = r  identity law preserved
-- COMPOSITION
-- fmap (f . g) r = (fmap f . fmap g) r  -- f :: b -> c,  g :: a -> b
-- f . g = h :: a -> c
-- fmap h r = y :: r -> c
--                   fmap g r = x :: r -> b
--                   fmap f x = y :: r -> c
-- composition preserved
{-# LANGUAGE InstanceSigs #-}
import Data.Bifunctor
import Data.Functor.Identity (Identity (Identity))

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
--data Maybe  a = Nothing | Just a                    -- standart
type Maybe' a = Either (Const () a) (Identity a)    -- desugared

newtype Const c a = Const c

instance Functor (Const c) where
    fmap :: (a -> b) -> Const c a -> Const c b
    fmap _ (Const a) = Const a

maybeToEitherMaybe :: Maybe a -> Maybe' a
maybeToEitherMaybe Nothing = Left (Const ())
maybeToEitherMaybe (Just a) = Right (Identity a)

eitherMaybeToMaybe :: Maybe' a -> Maybe a
eitherMaybeToMaybe (Left (Const ())) = Nothing
eitherMaybeToMaybe (Right (Identity a)) = Just a

-- if this two functions inverse of each other we considering this
-- maybeToEitherMaybe . eitherMaybeToMaybe = id
-- eitherMaybeToMaybe . maybeToEitherMaybe = id

-- we have only two variants of the input for both functions

-- (maybeToEitherMaybe . eitherMaybeToMaybe) (Left (Const ())) = id (Left (Const ()))
-- eitherMaybeToMaybe (Left (Const ())) = Nothing
-- maybeToeitherMaybe Nothing = (Left (Const ()))         (1 same)
-- id (Left (Const ())) = (Left (Const ()))               (1 same)  

-- (maybeToEitherMaybe . eitherMaybeToMaybe) (Right (Identity a)) = id (Right (Identity a))
-- eitherMaybeToMaybe (Right (Identity a)) = Just a
-- maybeToEitherMaybe (Just a) = (Right (Identity a))     (2 same)
-- id (Right (Identity a)) = (Right (Identity a))         (2 same)

-- (eitherMaybeToMaybe . maybeToEitherMaybe) Nothing = id Nothing
-- maybeToEitherMaybe Nothing = Left (Const ())
-- eitherMaybeToMaybe (Left (Const ())) = Nothing         (3 same)
-- id Nothing = Nothing                                   (3 same)

-- (eitherMaybeToMaybe . maybeToEitherMaybe) (Just a) = id (Just a)
-- maybeToEitherMaybe Nothing = Right (Identity a)
-- eitherMaybeToMaybe (Right (Identity a)) = Just a       (4 same)
-- id (Just a) = Just a                                   (4 same)

-- with all inputs equations are true => Maybe and Maybe' the same up to isomorphism

--8.9.3 show that given PreList is an instance of the Bifunctor
data PreList a b = Nil | Cons a b
-- another time we need to prove functoriality of the type arguments separately
instance Bifunctor PreList where
    bimap :: (a -> d) -> (b -> c) -> PreList a b -> PreList d c
    bimap _ _ Nil = Nil
    bimap f g (Cons a b) = Cons (f a) (g b)

    first :: (a -> d) -> PreList a b -> PreList d b
    first f Nil = undefined
    first f (Cons a b) = Cons (f a) b

    second :: (b -> c) -> PreList a b -> PreList a c
    second g Nil = Nil
    second g (Cons a b) = Cons a (g b)

-- preserving id
-- bimap id id (Cons a b) =                          (1 same)
-- Cons (id a) (id b) =
-- Cons a b                                          (1 same)
-- bimap id id Nil                                   (2 same)
-- Nil                                               (2 same)

-- preserving composition
-- (bimap f g . bimap h j) (Cons a b) =
-- bimap h j (Cons a b) = 
-- Cons (h a) (j b)
-- bimap f g (Cons (h a) (j b)) = 
-- Cons ((f . h) a) ((g . j) b)
-- bimap (f . h) (g . j) (Cons a b)

-- (bimap f g . bimap h j) Nil =
-- Nil
-- bimap (f . h) (g . j) Nil
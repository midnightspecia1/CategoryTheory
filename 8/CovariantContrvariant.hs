
-- (->) r
-- Reader functor
{-# LANGUAGE InstanceSigs #-}

newtype Reader r a = Reader { run :: r -> a }

instance Functor (Reader r) where
    fmap f g = Reader (f . run g)

newtype Op r a = Op { runOp :: a -> r }
-- to check functoriality by the first argument we need implement fmap with signature
-- (check is it possible to make it Functor instance)
-- fmap :: (a -> b) -> (a -> r) -> (b -> r)
-- its not possible to construct b -> r from this two functions a -> b and a -> r
-- we can go to the opposite category 
-- RECAP: every category C has the opposite category Cop where all arrows flipped

-- conisder that we have 
-- f   :: b -> a    (Category C)
-- fop :: a -> b to (Cetgory Cop)
-- Ffop:: Fa -> Fb  (just a functor from Cop to D)

-- here we have a mapping G from C to D (its's not a functor)
-- Gf :: (b -> a) -> (Ga -> Gb) 
-- mapping of the function that is chages direction of the morphisms is called Contravariant functors
-- regular Functors is called Covariant

-- typeclass defining Contravariant functor
class Contravariant f where
    contramap :: (b -> a) -> (f a -> f b)

instance Contravariant (Op r) where
    contramap :: (b -> a) -> Op r a -> Op r b
    contramap f g = Op (runOp g . f) 

-- in the standart prelude exist function
flip :: (a -> b -> c) -> (b -> a -> c)
flip f x y = f y x

-- with it we can define contramap 
-- instance Contravariant (Op r) where
--     contramap f g = flip (.)
-- but this onyl works on the ideomatic Op definition like
-- type Op r a = r -> a
-- for some reason I can't define intance for the type synonim
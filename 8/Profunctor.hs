--function-arrow operator is contravariant to first argument 
--and covariant to the second
--and it is called a Profunctor (if the target category is Set)
    -- Set - category where the objects is the sets and morphisms is the functions(Haskell types are sets)
{-# LANGUAGE InstanceSigs #-}

class Profunctor p where
    dimap :: (a -> b) -> (c -> d) -> p b c -> p a d
    dimap f g = lmap f . rmap g
    lmap :: (a -> b) -> p b c -> p a c
    lmap f = dimap f id
    rmap :: (b -> c) -> p a b -> p a c
    rmap g = dimap id g

-- assert that the function-arrow operator is an instance of the Profunctor
instance Profunctor (->) where
    dimap :: (a -> b) -> (c -> d) -> (b -> c) -> a -> d
    dimap ab cd bc = cd . bc . ab

    lmap :: (a -> b) -> (b -> c) -> a -> c
    lmap = flip (.)

    rmap :: (b -> c) -> (a -> b) -> a -> c
    rmap = (.)

-- Profunctors is something htat is used in the lens (some fancy and hard Haskell library)
-- will be extended when we met end and coends

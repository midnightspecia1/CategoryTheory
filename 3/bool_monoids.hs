{-# LANGUAGE InstanceSigs #-}

data Any' = Any' { getAny :: Bool } deriving Show
instance Semigroup Any' where
    (<>) :: Any' -> Any' -> Any'
    (Any' x) <> (Any' y) = Any' (x || y) 

instance Monoid Any' where 
    mempty :: Any'
    mempty = Any' False


data All' = All' { getAll :: Bool } deriving Show
instance Semigroup All' where
    (All' x) <> (All' y) = All' (x && y) 

instance Monoid All' where
    mempty = All' True


data Equal = Equal { isEqual :: Bool } deriving Show
instance Semigroup Equal where
    (Equal x) <> (Equal y) = Equal (x == y)

instance Monoid Equal where
    mempty = Equal True

data NEqual = NEqual { isNotEqual :: Bool } deriving Show
instance Semigroup NEqual where
    (NEqual x) <> (NEqual y) = NEqual (x /= y)

instance Monoid NEqual where
    mempty = NEqual False
       
data SMT = Zero | One | Two deriving Show
instance Semigroup SMT where 
    (<>) :: SMT -> SMT -> SMT
    One  <> Two  = Zero
    One  <> One  = Two
    One  <> Zero = One
    Zero <> Two  = Two
    Zero <> One  = One
    Zero <> Zero = Zero
    Two  <> Zero = Two
    Two  <> One  = Zero
    Two  <> Two  = Two

instance Monoid SMT where
    mempty :: SMT
    mempty = Zero
    


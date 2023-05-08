
-- (->) r
-- Reader functor

newtype Reader r a = Reader { run :: r -> a }

instance Functor (Reader r) where
    fmap f r = Reader (f . run r)

newtype Op r a = Op { runOp :: a -> r }

-- to check functoriality by the first argument we need implement fmap with signature
-- fmap :: (a -> b) -> (a -> r) -> (b -> r)

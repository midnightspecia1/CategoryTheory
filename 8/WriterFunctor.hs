

type Writer a = (a, String)
-- Kleisly category a -> k b
-- how Kleisly category relates to functors

-- Kleisly cat defined composition and identity 
-- composition:
(>=>) :: (a -> Writer b) -> (b -> Writer c) -> (a -> Writer c)
m1 >=> m2 = \x -> 
            let (y, s1) = m1 x
                (z, s2) = m2 y
    in (z, s1 ++ s2)

--identity:
return :: a -> Writer a
return x = (x, "")

fmap :: (a -> b) -> Writer a -> Writer b
fmap f = id >=> (\x -> Main.return (f x))
-- id (Writer a) = Writer a = (x, "some")
-- (\x ->...) x  = Writer (f x, "")
--                 Writer (f x, "some" ++ "")

-- so with any type constructor which has embelishment(>=>) and return defined
-- we can run fmap aswell
-- but not every funtor give rise to Kleisly category
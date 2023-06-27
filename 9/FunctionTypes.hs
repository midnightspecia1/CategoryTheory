
curry :: ((a,b) -> c) -> (a -> b -> c)
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> ((a,b) -> c)
uncurry f (x, y) = f x y

factorizer :: ((a,b) -> c) -> (a -> (b -> c))
factorizer g = \a -> (\b -> g (a, b))

foo :: (String, String) -> Int
foo (s1, s2) = length s1 + length s2

bar :: String -> String -> Int
bar = Main.curry foo

-- foo :: (String, String) -> Int
-- foo = Main.uncurry bar 

baz :: String -> Int
baz = bar "s"


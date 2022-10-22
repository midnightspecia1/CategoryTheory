
-- Product of the Int and Bool
-- candidate for this product can be for example Int
-- p :: Int -> Int
-- p x = x

-- q :: Int -> Bool
-- q _ = True

-- or can be tripple (Int, Int, Bool)
pp :: (Int, Int, Bool) -> Int
pp (x, _, _) = x

qq :: (Int, Int, Bool) -> Bool
qq (_, _, b) = b
-- or can be something else

-- to rank this patterns (universal constructions)
-- we can have morphism m from c' to c with p' and q' projections
-- p' = p . m
-- q' = q . m

m :: Int -> (Int, Bool)
m x = (x, True)

p' :: Int -> Int
p' x = fst (m x)

q' :: Int -> Bool
q' x = snd (m x)

-- but opposite thing is not possible 
-- we can't have some m' to reconstruct fst and snd 
-- fst = p' . m'
-- snd = q' . m'

-- for the first example with Int candidate we see that q can be True or False
-- for the second we skip second field in tripple so
-- m' (x, b) = (x, x, b)
-- or
-- m' (x, b) = (x, 23, b)
-- so we can put anything in place of the second field

-- any type c with two projections p and q, there is unique m from c to cartezian product (a, b)
-- that factorizes them
-- m :: c -> (a, b)
-- m x = (p x, q x)

-- higher orded function that produces factorized thing
factorizer :: (c -> a) -> (c -> b) -> (c -> (a, b))
factorizer p q = \x -> (p x, q x)


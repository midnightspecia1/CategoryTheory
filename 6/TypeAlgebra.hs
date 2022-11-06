-- a * 0 = 0
-- so product type of Void some type is isomoprhic to Void 
-- (a, Void) we can have any value as a type a but
-- we cant create a value of type Void
-- so (a, Void) = Void

-- distributive property of the addition and multiplication
-- a * (b + c) = (a * b) + (a * c)
-- this property is also hold on sum and product types
-- (a, Either b c) = Either (a, b) (a, c)
-- and its up to isomorphism

prodToSum :: (a, Either b c) -> Either (a, b) (a, c)
prodToSum (x, e) = 
    case e of
        Left l -> Left (x, l)
        Right r -> Right (x, r)

sumToProd :: Either (a, b) (a, c) -> (a, Either b c)
sumToProd e = 
    case e of
        Left (x, l) -> (x, Left l)
        Right (x, r) -> (x, Right r)

-- Mathmaticians called this two intertvined monoids semiring or rig (without n(negative) - because there is no substraction)
-- we can translete some rigs like natural numbers to the types
-- 0            Void
-- 1            ()
-- a + b        Either a b = Left a | Right b
-- a * b        (a, b) or Pair a b = Pair a b
-- 2 = 1 + 1    data Bool = True | False
-- 1 + a        data Maybe = Nothing | Just a

-- List
data List a = Nil | Cons a (List a)
-- replacing List a with x leads to 
-- x = 1 + a * x
-- we can substitute further 
-- x = 1 + a * (1 + a * x) = 1 + a + a*a*x
-- x = 1 + a + a*a*(1 + a * x) = 1 + a + a*a + a*a*a*x
-- List a = Nil | Cons (Cons (Cons a (List a)))...
-- end up with infinite sum of products which is either
-- empty - 1
-- singleton a
-- pair of (a, a) tripple (a, a, a) and further

-- product of a and b -> a and b must be inhabited
-- sum of a and b -> one of the values can be uninhabited
-- logical and and or also form a semiring and it too can be mapped into type theory
-- false        Void
-- true         ()
-- a || b       Either a b = Left a | Right b
-- a && b       (a, b) or Pair a b = Pair a b

-- this analogy goes deeper and leads to Curry-Hovard isomorphism


-- 6.1 isomorphism between Maybe a and Either () a
isoMtoE :: Maybe a -> Either () a
isoMtoE m = 
    case m of
        Nothing -> Left ()
        Just a -> Right a

isoEtoM :: Either () a -> Maybe a
isoEtoM e = 
    case e of
        Left () -> Nothing
        Right a -> Just a

-- 6.2
data Shape = Circle Float
           | Rect Float Float
           | Square Float

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rect d h) = d * h
area (Square h) = h * h

--implemented c++ interaface Shape, Rect and Circle objects

-- 6.3
circ :: Shape -> Float
circ (Circle r) = 2.0 * pi * r
circ (Rect d h) = 2.0 * (d + h)
circ (Square h) = h * 4
-- to implement this we dont touch the Shape type code
-- in C++ i have to add circ method in the Shape class besides the overrides in each of the child classes

-- 6.4
-- to add new Shape in Haskell i edit the sum type Shape and edit all the methods that are patternmathing this type
-- however in C++ i only need to create another class Square and implement all the needed methods

-- 6.5
-- a + a = a * 2
-- Either a a = (a, Bool)

s :: Either a a -> (a, Bool)
s e = 
    case e of
        Left a -> (a, True)
        Right a -> (a, False)

p :: (a, Bool) -> Either a a
p (a, True) = Left a
p (a, False) = Right a
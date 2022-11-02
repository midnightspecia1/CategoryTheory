
-- coproducts works in an opposite way ofr the products
-- i :: a -> c
-- j :: b -> c

-- i' = m . i
-- j' = m . j

-- in Haskell we can create tagged union by separating data constructors with |
data Contact = PhoneNum Int | EmailAdr String

helpdesk :: Contact
helpdesk = PhoneNum 9999999

hospital :: Contact
hospital = EmailAdr "hosp@hsp.com"

-- canonical implementation of the product in Haskell is the simple pair (a, b)
-- implementation of the coproduct defined as type Either
-- data Either a b = Left a | Right b (defined in standart Prelude)

factorizerC :: (a -> c) -> (b -> c) -> Either a b -> c
factorizerC i j (Left a) = i a
factorizerC i j (Right b) = j b

-- 5.8.1 - Terminal object has one and only one morphism goind from any object to it 
--         being unique up to unique isomorphism means that all the obejects has the same structure
--         
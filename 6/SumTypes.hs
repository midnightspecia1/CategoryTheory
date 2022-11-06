--canonical implementation of the sum type is 
data Either a b = Left a | Right b

--like product types, sum types can be nested in each other
data OneOfThree a b c = One a | Two b | Three c

--Set is also monoidal cathegory with respect to coproduct 
--role of the binary operator is played by the disjoint sum 
--and the role of the unit element is the initial object 
--in terms of types Either is the monoidal operator
--and Void is the neutral element

--adding Void doesnt change value
--Either a Void
--we cant construct the Right version so the only inhabitants of this sum
--constructed via Left

--in C++ sum types not that common than in Haskell
--and mostly implemented with a spcial tricks and impossible values
--like empty strings, negative numbers, null pointers
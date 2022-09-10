
memoize :: (Ord a) => (Int -> a) -> (Int -> a)
memoize f = (map f [0 ..] !!)
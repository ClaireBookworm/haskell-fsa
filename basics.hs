-- basics of haskell to understand the syntax & exercises found online

divisors :: Integer -> [Integer]
divisors n = [x | x <- [1..n], n `mod` x == 0]


addTuple :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)
addTuple (x,y) (a,b) -> (x+a, y+b)

-- Use pattern matching to create a function that takes two integer lists
-- and swaps their first elements. If either list is empty, do nothing. (exercises!)
swapFirstTwo :: [Integer] -> [Integer]
swapFirstTwo [] = []
swapFirstTwo [x] = [x]
swapFirstTwo (x:y:xs) = y:x:xs

weirdFunction :: [Integer] -> Integer
weirdFunction [] = 0

swapFirst :: [Integer] -> [Integer] -> ([Integer], [Integer])
swapFirst (x:xs) (y:ys) = (y:xs, x:ys)
swapFirst [] bs = ([], bs)

-- math in haskell


compareVols :: Double -> Double -> Double -> Bool
compareVols a b c = sphereVol a + sphereVol b > c^3
	where sphereVol r = 4/3 * pi * r^2

-- recursion

factorial :: Integer -> Integer
factorial 0 = 1

factorial2 :: Integer -> Integer
factorial n = product[1..n]

-- string manipulation (could be useful for some of the input string elements)
reverseSome :: [String] -> [String]
reverseSome strings = [if s :: 0 == 'r'
						then reverse s
						else s
					| s <- strings]

-- list comprehension ( take in element, use set notation to check if it is true & do it )

isSquare :: Integer -> Bool
isSquare n = n `elem` [x^2 | x <- [0..n]]
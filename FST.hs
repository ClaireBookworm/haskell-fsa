-- this doesn't really work 

data Bit = Zero | One
  deriving (Show, Eq)

data Decimal = D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | D9
  deriving (Show, Eq)

-- ^^ stupid solution, but brute force works (?) 

-- Finite State Transducer to convert from decimal to binary
decimalToBinary :: FST Decimal Bit
decimalToBinary = [ (D0, Zero), (D1, One), (D2, Zero), (D3, One), (D4, Zero)
                  , (D5, One), (D6, Zero), (D7, One), (D8, Zero), (D9, One)
                  ]
-- this is a really stupid solution to fix error:
-- Expected kind ‘* -> * -> *’, but ‘FST’ has kind ‘*’

-- A function to apply a FST to a list of input symbols
applyFST :: Eq a => FST a b -> [a] -> Maybe [b] -- is this type signature valid? likely source of error
applyFST [] _ = Just []
applyFST _ [] = Nothing
applyFST fst ((x:xs)) =
  case lookup x fst of
    Just y -> case applyFST fst xs of
                Just ys -> Just (y:ys)
                Nothing -> Nothing
    Nothing -> Nothing -- keeps outputting nothing 

-- the MAYBE type is
-- data Maybe a = Just a | Nothing
--     deriving (Eq, Ord)


main :: IO ()
main = do
  -- Convert binary "1101" to decimal
  let binaryInput = [One, One, Zero, One]
      decimalOutput = applyFST binaryToDecimal binaryInput
  putStrLn $ "Binary Input: " ++ show binaryInput
  putStrLn $ "Decimal Output: " ++ show decimalOutput

  -- Convert decimal "8" to binary
  let decimalInput = D8
      binaryOutput = applyFST decimalToBinary [decimalInput]
  putStrLn $ "Decimal Input: " ++ show decimalInput
  putStrLn $ "Binary Output: " ++ show binaryOutput

-- OUTPUT
-- Ok, one module loaded.
-- Binary Input: [One,One,Zero,One]
-- Decimal Output: Nothing
-- Decimal Input: D8
-- Binary Output: Nothing

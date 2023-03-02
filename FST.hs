-- this doesn't really work 

-- OUTPUT
-- Ok, one module loaded.
-- Binary Input: [One,One,Zero,One]
-- Decimal Output: Nothing
-- Decimal Input: D8
-- Binary Output: Nothing

type State = String

type Alphabet = Char

type Transition = (State, Alphabet, State)

-- data FST = FST
--   { states :: [State],
--     alphabetIn :: [Alphabet],
--     alphabetOut :: [Alphabet],
--     transitions :: [(Transition)],
--     initialState :: State,
--     finalStates :: [State]
--   }

-- data Bit = Zero | One

-- type Binary = [Bit]

-- type Decimal = Int

-- data BST = Q0 | Q1 Decimal | Q2 Decimal Binary

-- binaryToDecimal :: FST Bit Decimal
-- binaryToDecimal =
--   FST
--     { states = [Q0, Q1 0, Q2 0 []],
--       alphabetIn = [Zero, One],
--       alphabetOut = [],
--       transitions =
--         [ (Q0, Zero, Q0, []),
--           (Q0, One, Q1 1, []),
--           (Q1 n, Zero, Q1 (2 * n), []),
--           (Q1 n, One, Q1 (2 * n + 1), []),
--           (Q1 n, End, Q2 n [], [n]),
--           (Q2 n b, Zero, Q2 (2 * n) (b ++ [Zero]), []),
--           (Q2 n b, One, Q2 (2 * n + 1) (b ++ [One]), [])
--         ],
--       initialState = Q0
--     }

-- decimalToBinary :: FST Decimal Binary
-- decimalToBinary =
--   FST
--     { states = [Q0, Q1 0, Q2 []],
--       alphabetIn = [],
--       alphabetOut = [Zero, One],
--       transitions =
--         [ (Q0, End, Q1 0, []),
--           (Q1 n, End, Q2 (reverse (toBits n)), []),
--           (Q2 [], Zero, Q2 [], [Zero]),
--           (Q2 [], One, Q2 [], [One]),
--           (Q2 (b : bs), Zero, Q2 bs, [Zero]),
--           (Q2 (b : bs), One, Q2 bs, [One])
--         ],
--       initialState = Q0
--     }
--   where
--     toBits 0 = []
--     toBits n = let (q, r) = n `divMod` 2 in toBits q ++ [if r == 0 then Zero else One]

data Bit = Zero | One
  deriving (Show, Eq)

data Decimal = D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | D9
  deriving (Show, Eq)

-- Finite State Transducer to convert from decimal to binary
decimalToBinary :: FST Decimal Bit
decimalToBinary = [ (D0, Zero), (D1, One), (D2, Zero), (D3, One), (D4, Zero)
                  , (D5, One), (D6, Zero), (D7, One), (D8, Zero), (D9, One)
                  ]
-- this is a really stupid solution to fix error:
-- Expected kind ‘* -> * -> *’, but ‘FST’ has kind ‘*’

-- A function to apply a FST to a list of input symbols
applyFST :: Eq a => FST a b -> [a] -> Maybe [b]
applyFST [] _ = Just []
applyFST _ [] = Nothing
applyFST fst ((x:xs)) =
  case lookup x fst of
    Just y -> case applyFST fst xs of
                Just ys -> Just (y:ys)
                Nothing -> Nothing
    Nothing -> Nothing -- keeps outputting nothing 

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
  -- putStrLn "Enter a binary number to convert to decimal:"
  -- binaryStr <- getLine
  -- let decimal = binToDec binaryStr
  -- putStrLn $ "Decimal equivalent: " ++ show decimal

  -- putStrLn "Enter a decimal number to convert to binary:"
  -- decimalStr <- getLine
  -- let binary = decToBin (read decimalStr :: Integer)
  -- putStrLn $ "Binary equivalent: " ++ binary

  -- When executed, the program will prompt the user to enter a binary number, convert it to decimal, and print the result. Then, it will prompt the user to enter a decimal number, convert it to binary

  

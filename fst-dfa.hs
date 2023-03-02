
-- using fsts the in the style of dfa?

data Bit = Zero | One

type Binary = [Bit]

type Decimal = Int

type State = String

type Alphabet = Char

type Transition = (State, Alphabet, State)

data FST = FST
  { states :: [State],
    alphabetIn :: [Alphabet],
    alphabetOut :: [Alphabet],
    transitions :: [(Transition)],
    initialState :: State,
    finalStates :: [State]
  }


-- this is based on accepts ; trying to fix error
translates :: FST -> String -> String
translates fst input = go (initialState fst) input
  where
    go state [] = state `elem` finalStates fsa
    go state (x : xs) = case lookup (state, x) (map (\(a, b, c) -> ((a, b), c)) (transitions fsa)) of
      Just nextState -> go nextState xs
      Nothing -> False



data BST = Q0 | Q1 Decimal | Q2 Decimal Binary

binaryToDecimal :: FST Binary Decimal 
binaryToDecimal =
  FST
    { states = [Q0, Q1 0, Q2 0 []],
      alphabetIn = [Zero, One],
      alphabetOut = [],
      transitions =
        [ (Q0, Zero, Q0, []),
          (Q0, One, Q1 1, []),
          (Q1 n, Zero, Q1 (2 * n), []),
          (Q1 n, One, Q1 (2 * n + 1), []),
          (Q1 n, End, Q2 n [], [n]),
          (Q2 n b, Zero, Q2 (2 * n) (b ++ [Zero]), []),
          (Q2 n b, One, Q2 (2 * n + 1) (b ++ [One]), [])
        ],
      initialState = Q0
    }

decimalToBinary :: FST Decimal Binary
decimalToBinary =
  FST
    { states = [Q0, Q1 0, Q2 []],
      alphabetIn = [],
      alphabetOut = [Zero, One],
      transitions =
        [ (Q0, End, Q1 0, []),
          (Q1 n, End, Q2 (reverse (toBits n)), []),
          (Q2 [], Zero, Q2 [], [Zero]),
          (Q2 [], One, Q2 [], [One]),
          (Q2 (b : bs), Zero, Q2 bs, [Zero]),
          (Q2 (b : bs), One, Q2 bs, [One])
        ],
      initialState = Q0
    }
  where
    toBits 0 = []
    toBits n = let (q, r) = n `divMod` 2 in toBits q ++ [if r == 0 then Zero else One]

main :: IO ()
main = do
  putStrLn "Enter a binary number to convert to decimal:"
  binaryStr <- getLine
  let decimal = binToDec binaryStr
  putStrLn $ "Decimal equivalent: " ++ show decimal

  putStrLn "Enter a decimal number to convert to binary:"
  decimalStr <- getLine
  let binary = decToBin (read decimalStr :: Integer)
  putStrLn $ "Binary equivalent: " ++ binary
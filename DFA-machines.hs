type State = String

type Alphabet = Char

type Transition = (State, Alphabet, State)

data FSA = FSA
  { states :: [State],
    alphabet :: [Alphabet],
    transitions :: [(Transition)],
    initialState :: State,
    finalStates :: [State]
  }

-- important here that transision is a pair ofa pair of state & alphabet (fixes the issue of couldn't match type)

-- this defines a type synonym `State` to represent all the possible states of the FSA
-- `Alphabet` is the alphabet
-- `Transition` is a single transition movement fromo ne state to the next (based on a specific input symbol)
-- `FSA` combines all of these

-- Checks if the given string is accepted by the FSA
accepts :: FSA -> String -> Bool
accepts fsa input = go (initialState fsa) input
  where
    go state [] = state `elem` finalStates fsa
    go state (x : xs) = case lookup (state, x) (map (\(a, b, c) -> ((a, b), c)) (transitions fsa)) of
      Just nextState -> go nextState xs
      Nothing -> False

-- `accepts` function takes FSA and input string and checks if the FSA accepts the string
-- helper function `go` that causes the tarnsition: takes in the current state and traverses the FSA
-- each step we check if something is one of the `finalStates`

abStarC :: FSA
abStarC =
  FSA
    { states = ["q1", "q2", "q3"],
      alphabet = ['a', 'b', 'c'],
      transitions =
        [ ("q1", 'a', "q2"),
          ("q2", 'b', "q2"),
          ("q2", 'c', "q3")
        ],
      initialState = "q1",
      finalStates = ["q3"]
    }

data Parity = Even | Odd

-- fsa to check if binary string has even number of 1s
evenOddFSM :: FSA
evenOddFSM =
  FSA
    { states = ["even(0)", "odd(1)"],
      alphabet = ['0', '1'],
      transitions =
        [ ("even(0)", '0', "even(0)"),
          ("even(0)", '1', "odd(1)"),
          ("odd(1)", '0', "odd(1)"),
          ("odd(1)", '1', "even(0)")
        ],
      initialState = "even(0)",
      finalStates = ["even(0)"]
    }

data Substring = A | B | C | D | E

substringFSM :: FSA
substringFSM =
  FSA
    { states = ["A", "B", "C", "D", "E"],
      alphabet = ['0', '1'],
      transitions =
        [ ("A", '1', "A"),
          ("A", '0', "B"),
          ("B", '0', "A"),
          ("B", '1', "C"),
          ("C", '0', "D"),
          ("C", '1', "A"),
          ("D", '1', "E"),
          ("D", '0', "B"),
          ("E", '1', "E"),
          ("E", '0', "E")
        ],
      initialState = "A",
      finalStates = ["E"]
    }

data Mod3 = F | G | H | I

binaryMod3FSM :: FSA
binaryMod3FSM = FSA
  { states = ["F", "G", "H", "I"]
  , alphabet = ['0', '1']
  , transitions =
      [ ("F", '0', "I")
      , ("F", '1', "G")
      , ("G", '0', "H")
      , ("G", '1', "I")
      , ("H", '0', "G")
      , ("H", '1', "H")
      , ("I", '0', "I")
      , ("I", '1', "I")
      ]
  , initialState = "F"
  , finalStates = ["I"]
  }

--------

main :: IO ()
main = do
  print "AB*C REGEX"
  print (accepts abStarC "abbbbccc") -- True
  print (accepts abStarC "ac") -- False
  print (accepts abStarC "abbbbx") -- False
  print "EVEN ODD 1" 
  print (accepts evenOddFSM "0101011")
  -- should be true
  print (accepts evenOddFSM "1101")
  -- should be false
  print "BINARY MOD 3"
  print(accepts binaryMod3FSM "101010")
  -- should be true
  print(accepts binaryMod3FSM "10101")
  -- should be true
  print "SUBSTRING 0101"
  print (accepts substringFSM "101010101")
  -- prints true
  print(accepts substringFSM "101011011")
  -- prints false! 
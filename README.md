# Finite State Machines 

Takes in input string and determines if it follows the rules of the machine & reaches the final state using Haskell. A good use can be for regex, i.e. `ab*c` and so on. Run `Main.hs` to see examples of 3 machines:
- ab*c, does the string follow? example: `abbbbc` works, but `aaabx` does not
- substring `0101` within the input string with alphabet `[0,1]`
- multiple of 3 when converted to decimal, with the input string alphabet `[0,1]` 

FSA as a class is defined as

```haskell
data FSA = FSA
  { states :: [State],
    alphabet :: [Alphabet],
    transitions :: [(Transition)],
    initialState :: State,
    finalStates :: [State]
  }
```

There are a few ways of implementation: either considering the states/nodes as functions themselves (as seen in even/odd) or literally as just nodes and representing every possible movement. The second is less feasible for larger and more complex machines. 

![example of diagrams](https://cloud-il9tnmasw-hack-club-bot.vercel.app/0img_6494.jpg)

Some of the files in this repo do not work (i.e. my ventures into FST to translate binary into decimal) but there are some attempts to make them work. [Practices](https://github.com/ClaireBookworm/haskell-fsa/blob/main/basics.hs) I did to understand basic haskell is here as well, but a lot of found from random places on the internet and Haskell books!

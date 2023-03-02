-- Define the data types for our programming language
data Expression = LiteralInt Integer
                | Variable String
                | Assignment String Expression
                | BinaryOperation String Expression Expression
                | If Expression Expression Expression
                | While Expression Expression
                | Function String [String] Expression
                | FunctionCall String [Expression]
                | Return Expression
                | Noop
                deriving (Show)

-- Define a parser for our programming language
parseExpression :: Parser Expression
parseExpression = choice
    [ parseLiteralInt
    , parseVariable
    , parseAssignment
    , parseBinaryOperation
    , parseIf
    , parseWhile
    , parseFunction
    , parseFunctionCall
    , parseReturn
    , parseNoop
    ]

parseLiteralInt :: Parser Expression
parseLiteralInt = LiteralInt <$> integer

parseVariable :: Parser Expression
parseVariable = Variable <$> identifier

parseAssignment :: Parser Expression
parseAssignment = do
    name <- identifier
    _ <- symbol "and"
    expr <- parseExpression
    return $ Assignment name expr

parseBinaryOperation :: Parser Expression
parseBinaryOperation = do
    left <- parseExpression
    op <- choice [symbol "+", symbol "-", symbol "*", symbol "/"]
    right <- parseExpression
    return $ BinaryOperation op left right

parseIf :: Parser Expression
parseIf = do
    _ <- symbol "if"
    condition <- parseExpression
    _ <- symbol "then"
    trueBranch <- parseExpression
    _ <- symbol "else"
    falseBranch <- parseExpression
    return $ If condition trueBranch falseBranch

parseWhile :: Parser Expression
parseWhile = do
    _ <- symbol "while"
    condition <- parseExpression
    body <- parseExpression
    return $ While condition body

parseFunction :: Parser Expression
parseFunction = do
    _ <- symbol "function"
    name <- identifier
    args <- parens $ many identifier
    body <- parseExpression
    return $ Function name args body

parseFunctionCall :: Parser Expression
parseFunctionCall = do
    name <- identifier
    args <- parens $ many parseExpression
    return $ FunctionCall name args

parseReturn :: Parser Expression
parseReturn = do
    _ <- symbol "return"
    expr <- parseExpression
    return $ Return expr

parseNoop :: Parser Expression
parseNoop = Noop <$ symbol "noop"

-- Define a lexer for our programming language
lexer :: TokenParser ()
lexer = makeTokenParser emptyDef
    { identStart = letter <|> char '_'
    , identLetter = alphaNum <|> char '_'
    , opStart = oneOf "+-*/="
    , opLetter = oneOf "+-*/="
    , reservedOpNames = ["+", "-", "*", "/", "=", "and", "if", "then", "else", "while", "function", "return", "noop"]
    , reservedNames = []
    }

-- Define a parser for our programming language
parser :: Parser Expression
parser = whiteSpace lexer >> parseExpression

-- Define a REPL for our programming language
main :: IO ()
main = runInputT defaultSettings loop
    where
        loop :: InputT IO ()
        loop = do
            input <- getInputLine "> "
            case input of
                Nothing -> return ()
                Just s -> case parse parser "" s of
                    Left err -> outputStrLn (show err)
                    Right expr -> do
                        outputStrLn (show expr)
                        loop
``

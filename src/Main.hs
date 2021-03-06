import Control.Applicative
import Data.Attoparsec.ByteString.Char8
import Data.Either
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as B8

import Analysis
import Samples
import Types


parseHTTPMethod :: Parser HTTPMethod
parseHTTPMethod =
	    (stringCI "GET" *> return Get)
	<|> (stringCI "POST" *> return Post)
	<|> (stringCI "PUT" *> return Put)
	<|> (stringCI "DELETE" *> return Delete)
	<|> (stringCI "OPTIONS" *> return Options)
	<|> (stringCI "HEAD" *> return Head)
	<|> (stringCI "TRACE" *> return Trace)
	<|> (stringCI "CONNECT" *> return Connect)
	<|> return Unknown


parseHTTPMethodStrictly :: Parser String
parseHTTPMethodStrictly =
            (stringCI "GET" >> return "Get")
        <|> (stringCI "POST" >> return "Post")
        <|> (stringCI "PUT" >> return "Put")
        <|> (stringCI "DELETE" >> return "Delete")
        <|> (stringCI "OPTIONS" >> return "Options")
        <|> (stringCI "HEAD" >> return "Head")
        <|> (stringCI "TRACE" >> return "Trace")
        <|> (stringCI "CONNECT" >> return "Connect")
        <|> fail "Invalid HTTP Method"


parseHTTPStatus :: Parser (Maybe Int)
parseHTTPStatus = validate <$> decimal
	where
		validate d = if (d >= 200 && d < 506) then Just d else Nothing


logParser :: Parser LogEntry
logParser = do
	method <- parseHTTPMethod
	space
	status <- parseHTTPStatus; return (method, status)


logParserPF :: Parser LogEntry
logParserPF = liftA2 (,) parseHTTPMethod (space *> parseHTTPStatus)



parens :: Parser B8.ByteString
parens = char '(' *> body <* char ')'
	where
		body = scan (1 :: Int) $ \s c ->
			case (s, c) of 
				(p, '(') ->  Just (p + 1)
				(1, ')') ->  Nothing
				(p, ')') ->  Just (p - 1)
				(p, _) ->    Just p


main2 :: IO [Result LogEntry]
main2 = do
	logFile <- B.readFile "/path/to/logfile.log"
	let logLines = B8.lines logFile
	return $ map (parse logParser) logLines


main :: IO ()
main = do
	let methodResults = rights $ map (parseOnly parseHTTPMethod) sampleLogLines
	putStrLn $ "Number of get requests: " ++ (show $ countGets methodResults)
	let statusResults = rights $ map (parseOnly parseHTTPStatus) sampleStatusLines
	putStrLn $ "Number of sucessful requests: " ++ (show $ countStatusCodes statusResults)
	let combinedResults = rights $ map (parseOnly logParser) sampleCombinedLines
	putStrLn $ "Number of valid log lines: " ++ (show $ length combinedResults) ++ " out of " ++ (show $ length sampleCombinedLines)
	return ()

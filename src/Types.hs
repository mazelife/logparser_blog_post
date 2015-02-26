module Types where


-- |Possible HTTP methods
data HTTPMethod = Get | Post | Put | Delete | Options | Head | Trace | Connect | Unknown deriving (Show, Eq)

-- | Possible status codes
type HTTPStatus = Int

type LogEntry = (HTTPMethod, Maybe HTTPStatus)

type Log = [LogEntry]
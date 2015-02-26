module Analysis where

import Types


countType :: HTTPMethod -> Int
countType Get = 1
countType _   = 0


countGets :: [HTTPMethod] -> Int
countGets = sum . (map countType)


countSuccessful :: Maybe HTTPStatus -> Int
countSuccessful (Just status)
	| status < 300 = 1
	| otherwise    = 0
countSuccessful Nothing = 0


countStatusCodes :: [Maybe HTTPStatus] -> Int
countStatusCodes = sum . (map countSuccessful)
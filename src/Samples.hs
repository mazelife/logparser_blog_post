module Samples where


import qualified Data.ByteString as B


sampleLogLines :: [B.ByteString]
sampleLogLines = ["GET", "GET", "POST", "GET", "PUT", "GET", "GETD"]


sampleStatusLines :: [B.ByteString]
sampleStatusLines = ["200", "200", "404", "500", "900", "201"]

sampleCombinedLines :: [B.ByteString]
sampleCombinedLines = [
			  "GET 200"
			, "PUT 201"
			, "GET 404" 
			, "POST 500"
			, "GETD 900" 
			, "PUT 201"
			, "200" ]

module Handler (server) where

import Servant
import Api (ClassificationResult(..), API, api)

server :: Server API
server = classifyHandler

classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler pixels = return $ ClassificationResult (fakeClassifier pixels)

fakeClassifier :: [Int] -> Int
fakeClassifier _ = 7

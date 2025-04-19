module Handler.Classification (classifyHandler) where

import Servant
import Api.Classification
import Control.Monad.IO.Class (liftIO)

classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler xs = do
  let prediction = sum xs `mod` 10
  return $ ClassificationResult prediction ("Predicted digit: " ++ show prediction)
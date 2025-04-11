module Handler (server) where

import Api (API, ClassificationResult(..))
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (decode, encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import Servant
import System.Process (readProcess)

server :: Server API
server = classifyHandler

classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler pixels = do
  let inputJSON = BL.unpack (encode pixels)
  output <- liftIO $ readProcess "python" ["ClassificationModel/classify.py"] inputJSON

  liftIO $ writeFile "debug_output.txt" output

  let decoded = decode (BL.pack output)
  
  case decoded of
    Just res -> return res
    Nothing -> throwError err500 { errBody = BL.pack "Parsing Error." }
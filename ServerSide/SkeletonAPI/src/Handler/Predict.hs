-- Handler/Predict.hs

{-# LANGUAGE OverloadedStrings #-}

module Handler.Predict (predictHandler) where

import Servant
import System.Process (readProcess)
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (encode, decode)
import qualified Data.ByteString.Lazy.Char8 as BL

import Api.Predict (PredictionInput(..))
import Types (Recommendation)

predictHandler :: [PredictionInput] -> Handler [Recommendation]
predictHandler inputs = do
  let jsonInput = encode inputs
  result <- liftIO $ readProcess "python" ["recommendModel/recommend.py"] (BL.unpack jsonInput)
  liftIO $ putStrLn $ "🐍 Python output: " ++ result
  case decode (BL.pack result) of
    Nothing -> throwError err500 { errBody = "예측 결과 디코딩 실패" }
    Just recs -> return recs


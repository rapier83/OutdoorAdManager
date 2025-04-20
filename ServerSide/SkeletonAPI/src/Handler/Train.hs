{-# LANGUAGE OverloadedStrings #-}

module Handler.Train (trainHandler, trainStatusHandler) where

import Servant
import System.Process (readProcess)
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import SampleData.SampleTrainingData (trainingSamples)  -- 👈 학습용 샘플 데이터

trainHandler :: Handler NoContent
trainHandler = do
  let jsonInput = BL.unpack (encode trainingSamples)
  result <- liftIO $ readProcess "python" ["app/recommendModel/recommend_train.py"] jsonInput
  liftIO $ putStrLn $ "🧠 모델 학습 결과: " ++ result
  return NoContent

trainStatusHandler :: Handler String
trainStatusHandler = return "✅ 학습 완료, 모델 준비됨"

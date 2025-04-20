{-# LANGUAGE DeriveGeneric #-}

module SampleData.SampleTrainingData (trainingSamples) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON)

data TrainingInput = TrainingInput
  { campaignId :: Int,
    budget :: Double,
    duration :: Int,
    preferredTime :: String,
    predictedImpression :: Int
  } deriving (Show, Generic)

instance ToJSON TrainingInput

trainingSamples :: [TrainingInput]
trainingSamples =
  [ TrainingInput i (fromIntegral (50000 + i * 1000)) 30 "08:00~20:00" (1000 + i * 50)
  | i <- [1..50]
  ]

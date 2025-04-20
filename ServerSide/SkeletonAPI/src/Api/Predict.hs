-- Api.Predict.hs

{-# LANGUAGE DeriveGeneric #-}

module Api.Predict where

import GHC.Generics (Generic)
import Data.Aeson (FromJSON, ToJSON)

data PredictionInput = PredictionInput
  { screenId :: Int
  , campaignId :: Int
  , budget :: Double
  , duration :: Int
  , preferredTime :: String
  , targetAge :: Int
  , targetGender :: String
  } deriving (Show, Generic)

instance FromJSON PredictionInput
instance ToJSON PredictionInput

-- src/Types.hs
{-# LANGUAGE DeriveGeneric #-}

module Types (Recommendation(..)) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

data Recommendation = Recommendation
  { recId :: Int
  , recTitle :: String
  , recScore :: Double
  } deriving (Show, Generic)

instance ToJSON Recommendation
instance FromJSON Recommendation

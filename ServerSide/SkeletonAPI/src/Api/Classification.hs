{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Api.Classification where

import Servant
import GHC.Generics
import Data.Aeson

data ClassificationResult = ClassificationResult
  { result :: Int
  , message :: String
  } deriving (Show, Generic)

instance ToJSON ClassificationResult
instance FromJSON ClassificationResult

type ClassificationAPI =
  "classify" :> ReqBody '[JSON] [Int] :> Post '[JSON] ClassificationResult
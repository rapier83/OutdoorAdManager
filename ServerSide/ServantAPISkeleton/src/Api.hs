{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Api (ClassificationResult(..), API, api) where

import Servant
import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

data ClassificationResult = ClassificationResult
  { result :: Int
  , message :: String
  } deriving (Show, Generic)

instance ToJSON ClassificationResult
instance FromJSON ClassificationResult

type API = "classify" :> ReqBody '[JSON] [Int] :> Post '[JSON] ClassificationResult

api :: Proxy API
api = Proxy

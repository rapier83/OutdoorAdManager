{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Api (ClassificationResult(..), API, api) where

import Servant
import GHC.Generics (Generic)
import Data.Aeson (ToJSON)

data ClassificationResult = ClassificationResult
  { result :: Int
  } deriving (Generic)

instance ToJSON ClassificationResult

type API = "classify" :> ReqBody '[JSON] [Int] :> Post '[JSON] ClassificationResult

api :: Proxy API
api = Proxy

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Api (ClassificationResult (..), Recommendation (..), API, api) where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)
import Servant

-- 기존 응답 모델
data ClassificationResult = ClassificationResult
  { result :: Int,
    message :: String
  }
  deriving (Show, Generic)

instance ToJSON ClassificationResult

instance FromJSON ClassificationResult

-- 추천 모델 (예시)
data Recommendation = Recommendation
  { adId :: Int,
    title :: String,
    score :: Double
  }
  deriving (Show, Generic)

instance ToJSON Recommendation

instance FromJSON Recommendation

-- 전체 API 타입
type API =
  "classify" :> ReqBody '[JSON] [Int] :> Post '[JSON] ClassificationResult
    :<|> "recommendations" :> QueryParam "site_id" Int :> Get '[JSON] [Recommendation]
    :<|> "logs" :> Get '[PlainText] String
    :<|> "health" :> Get '[PlainText] String
    :<|> "train" :> PostNoContent
    :<|> "train-status" :> Get '[PlainText] String

api :: Proxy API
api = Proxy

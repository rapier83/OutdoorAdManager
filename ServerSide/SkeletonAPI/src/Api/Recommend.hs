-- Api/Recommend.hs

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Api.Recommend where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)
import Servant

-- 매체 추천 결과 (전광판 기반 추천)
data Recommendation = Recommendation
  { screenId :: Int,
    screenName :: String,
    estimatedImpression :: Int,
    estimatedCost :: Double
  } deriving (Show, Generic)

instance ToJSON Recommendation
instance FromJSON Recommendation

type RecommendAPI =
  "recommendations" :> QueryParam "site_id" Int :> Get '[JSON] [Recommendation]
-- src/Types.hs
{-# LANGUAGE DeriveGeneric #-}

module Types where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

-- 추천 결과 구조체
data Recommendation = Recommendation
  { adId :: Int
  , title :: String
  , score :: Double
  } deriving (Show, Generic)

instance ToJSON Recommendation
instance FromJSON Recommendation

-- 머신러닝 학습용 샘플 구조체
-- 모델 입력을 구성하는 단일 샘플
-- 예: 특정 스크린에 특정 광고 조합이 적합한지를 나타냄
data TrainingSample = TrainingSample
  { screenId :: Int
  , brightness :: Double
  , cost :: Double
  , adLength :: Int
  , hasAnimation :: Bool
  , clickThroughRate :: Double
  , label :: Bool -- 이 조합이 적합한지 여부
  } deriving (Show, Generic)

instance ToJSON TrainingSample
instance FromJSON TrainingSample


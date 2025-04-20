-- Recommend.hs
{-# LANGUAGE OverloadedStrings #-}

module Api.Recommend (
  recommendAdForScreen,
  recommendMediaForCampaign
) where

import Data.List (sortOn)
import Data.Ord (Down(..))
import Types (Recommendation(..))

-- 예시 광고 구조체
data Advertisement = Advertisement
  { advId :: Int
  , adTitle :: String
  , relevance :: Double
  }

-- 예시 스크린 구조체
data MediaScreen = MediaScreen
  { screenId :: Int
  , siteId :: Int
  , name :: String
  , brightness :: Double
  , cost :: Double
  }

-- 광고-스크린 연결 구조체
data AdTargeting = AdTargeting
  { adTargetAdId :: Int
  , adTargetScreenId :: Int
  }

-- 광고 샘플 데이터
sampleAds :: [Advertisement]
sampleAds = [
  Advertisement 1 "Ad A" 0.8,
  Advertisement 2 "Ad B" 0.6,
  Advertisement 3 "Ad C" 0.9,
  Advertisement 4 "Ad D" 0.7,
  Advertisement 5 "Ad E" 0.5,
  Advertisement 6 "Ad F" 1.0
  ]

-- 스크린 샘플 데이터
sampleScreens :: [MediaScreen]
sampleScreens = [
  MediaScreen 1 1 "Screen A" 0.9 2000,
  MediaScreen 2 1 "Screen B" 0.6 1000,
  MediaScreen 3 2 "Screen C" 0.8 2500
  ]

-- 광고 타겟 매핑
sampleAdTargeting :: [AdTargeting]
sampleAdTargeting = [
  AdTargeting 1 1,
  AdTargeting 2 1,
  AdTargeting 3 2,
  AdTargeting 4 3,
  AdTargeting 5 1,
  AdTargeting 6 2
  ]

-- 전광판 추천: 캠페인 ID에 해당하는 siteId 기반 추천
recommendMediaForCampaign :: Int -> [Recommendation]
recommendMediaForCampaign campaignId =
  let filtered = filter ((== campaignId) . siteId) sampleScreens
      scored = map (\s -> (s, brightness s / cost s)) filtered
      topRanked = take 5 $ sortOn (Data.Ord.Down . snd) scored
  in map (\(s, score) -> Recommendation (screenId s) (name s) score) topRanked

-- 스크린에 맞는 광고 추천
recommendAdForScreen :: Int -> [Recommendation]
recommendAdForScreen sid =
  let relatedAdIds = [ adTargetAdId t | t <- sampleAdTargeting, adTargetScreenId t == sid ]
      relatedAds = filter (\a -> advId a `elem` relatedAdIds) sampleAds
      sortedAds = take 5 $ sortOn (Down . relevance) relatedAds
  in map (\a -> Recommendation (advId a) (adTitle a) (relevance a)) sortedAds
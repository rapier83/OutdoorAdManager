module SampleData.SampleScreens (sampleScreens) where

import Types (Recommendation(..))

sampleScreens :: [Recommendation]
sampleScreens =
  -- 우선 추천 대상
  [ Recommendation sid ("Screen " ++ show sid) (10000 + fromIntegral sid * 10)
  | sid <- [1..100], sid `mod` 7 /= 0, sid `mod` 11 /= 0
  ]
  -- 제외 지면 대상
  ++
  [ Recommendation sid ("Screen " ++ show sid) (7000 + fromIntegral sid * 5)
  | sid <- [1..100], sid `mod` 7 == 0 || sid `mod` 11 == 0
  ]

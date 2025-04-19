module SampleData.SampleScreens (sampleScreens) where

import Api.Recommend (Recommendation(..))

sampleScreens :: [Recommendation]
sampleScreens =
  -- 우선 추천 대상
  [ Recommendation sid ("Screen " ++ show sid) (10000 + sid * 10) (fromIntegral (800 + (sid `mod` 5) * 100))
  | sid <- [1..100], sid `mod` 7 /= 0, sid `mod` 11 /= 0
  ]
  -- 조건이 나빠 제외될 수도 있는 스크린
  ++
  [ Recommendation sid ("Screen " ++ show sid) (7000 + sid * 5) 2000.0
  | sid <- [1..100], sid `mod` 7 == 0 || sid `mod` 11 == 0
  ]
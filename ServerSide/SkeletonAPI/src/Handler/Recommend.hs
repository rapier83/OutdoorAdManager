-- Handler/Recommend.hs

module Handler.Recommend (recommendHandler) where

import Servant
import Api.Recommend

recommendHandler :: Maybe Int -> Handler [Recommendation]
recommendHandler (Just siteId) = do
  -- 추후 DB에서 실제 siteId 기반 필터링 적용
  return
    [ Recommendation 101 "Screen A" 12000 1500.0
    , Recommendation 102 "Screen B" 8000 1200.0
    ]
recommendHandler Nothing = return []
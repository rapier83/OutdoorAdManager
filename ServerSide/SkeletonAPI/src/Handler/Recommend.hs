-- Handler.hs
{-# LANGUAGE ExplicitNamespaces #-}
module Handler.Recommend (recommendAdHandler, recommendMediaHandler) where

import Servant ( Handler, err400, throwError, ServerError(errBody) )
import Types (Recommendation(..))
import Api.Recommend (recommendMediaForCampaign, recommendAdForScreen)
import qualified Data.ByteString.Lazy.Char8 as BL

-- 광고 추천: 전광판에 적합한 광고
recommendAdHandler :: Maybe Int -> Handler [Recommendation]
recommendAdHandler (Just sid) = return $ recommendAdForScreen sid
recommendAdHandler Nothing = throwError err400 { errBody = BL.pack "screen_id is required" }

-- 전광판 추천: 캠페인에 적합한 스크린
recommendMediaHandler :: Maybe Int -> Handler [Recommendation]
recommendMediaHandler (Just cid) = return $ recommendMediaForCampaign cid
recommendMediaHandler Nothing = throwError err400 { errBody = BL.pack "campaign_id is required" }


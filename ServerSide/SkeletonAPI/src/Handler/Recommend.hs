-- Handler.hs
{-# LANGUAGE ExplicitNamespaces #-}
module Handler.Recommend (recommendAdHandler, recommendMediaHandler) where

import Servant
    ( Handler,
      type (:<|>)((:<|>)),
      NoContent(..),
      err400,
      throwError,
      Server,
      ServerError(errBody) )
import Api (API)
import Types (Recommendation(..))
import Api.Classification (ClassificationResult(..))
import Api.Recommend (recommendMediaForCampaign, recommendAdForScreen)
import Control.Monad.IO.Class (liftIO)
-- import Handler.Recommend (server)
import qualified Data.ByteString.Lazy.Char8 as BL

server :: Server API
server = 
    classifyHandler
  :<|> recommendAdHandler         -- Maybe Int -> Handler [Recommendation]
  :<|> recommendMediaHandler      -- Maybe Int -> Handler [Recommendation]
  :<|> logHandler                 -- Handler String
  :<|> healthHandler              -- Handler String
  :<|> trainHandler               -- Handler NoContent
  :<|> trainStatusHandler         -- Handler String

-- Dummy classify handler (to be replaced)
classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler _ = return $ ClassificationResult 1 "Dummy result"

-- 광고 추천: 전광판에 적합한 광고
recommendAdHandler :: Maybe Int -> Handler [Recommendation]
recommendAdHandler (Just sid) = return $ recommendAdForScreen sid
recommendAdHandler Nothing = throwError err400 { errBody = BL.pack "screen_id is required" }

-- 전광판 추천: 캠페인에 적합한 스크린
recommendMediaHandler :: Maybe Int -> Handler [Recommendation]
recommendMediaHandler (Just cid) = return $ recommendMediaForCampaign cid
recommendMediaHandler Nothing = throwError err400 { errBody = BL.pack "campaign_id is required" }

-- 기타 핸들러들
logHandler :: Handler String
logHandler = return "Logs not implemented yet."

healthHandler :: Handler String
healthHandler = return "OK"

trainHandler :: Handler NoContent
trainHandler = return NoContent

trainStatusHandler :: Handler String
trainStatusHandler = return "Training complete"

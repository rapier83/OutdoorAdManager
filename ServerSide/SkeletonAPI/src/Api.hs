-- Api.hs
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api (API, api) where

import Servant
import Types (Recommendation)
import Api.Classification (ClassificationResult(..))

type API =
       "classify"         :> ReqBody '[JSON] [Int]        :> Post '[JSON] ClassificationResult
  :<|> "recommend-ad"     :> QueryParam "screen_id" Int   :> Get  '[JSON] [Recommendation]
  :<|> "recommend-media"  :> QueryParam "campaign_id" Int :> Get  '[JSON] [Recommendation]
  :<|> "logs"             :> Get '[PlainText] String
  :<|> "health"           :> Get '[PlainText] String
  :<|> "train"            :> PostNoContent
  :<|> "train-status"     :> Get '[PlainText] String

api :: Proxy API
api = Proxy

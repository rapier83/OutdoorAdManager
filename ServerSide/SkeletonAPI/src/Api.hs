-- Api.hs
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api (API, api) where

import Servant
import Types (Recommendation)
import Api.Classification (ClassificationResult(..))
import Api.Predict (PredictionInput(..))

type API =
       "classify"         :> ReqBody '[JSON] [Int]        :> Post '[JSON] ClassificationResult
  :<|> "recommend-ad"     :> QueryParam "screen_id" Int   :> Get  '[JSON] [Recommendation]
  :<|> "recommend-media"  :> QueryParam "campaign_id" Int :> Get  '[JSON] [Recommendation]
  :<|> "logs"             :> Get '[PlainText] String
  :<|> "health"           :> Get '[PlainText] String
  :<|> "train"            :> PostNoContent
  :<|> "train-status"     :> Get '[PlainText] String
  :<|> "recommendPredict" :> ReqBody '[JSON] [PredictionInput] :> Post '[JSON] [Recommendation]

api :: Proxy API
api = Proxy

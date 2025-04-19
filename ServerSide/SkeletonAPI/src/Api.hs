{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api (API, api) where

import Servant
import Api.Recommend
import Api.Logs
import Api.Health
import Api.Train
import Api.Classification (ClassificationAPI)

type API =
       ClassificationAPI
  :<|> RecommendAPI
  :<|> LogsAPI
  :<|> HealthAPI
  :<|> TrainAPI

api :: Proxy API
api = Proxy

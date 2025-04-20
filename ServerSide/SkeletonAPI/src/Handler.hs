module Handler (server) where

import Servant
import Api (API)
import Api.Classification()
import Api.Recommend()
import Api.Logs()
import Api.Health()
import Api.Train()
import Api.Predict()

import Handler.Classification (classifyHandler)
import Handler.Recommend (recommendAdHandler, recommendMediaHandler)
import Handler.Logs (logsHandler)
import Handler.Health (healthHandler)
import Handler.Train (trainHandler, trainStatusHandler)
import Handler.Predict (predictHandler)

server :: Server API
server =
       classifyHandler
  :<|> recommendAdHandler
  :<|> recommendMediaHandler
  :<|> logsHandler
  :<|> healthHandler
  :<|> trainHandler
  :<|> trainStatusHandler
  :<|> predictHandler
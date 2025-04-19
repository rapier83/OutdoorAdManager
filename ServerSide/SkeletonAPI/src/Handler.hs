module Handler (server) where

import Servant
import Api (API)
import Api.Classification
import Api.Recommend
import Api.Logs
import Api.Health
import Api.Train

import Handler.Classification (classifyHandler)
import Handler.Recommend (recommendHandler)
import Handler.Logs (logsHandler)
import Handler.Health (healthHandler)
import Handler.Train (trainHandler, trainStatusHandler)

server :: Server API
server =
       classifyHandler
  :<|> recommendHandler
  :<|> logsHandler
  :<|> healthHandler
  :<|> (trainHandler :<|> trainStatusHandler)
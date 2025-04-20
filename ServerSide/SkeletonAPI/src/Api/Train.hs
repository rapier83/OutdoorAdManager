-- src/Api/Train.hs
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Train (TrainAPI, trainAPI) where

import Servant
import Handler.Train (trainHandler, trainStatusHandler)

type TrainAPI =
       "train"        :> PostNoContent
  :<|> "train-status" :> Get '[PlainText] String

trainAPI :: ServerT TrainAPI Handler
trainAPI = trainHandler :<|> trainStatusHandler

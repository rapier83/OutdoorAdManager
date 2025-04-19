module Handler.Train (trainHandler, trainStatusHandler) where

import Servant

trainHandler :: Handler NoContent
trainHandler = return NoContent

trainStatusHandler :: Handler String
trainStatusHandler = return "Training not started."
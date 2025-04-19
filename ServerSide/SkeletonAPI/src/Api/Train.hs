{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Train where

import Servant

type TrainAPI =
       "train" :> PostNoContent
  :<|> "train-status" :> Get '[PlainText] String
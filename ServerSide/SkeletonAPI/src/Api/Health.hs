{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Health where

import Servant

type HealthAPI =
  "health" :> Get '[PlainText] String
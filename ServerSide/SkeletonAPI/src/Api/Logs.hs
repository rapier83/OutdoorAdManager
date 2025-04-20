{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Logs where

import Servant

type LogsAPI =
  "logs" :> Get '[PlainText] String
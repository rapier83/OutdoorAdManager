module Handler.Health (healthHandler) where

import Servant

healthHandler :: Handler String
healthHandler = return "OK"
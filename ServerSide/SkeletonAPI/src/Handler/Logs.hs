module Handler.Logs (logsHandler) where

import Servant

logsHandler :: Handler String
logsHandler = return "Log output: All systems operational."
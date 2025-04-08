module Main (main) where

import Network.Wai
import Network.Wai.Handler.Warp (run)
import Servant
import Api          -- src/Api.hs에 있는 API 정의
import Handler  -- src/Handler.hs에 있는 핸들러 정의

app :: Application
app = serve api server

main :: IO ()
main = do
  putStrLn "Server running on http://localhost:8080"
  run 8080 app

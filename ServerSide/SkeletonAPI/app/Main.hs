module Main (main) where

import Network.Wai
import Network.Wai.Handler.Warp (run)
import Servant
import Api          -- src/Api.hs에 있는 API 정의
import Handler  -- src/Handler.hs에 있는 핸들러 정의

import Control.Concurrent (forkIO, killThread)
import System.IO (hSetBuffering, stdout, BufferMode(NoBuffering))

app :: Application
app = serve api server

main :: IO ()
main = do
  putStrLn "Server running on http://localhost:8080"
  hSetBuffering stdout NoBuffering

  serverThread <- forkIO $ run 8080 app

  putStrLn "Press 'q' to quit the server."

  waitForQuit
  killThread serverThread
  putStrLn "Server stopped."
  
waitForQuit :: IO ()
waitForQuit = do
  input <- getLine
  if input == "q"
    then return ()
    else do
      waitForQuit
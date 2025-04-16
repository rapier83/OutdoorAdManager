module Handler (server) where

import Api
import Control.Monad.IO.Class (liftIO)
import Data.Aeson (decode, encode)
import qualified Data.ByteString.Lazy.Char8 as BL
import Servant
import System.Directory (doesFileExist)
import System.Process (readProcess)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

server :: Server API
server =
  classifyHandler
    :<|> recommendationsHandler
    :<|> logsHandler
    :<|> healthHandler
    :<|> trainHandler
    :<|> trainStatusHandler

-- 학습 상태 확인 핸들러
trainStatusHandler :: Handler String
trainStatusHandler = do
  exists <- liftIO $ doesFileExist "training_status.txt"
  if not exists
    then return "unknown"
    else liftIO (T.unpack <$> TIO.readFile "training_status.txt") >>= return

-- 기존 classify
classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler pixels = do
  let inputJSON = BL.unpack (encode pixels)
  output <- liftIO $ readProcess "python" ["ClassificationModel/classify.py"] inputJSON
  liftIO $ writeFile "debug_output.txt" output
  case decode (BL.pack output) of
    Just res -> return res
    Nothing  -> throwError err500 { errBody = BL.pack ("Parsing Error. Output was: " ++ output) }


-- 추천 (임시 더미 데이터)
recommendationsHandler :: Maybe Int -> Handler [Recommendation]
recommendationsHandler (Just siteId) = do
  return
    [ Recommendation 1 "도심형 맥주광고" 0.92,
      Recommendation 2 "헬스케어 스마트워치" 0.88
    ]
recommendationsHandler Nothing = return []

-- 로그 반환
logsHandler :: Handler String
logsHandler = liftIO $ readFile "debug_output.txt"

-- 서버 헬스체크
healthHandler :: Handler String
healthHandler = return "Server is healthy!"

-- 모델 재학습 (예시)
trainHandler :: Handler NoContent
trainHandler = do
  _ <- liftIO $ readProcess "python" ["ClassificationModel/train.py"] ""
  return NoContent
{-# LANGUAGE OverloadedStrings #-}

module Spec(main) where

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.Matcher

import           Control.Monad        (forM_)
import           Data.Aeson
import qualified Data.ByteString      as B
import qualified Data.ByteString.Lazy as LB
import           Data.Maybe           (fromMaybe)
import qualified Data.Text            as T
import           Data.Text.Encoding   (encodeUtf8)
import           Network.HTTP.Types
import           Network.Wai          (Application)
import           Network.Wai.Test     hiding (request)
import qualified Web.Scotty           as S

import Lib

main :: IO ()
main = hspec spec

app :: IO Application
app = S.scottyApp Lib.routes

spec :: Spec
spec = with app $
  describe "Echo /" $ do
    forM_ (methods "{}") $ \(name, method) -> it (name ++ " should reply with query params") $
      let
        params = [("foo", "bar"), ("bar", "baz")] :: [(T.Text, T.Text)]
        query = Just $ object $ map (\(k, v) -> (k, String v)) params
        paramStr = T.intercalate "&" $ map (\(k, v) -> T.intercalate "=" [k, v]) params
        path = encodeUtf8 $ T.append "/echo?" paramStr
      in
      method path `shouldRespondWith` ResponseMatcher 200 [] (bodyEquals (res query Nothing))

    forM_ (methods $ encode payload) $ \(name, method) -> it (name ++ " should reply with payload") $
      method "/echo" `shouldRespondWith` ResponseMatcher 200 [] (bodyEquals (res Nothing (Just payload)))
    where
      payload = object ["foo" .= ("bar" :: T.Text)]

methods :: LB.ByteString -> [(String, B.ByteString -> WaiSession SResponse)]
methods payload =
  [ ("get", req methodGet payload)
  , ("post", req methodPost payload)
  , ("put", req methodPut payload)
  , ("patch", req methodPatch payload)
  , ("delete", req methodDelete payload)
  , ("options", req methodOptions payload)
  ]

req :: Method -> LB.ByteString -> B.ByteString -> WaiSession SResponse
req method payload path = request method path [(hContentType, "application/json")] payload

res :: Maybe Value -> Maybe Value -> LB.ByteString
res query payload =
  encode $ object [ "query" .= m query, "payload" .= m payload ]
  where
    m :: Maybe Value -> Value
    m = fromMaybe (object [])

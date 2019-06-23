{-# LANGUAGE OverloadedStrings #-}

module Spec(main) where

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.Matcher

import           Control.Arrow        (first)
import           Control.Monad        (forM_)
import           Data.Aeson
import qualified Data.ByteString      as B
import qualified Data.ByteString.Lazy as LB
import qualified Data.CaseInsensitive as CI
import           Data.Maybe           (fromMaybe)
import qualified Data.Text            as T
import           Data.Text.Encoding   (decodeUtf8, encodeUtf8)
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
    forM_ (methods [] "") $ \(name, method) -> it (name ++ " should reply with query params") $
      let
        params = [("foo", "bar"), ("bar", "baz")] :: [(T.Text, T.Text)]
        query = Just $ object $ map (\(k, v) -> (k, String v)) params
        paramStr = T.intercalate "&" $ map (\(k, v) -> T.intercalate "=" [k, v]) params
        path = encodeUtf8 $ T.append "/echo?" paramStr
      in
      method path `shouldRespondWith`
        ResponseMatcher 200 [] (bodyEquals (res Nothing query Nothing))

    forM_ (methods [] $ encode payload) $ \(name, method) -> it (name ++ " should reply with payload") $
      method "/echo" `shouldRespondWith`
        ResponseMatcher 200 [] (bodyEquals (res Nothing Nothing (Just payload)))

    forM_ (methods extraHeaders "") $ \(name, method) -> it (name ++ " should reply with headers") $
      let
        hds = Just $ object $ map (\(k, v) -> (decodeUtf8 k, String . decodeUtf8 $ v)) extraHeaders
      in
      method "/echo" `shouldRespondWith` ResponseMatcher 200 [] (bodyEquals (res hds Nothing Nothing))

    where
      payload = object ["foo" .= ("bar" :: T.Text)]
      extraHeaders = [("echo-extra-header", "foo")] :: [(B.ByteString, B.ByteString)]

methods :: [(B.ByteString, B.ByteString)] -> LB.ByteString -> [(String, B.ByteString -> WaiSession SResponse)]
methods headers payload =
  let
    r method = req method headers payload
  in
    [ ("get", r methodGet)
    , ("post", r methodPost)
    , ("put", r methodPut)
    , ("patch", r methodPatch)
    , ("delete", r methodDelete)
    , ("options", r methodOptions)
    ]

req :: Method -> [(B.ByteString, B.ByteString)] -> LB.ByteString -> B.ByteString -> WaiSession SResponse
req method extraHeaders payload path = request method path headers payload
  where
    headers = map (first CI.mk) extraHeaders

res :: Maybe Value -> Maybe Value -> Maybe Value -> LB.ByteString
res hds query payload =
  encode $ object [ "headers" .= m hds, "query" .= m query, "payload" .= m payload ]
  where
    m :: Maybe Value -> Value
    m = fromMaybe (object [])

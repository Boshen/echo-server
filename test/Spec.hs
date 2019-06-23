{-# LANGUAGE OverloadedStrings #-}

module Spec(main) where

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.Matcher

import           Control.Monad      (forM_)
import           Data.Aeson
import           Data.ByteString    (ByteString)
import qualified Data.Text          as T
import           Data.Text.Encoding (encodeUtf8)
import           Network.Wai        (Application)
import           Network.Wai.Test   (SResponse)
import qualified Web.Scotty         as S

import Lib

main :: IO ()
main = hspec spec

app :: IO Application
app = S.scottyApp Lib.routes

methods :: [(String, ByteString -> WaiSession SResponse)]
methods = [ ("get", get)
          , ("post", flip post "")
          , ("put", flip put "")
          , ("patch", flip patch "")
          , ("delete", delete)
          , ("options", options)
          ]

spec :: Spec
spec = with app $
  describe "Echo /" $
    forM_ methods $ \(name, method) -> it (name ++ " should reply with query params") $
      let
        params = [("foo", "bar"), ("bar", "baz")] :: [(T.Text, T.Text)]
        body = encode $ object ["params" .= map (\(k, v) -> (k, String v)) params]
        paramStr = T.intercalate "&" $ map (\(k, v) -> T.intercalate "=" [k, v]) params
        url = encodeUtf8 $ T.append "echo?" paramStr
      in
      -- "get /echo?foo=bar&bar=baz"
      method url `shouldRespondWith` ResponseMatcher 200 [] (bodyEquals body)

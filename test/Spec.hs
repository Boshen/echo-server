{-# LANGUAGE OverloadedStrings #-}
module Spec(main) where


import           Test.Hspec
import           Test.Hspec.Wai
import           Test.Hspec.Wai.JSON

import           Network.Wai         (Application)
import qualified Web.Scotty          as S

import           Lib

main :: IO ()
main = hspec spec

app :: IO Application
app = S.scottyApp Lib.routes

spec :: Spec
spec = with app $
  describe "Echo /" $
    it "should reply with 200" $ do
      get "/echo" `shouldRespondWith` 200
      post "/echo" "" `shouldRespondWith` 200
      put "/echo" "" `shouldRespondWith` 200
      patch "/echo" "" `shouldRespondWith` 200
      delete "/echo" `shouldRespondWith` 200
      options "/echo" `shouldRespondWith` 200

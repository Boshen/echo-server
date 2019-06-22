module Spec where

import           Test.Hspec

import           Lib

main :: IO ()
main =
  hspec $
  describe "test" $ do
    it "should be true" $ Lib.foo `shouldBe` True
    it "should be true" $ Lib.foo `shouldBe` True

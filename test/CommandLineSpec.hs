module CommandLineSpec(spec) where

import Foundation

import           Options.Applicative
import qualified Prelude
import           Test.Hspec

import CommandLine

spec :: Spec
spec =
  describe "CommandLine" $ do
    it "should not parse empty string" $
      check [""] `shouldBe` Nothing

    it "should not parse other args" $
      check ["--foo", "3000"] `shouldBe` Nothing

    it "should give default port" $
      check [] `shouldBe` Just (CLI { port = 3000})

    it "should parse port" $
      check ["--port", "4000"] `shouldBe` Just (CLI { port = 4000})

check :: [Prelude.String] -> Maybe CLI
check = getParseResult . execParserPure defaultPrefs cliInfo

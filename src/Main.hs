module Main(main) where

import Foundation

import           Options.Applicative
import qualified Web.Scotty          as S

import CommandLine
import Echo

main :: IO ()
main = do
  cli <- execParser cliInfo
  S.scotty (port cli) Echo.routes

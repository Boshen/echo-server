module Main(main) where

import Foundation

import Data.Default                         (def)
import Network.Wai.Middleware.RequestLogger (IPAddrSource (FromHeader),
                                             OutputFormat (Apache),
                                             mkRequestLogger, outputFormat)
import Options.Applicative                  (execParser)
import Web.Scotty                           (middleware, scotty)

import CommandLine (cliInfo, port)
import Echo

main :: IO ()
main = do
  cli <- execParser cliInfo
  logger <- mkRequestLogger def { outputFormat = Apache FromHeader }
  scotty (port cli) $ do
    middleware logger
    Echo.routes

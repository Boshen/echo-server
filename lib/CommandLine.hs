module CommandLine where

import Foundation

import Data.Semigroup      ((<>))
import Options.Applicative

newtype CLI = CLI { port :: Int } deriving (Eq, Show)

cliParser :: Parser CLI
cliParser = CLI
  <$> option auto
    ( long "port"
    <> help "Specify the port to use"
    <> showDefault
    <> value 4000
    <> metavar "INT"
    )

cliInfo :: ParserInfo CLI
cliInfo = info (cliParser <**> helper)
  ( fullDesc
  <> progDesc "Echo Server"
  <> header "echo server - echoes all your requests")

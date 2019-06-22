module Main where

import qualified Web.Scotty as S

import           Lib

main :: IO ()
main = S.scotty 3000 Lib.routes

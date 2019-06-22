module Main where

import           Data.Monoid (mconcat)
import qualified Web.Scotty  as S

import           Lib

main = S.scotty 3000 Lib.routes

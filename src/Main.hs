module Main(main) where

import qualified Web.Scotty as S

import Echo

main :: IO ()
main = S.scotty 3000 Echo.routes

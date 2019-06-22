{-# LANGUAGE OverloadedStrings #-}

module Lib where

import           Data.Aeson  (Value (..), object, (.=))
import           Data.Monoid (mconcat)
import           Web.Scotty
import qualified Web.Scotty  as S

routes = do
  S.get "/" $
    S.text "hello"

  S.get "/some-json" $
    S.json $ object ["foo" .= Number 23, "bar" .= Number 42]

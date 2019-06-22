{-# LANGUAGE OverloadedStrings #-}

module Lib where

import           Web.Scotty

routes :: ScottyM ()
routes = do
  get "/echo" $
    text ""

  post "/echo" $
    text ""

  put "/echo" $
    text ""

  patch "/echo" $
    text ""

  delete "/echo" $
    text ""

  options "/echo" $
    text ""

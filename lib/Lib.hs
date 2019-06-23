{-# LANGUAGE OverloadedStrings #-}

module Lib where

import           Data.Aeson
import qualified Data.Text.Lazy as L
import           Web.Scotty     as S

queryToJson :: [S.Param] -> Value
queryToJson query = object ["params" .= map (\(key, value) -> (L.toStrict key, String $ L.toStrict value)) query]

routes :: ScottyM ()
routes = do
  S.get "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

  S.post "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

  S.put "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

  S.patch "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

  S.delete "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

  S.options "/echo" $ do
    query <- S.params
    S.json $ queryToJson query

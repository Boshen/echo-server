{-# LANGUAGE OverloadedStrings #-}

module Lib where

import           Control.Monad
import           Data.Aeson
import qualified Data.Text.Lazy as L
import           Web.Scotty     as S

toResponse :: ToJSON a => [S.Param] -> a -> Value
toResponse query payload =
  object [ "query" .= object (map (\(key, value) -> (L.toStrict key, String $ L.toStrict value)) query)
         , "payload" .= payload
         ]

routes :: ScottyM ()
routes =
  forM_ [S.get, S.post, S.put, S.patch, S.delete, S.options] $ \method ->
    method "/echo" $ do
      query <- S.params
      payload <- jsonData
      headrs <- headers
      mapM_ (uncurry S.addHeader) (filter (\(k, _) -> L.isPrefixOf "echo" k) headrs)
      S.json $ toResponse query (payload :: Value)

{-# LANGUAGE OverloadedStrings #-}

module Echo where

import           Control.Monad
import           Data.Aeson
import qualified Data.Text.Lazy as L
import           Web.Scotty     as S

toResponse :: ToJSON a => [(L.Text, L.Text)] -> [S.Param] -> a -> Value
toResponse hds query payload =
  object [ "headers" .= object (map (\(key, value) -> (L.toStrict key, String $ L.toStrict value)) hds)
         , "payload" .= payload
         , "query" .= object (map (\(key, value) -> (L.toStrict key, String $ L.toStrict value)) query)
         ]

routes :: ScottyM ()
routes =
  forM_ [S.get, S.post, S.put, S.patch, S.delete, S.options] $ \method ->
    method "/echo" $ do
      query <- S.params
      payload <- jsonData `rescue` const (return $ object [])
      hds <- headers
      S.json $ toResponse hds query (payload :: Value)

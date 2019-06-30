[![Build Status](https://travis-ci.com/Boshen/echo-server.svg?branch=master)](https://travis-ci.com/Boshen/echo-server)

# Echo Server

A restful server that echoes everything.

Supports:
  * `get`, `post`, `put`, `patch`, `delete`, `options` methods
  * change status code via `echo-status`
  * displays query params, json payload and headers inside response body

```
cabal new-install --only-dependencies --enable-tests
```

## Development
```
make watch
```

## Test
```
make test-watch
```

## Build and Run
```
make build
make run
```

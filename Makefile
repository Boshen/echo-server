.PHONY : test

start:
	ghcid --warnings --clear --command="cabal new-repl exe:echo-server" --test="Main.main"

watch:
	ghcid --warnings --clear --command="cabal new-repl spec" --test="Main.main"

build:
	cabal new-build

run:
	cabal new-run echo-server -- --port 9000

test:
	cabal new-run spec

ci:
	cabal new-update && make test

nix:
	hpack && cabal2nix . > project.nix

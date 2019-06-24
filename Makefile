watch:
	ghcid --warnings --clear --command="cabal new-repl exe:echo-server" --test="Main.main"

watch-test:
	ghcid --warnings --clear --command="cabal new-repl echo-server-test" --test="Main.main"

build:
	cabal new-build

run:
	cabal new-run

nix:
	cabal2nix . > project.nix

watch:
	ghcid --warnings --clear --command="cabal new-repl exe:echo-server" --test="Main.main"

watch-test:
	ghcid --warnings --clear --command="cabal new-repl echo-server-test" --test="Main.main"

nix:
	cabal2nix . > project.nix

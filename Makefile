watch:
	ghcid --warnings --clear --command="ghci src/Main.hs" --test=":main"

watch-test:
	ghcid --warnings --clear --command="ghci test/Spec.hs" --test=":main"

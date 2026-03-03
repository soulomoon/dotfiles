#!/bin/bash

rm -rf **/default-config.golden.json
rm -rf **/vscode-extension-schema.golden.json
for version in 9.2.8 9.4.8 9.6.4 9.8.1
do
    ghcup run --ghc $version -- cabal test func-test --test-option="-p /generate schema/"
done




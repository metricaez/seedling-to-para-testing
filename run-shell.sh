#!/bin/bash

###############################################################################
### Run Shell ##############################################################
###############################################################################

echo "Build genesis head and code for local"

# ./bin/mythical-node build-spec\
#   --disable-default-bootnode\
#   --chain=mainnet-dev > ./resources/mythical-shell-local.json

# ./bin/mythical-node build-spec\
#   --chain ./resources/mythical-shell-local.json\
#   --raw\
#   --disable-default-bootnode > ./resources/mythical-shell-local-raw.json

# ./bin/mythical-node export-genesis-state --chain ./resources/mythical-shell-local-raw.json > ./resources/mythical-shell-local-head-data
# ./bin/mythical-node export-genesis-wasm --chain ./resources/mythical-shell-local-raw.json > ./resources/mythical-shell-local-code

# # RUST_LOG=runtime=debug,aura=debug,cumulus=debug,cumulus-collator=debug,nacho=debug
# # export RUST_LOG

# Collator 1
./bin/mythical-node\
  --alice\
  --collator\
  --force-authoring\
  --tmp\
  --port 40333\
  --rpc-port 9966\
  --execution=wasm\
  --chain=./resources/mythical-shell-local-raw.json\
  --discover-local\
  --node-key=d4d4f19746cabb9724cb65ab5ac0274ccd55157f2f6e2f089c0bb3628298a110\
  --\
  --execution=wasm\
  --chain=./resources/polkadot-local-fast-sudo-raw.json\
  --rpc-port 9933\
  --discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWKuRepW8XoBB7rJ4VmPcWt1VUZp6ndHZMuMwgSVQ1JmV7\
  --port 30333 &> ./logs/shell-collator-alice.log&

# Collator 2
./bin/mythical-node\
  --bob\
  --collator\
  --force-authoring\
  --tmp\
  --port 40334\
  --rpc-port 9977\
  --execution=wasm\
  --chain=./resources/mythical-shell-local-raw.json\
  --discover-local\
  --bootnodes=/ip4/127.0.0.1/tcp/40333/p2p/12D3KooWQsJk94ZpZVGtuyWvPuizCNoDsroL9SQk2aYdiQW8LQtG\
  --\
  --execution=wasm\
  --chain=./resources/polkadot-local-fast-sudo-raw.json\
  --rpc-port 9934\
  --discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWKuRepW8XoBB7rJ4VmPcWt1VUZp6ndHZMuMwgSVQ1JmV7\
  --port 30334 &> ./logs/shell-collator-bob.log&
#!/bin/bash

###############################################################################
### Run Seedling ##############################################################
###############################################################################

echo "Seedling start up"

# ./bin/polkadot-parachain build-spec\
#   --disable-default-bootnode\
#   --chain=seedling > ./resources/seedling-local.json

./bin/polkadot-parachain build-spec\
  --chain ./resources/seedling-local.json\
  --raw\
  --disable-default-bootnode > ./resources/seedling-local-raw.json

./bin/polkadot-parachain export-genesis-state --chain ./resources/seedling-local-raw.json > ./resources/seedling-local-head-data
./bin/polkadot-v1.3.0/polkadot-parachain export-genesis-wasm --chain ./resources/seedling-local-raw.json > ./resources/seedling-local-code

# RUST_LOG=runtime=debug,aura=debug,cumulus=debug,cumulus-collator=debug,nacho=debug
# export RUST_LOG

# Collator 1
./bin/polkadot-parachain\
  --alice\
  --collator\
  --force-authoring\
  --tmp\
  --port 40333\
  --rpc-port 9966\
  --execution=wasm\
  --chain=./resources/seedling-local-raw.json\
  --discover-local\
  --node-key=d4d4f19746cabb9724cb65ab5ac0274ccd55157f2f6e2f089c0bb3628298a110\
  --\
  --execution=wasm\
  --chain=resources/rococo-relay-local-raw.json\
  --rpc-port 9933\
  --discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWKuRepW8XoBB7rJ4VmPcWt1VUZp6ndHZMuMwgSVQ1JmV7\
  --port 30333 &> ./logs/seedling-collator-alice.log&

# Collator 2
./bin/polkadot-parachain\
  --bob\
  --collator\
  --force-authoring\
  --tmp\
  --port 40334\
  --rpc-port 9977\
  --execution=wasm\
  --chain=./resources/seedling-local-raw.json\
  --discover-local\
  --bootnodes=/ip4/127.0.0.1/tcp/40333/p2p/12D3KooWQsJk94ZpZVGtuyWvPuizCNoDsroL9SQk2aYdiQW8LQtG\
  --\
  --execution=wasm\
  --chain=resources/rococo-relay-local-raw.json\
  --rpc-port 9934\
  --discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWKuRepW8XoBB7rJ4VmPcWt1VUZp6ndHZMuMwgSVQ1JmV7\
  --port 30334 &> ./logs/seedling-collator-bob.log&
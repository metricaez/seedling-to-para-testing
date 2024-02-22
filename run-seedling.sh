#!/bin/bash

###############################################################################
### Run Seedling ##############################################################
###############################################################################

echo "Seedling start up"

# ./bin/polkadot-v1.3.0/polkadot-parachain build-spec\
#   --disable-default-bootnode\
#   --chain=seedling > ./resources/seedling-local.json

./bin/polkadot-v1.3.0/polkadot-parachain build-spec\
  --chain ./resources/seedling-local.json\
  --raw\
  --disable-default-bootnode > ./resources/seedling-local-raw.json

./bin/polkadot-v1.3.0/polkadot-parachain export-genesis-state --chain ./resources/seedling-local-raw.json > ./resources/seedling-local-head-data
./bin/polkadot-v1.3.0/polkadot-parachain export-genesis-wasm --chain ./resources/seedling-local-raw.json > ./resources/seedling-local-code

# RUST_LOG=runtime=debug,aura=debug,cumulus=debug,cumulus-collator=debug,nacho=debug
# export RUST_LOG

# Collator 1
./bin/polkadot-v1.3.0/polkadot-parachain\
  --alice\
  --collator\
  --force-authoring\
  --tmp\
  --port 40333\
  --ws-port 9966\
  --execution=wasm\
  --chain=ricardo-seedling-mainnet/watr-spec-raw.json\
  --\
  --execution=wasm\
  --chain=resources/relay-local-raw.json\
  --ws-port 9945\
  --port 30335 &> ./logs/seedling-collator-alice.log&

# Collator 2
./bin/polkadot-v1.3.0/polkadot-parachain\
  --bob\
  --collator\
  --force-authoring\
  --tmp\
  --port 40334\
  --ws-port 9977\
  --execution=wasm\
  --chain=ricardo-seedling-mainnet/watr-spec-raw.json\
  --\
  --execution=wasm\
  --chain=resources/relay-local-raw.json\
  --ws-port 9946\
  --port 30336 &> ./logs/seedling-collator-bob.log&
#!/bin/bash

###############################################################################
### Run Chain Spec Build ###########################################################
###############################################################################

echo "Relaychain start up"

RUNTIME_RELAY_SOURCE="rococo-local"

./bin/polkadot build-spec\
  --disable-default-bootnode\
  --chain $RUNTIME_RELAY_SOURCE > ./resources/chain-specs/source.json

./bin/polkadot build-spec\
  --chain ./resources/chain-specs/source.json\
  --raw\
  --disable-default-bootnode > ./resources/chain-specs/source-raw.json
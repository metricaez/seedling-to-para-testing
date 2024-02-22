#!/bin/bash

###############################################################################
### Run Relay Chain ###########################################################
###############################################################################

echo "Relaychain start up"

# ./bin/polkadot-v1.4.0/polkadot build-spec\
#   --disable-default-bootnode\
#   --chain=rococo-local > ./resources/rococo-relay-local.json

# ./bin/polkadot-v1.4.0/polkadot build-spec\
#   --chain ./resources/rococo-relay-local.json\
#   --raw\
#   --disable-default-bootnode > ./resources/rococo-relay-local-raw.json

# RUST_LOG=runtime=trace,runtime::bridge=trace,runtime::bridge-messages=trace
RUST_LOG=system=debug,paras=debug,nacho=debug,parachain::candidate-validation=debug,parachain::availability,runtime::inclusion,parachain::collation-generation=trace,parachain::candidate-backing=trace,parachain::bitfield-signing=trace,parachain::approval-voting=trace,parachain::availability-recovery=trace,parachain::availability-distribution=trace
export RUST_LOG

# start nodes
./bin/polkadot-v1.4.0/polkadot\
  --tmp\
	--chain=./resources/rococo-relay-local-raw.json\
    -ldebug\
	--alice\
	--node-key=12D3KooWPJmLUNzFV7EyBtu1ijmFvvL33AXzCBD6V41L8CRTpFJ1\
	--port=30333\
	--rpc-port=9933\
	--execution=wasm\
	--rpc-cors=all\
	--discover-local\
	--unsafe-rpc-external &> ./logs/alice.log&

./bin/polkadot-v1.4.0/polkadot\
    --tmp\
	--chain=./resources/rococo-relay-local-raw.json\
	--bob\
	--port=30334\
	--rpc-port=9934\
	--execution=wasm\
	--rpc-cors=all\
	--discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30303/p2p/12D3KooWPJmLUNzFV7EyBtu1ijmFvvL33AXzCBD6V41L8CRTpFJ1\
	--unsafe-rpc-external &> ./logs/bob.log&

# ./bin/polkadot-v1.4.0/polkadot\
#     --tmp\
# 	--chain=./resources/rococo-relay-local-raw.json\
# 	--charlie\
# 	--port=30335\
# 	--rpc-port=9935\
# 	--execution=wasm\
# 	--rpc-cors=all\
# 	--unsafe-rpc-external &> ./logs/charlie.log&

# ./bin/polkadot-v1.4.0/polkadot\
#     --tmp\
# 	--chain=./resources/rococo-relay-local-raw.json\
# 	--dave\
# 	--port=30336\
# 	--rpc-port=9936\
# 	--execution=wasm\
# 	--rpc-cors=all\
# 	--unsafe-rpc-external &> ./logs/dace.log&


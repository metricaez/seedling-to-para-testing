#!/bin/bash

###############################################################################
### Run Relay Chain ###########################################################
###############################################################################

echo "Relaychain start up"

# ./bin/polkadot build-spec\
#   --disable-default-bootnode\
#   --chain=rococo-local > ./resources/rococo-relay-local.json

# ./bin/polkadot build-spec\
#   --chain ./resources/rococo-relay-local.json\
#   --raw\
#   --disable-default-bootnode > ./resources/rococo-relay-local-raw.json

# RUST_LOG=runtime=trace,runtime::bridge=trace,runtime::bridge-messages=trace
RUST_LOG=system=debug,paras=debug,nacho=debug,parachain::candidate-validation=debug,parachain::availability,runtime::inclusion,parachain::collation-generation=trace,parachain::candidate-backing=trace,parachain::bitfield-signing=trace,parachain::approval-voting=trace,parachain::availability-recovery=trace,parachain::availability-distribution=trace
export RUST_LOG

# start nodes
./bin/polkadot\
  --tmp\
	--chain=./resources/rococo-relay-local-raw.json\
    -ldebug\
	--alice\
	--node-key=232f426e458a93708cb1a0abc787653f5adc21ae81a5e5aa3d6a33be063722b8\
	--port=30333\
	--rpc-port=9933\
	--execution=wasm\
	--rpc-cors=all\
	--discover-local\
	--unsafe-rpc-external &> ./logs/alice.log&

./bin/polkadot\
    --tmp\
	--chain=./resources/rococo-relay-local-raw.json\
	--bob\
	--port=30334\
	--rpc-port=9934\
	--execution=wasm\
	--rpc-cors=all\
	--discover-local\
	--bootnodes=/ip4/127.0.0.1/tcp/30333/p2p/12D3KooWKuRepW8XoBB7rJ4VmPcWt1VUZp6ndHZMuMwgSVQ1JmV7\
	--unsafe-rpc-external &> ./logs/bob.log&
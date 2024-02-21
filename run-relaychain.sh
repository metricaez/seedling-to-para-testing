#!/bin/bash

###############################################################################
### Run Relay Chain ###########################################################
###############################################################################

echo "Relaychain start up"

# ./bin/polkadot build-spec\
#   --disable-default-bootnode\
#   --chain $RUNTIME_RELAY_SOURCE > ./resources/chain-specs/source.json

# ./bin/polkadot build-spec\
#   --chain ./resources/chain-specs/source.json\
#   --raw\
#   --disable-default-bootnode > ./resources/chain-specs/source-raw.json

# RUST_LOG=runtime=trace,runtime::bridge=trace,runtime::bridge-messages=trace
RUST_LOG=system=debug,paras=debug,nacho=debug,parachain::candidate-validation=debug,parachain::availability,runtime::inclusion,parachain::collation-generation=trace,parachain::candidate-backing=trace,parachain::bitfield-signing=trace,parachain::approval-voting=trace,parachain::availability-recovery=trace,parachain::availability-distribution=trace
export RUST_LOG

# start nodes
./bin/polkadot\
  --tmp\
	--chain=rococo-local\
	--workers-path=./bin\
	--name=alice\
	--node-key=2bd806c97f0e00af1a1fc3328fa763a9269723c8db8fac4f93af71db186d6e90\
	--validator\
	--insecure-validator-i-know-what-i-do\
	--listen-addr=/ip4/0.0.0.0/tcp/49889/ws\
	--rpc-port=9933\
	--execution=wasm\
	--rpc-cors=all\
	--rpc-methods=unsafe\
	--unsafe-rpc-external\
	--no-telemetry\
	--no-mdns &> ./logs/alice.log&

# ./bin/polkadot\
#   --tmp\
#   	--chain=rococo-local\
# 	--workers-path=./bin\
# 	--bob\
# 	--port=30334\
# 	--rpc-port=9934\
# 	--execution=wasm\
# 	--rpc-cors=all\
# 	--unsafe-rpc-external &> ./logs/bob.log&
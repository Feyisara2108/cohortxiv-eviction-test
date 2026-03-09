.DEFAULT_GOAL := help
#  make deploy NETWORK=sepolia //TO DEPLOY

include .env

NETWORK ?= anvil
SCRIPT ?= script/Counter.s.sol:CounterScript

ANVIL_RPC_URL = http://127.0.0.1:8545

.PHONY: build test test-verbose coverage gas clean format

build:
	forge build

test:
	forge test

test-verbose:
	forge test -vvvv

coverage:
	forge coverage

gas:
	forge snapshot

format:
	forge fmt

clean:
	forge clean

anvil:
	anvil


deploy:
ifeq ($(NETWORK),anvil)
	forge script $(SCRIPT) \
		--rpc-url $(ANVIL_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast
endif

ifeq ($(NETWORK),sepolia)
	forge script $(SCRIPT) \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY)
endif

ifeq ($(NETWORK),mainnet)
	forge script $(SCRIPT) \
		--rpc-url $(MAINNET_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY)
endif

verify:
ifeq ($(NETWORK),sepolia)
	forge verify-contract \
		--chain-id 11155111 \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		$(ADDRESS) \
		src/YourContract.sol:YourContract
endif

ifeq ($(NETWORK),mainnet)
	forge verify-contract \
		--chain-id 1 \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		$(ADDRESS) \
		src/YourContract.sol:YourContract
endif

fork-test:
	forge test --fork-url $(SEPOLIA_RPC_URL)
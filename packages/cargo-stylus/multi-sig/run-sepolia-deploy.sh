#!/bin/bash

set -e

# Arbitrum Sepolia RPC
SEPOLIA_RPC_URL="https://sepolia-rollup.arbitrum.io/rpc"

# Ensure PRIVATE_KEY is set
if [[ -z "$PRIVATE_KEY" ]]; then
  echo "❌ Error: PRIVATE_KEY environment variable is not set."
  echo "Run: export PRIVATE_KEY=your_private_key"
  exit 1
fi

# Check for required tools
for cmd in cast cargo curl; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Error: $cmd is not installed."
    exit 1
  fi
done

# Check RPC connection
echo "🌐 Checking connection to Arbitrum Sepolia..."
if ! curl -s -X POST -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"net_version","params":[],"id":1}' \
  "$SEPOLIA_RPC_URL" > /dev/null; then
    echo "❌ Error: Cannot connect to Arbitrum Sepolia RPC."
    exit 1
fi
echo "✅ Connected to Arbitrum Sepolia."

# Deploy Multi-Sig contract using cargo stylus
echo "🚀 Deploying Multi-Sig Stylus contract..."
deploy_output=$(cargo stylus deploy -e "$SEPOLIA_RPC_URL" --private-key "$PRIVATE_KEY" --no-verify 2>&1)

if [[ $? -ne 0 ]]; then
    echo "❌ Error: Contract deployment failed."
    echo "$deploy_output"
    exit 1
fi

# Extract transaction hash
deployment_tx=$(echo "$deploy_output" | grep -i "transaction\|tx" | grep -oE '0x[a-fA-F0-9]{64}' | head -1)
if [[ -z "$deployment_tx" ]]; then
  deployment_tx=$(echo "$deploy_output" | grep -oE '0x[a-fA-F0-9]{64}' | head -1)
fi

# Extract contract address
contract_address=$(echo "$deploy_output" | grep -i "contract\|deployed" | grep -oE '0x[a-fA-F0-9]{40}' | head -1)
if [[ -z "$contract_address" ]]; then
  contract_address=$(echo "$deploy_output" | grep -oE '0x[a-fA-F0-9]{40}' | head -1)
fi

# Validate extraction
if [[ -z "$deployment_tx" ]]; then
  echo "❌ Error: Could not extract transaction hash."
  echo "$deploy_output"
  exit 1
fi

echo "✅ Multi-Sig contract deployed successfully!"
echo "📄 Transaction Hash: $deployment_tx"
if [[ ! -z "$contract_address" ]]; then
  echo "🏠 Contract Address: $contract_address"
fi

# Generate ABI
echo "🛠️ Generating ABI for the Multi-Sig contract..."
cargo stylus export-abi > stylus-contract.abi

if [[ $? -ne 0 ]]; then
  echo "❌ Error: ABI generation failed."
  exit 1
fi
echo "✅ ABI saved to stylus-contract.abi"

# Save deployment metadata
mkdir -p build
echo "{
  \"network\": \"arbitrum-sepolia\",
  \"contract_address\": \"$contract_address\",
  \"transaction_hash\": \"$deployment_tx\",
  \"rpc_url\": \"$SEPOLIA_RPC_URL\",
  \"deployment_time\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"
}" > build/stylus-deployment-info.json

echo "📁 Deployment info saved to build/stylus-deployment-info.json"
echo "🎉 Multi-Sig contract deployment completed successfully!"

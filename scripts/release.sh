#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Run all scripts in the correct order
echo "Running release-api..."
./scripts/release-api.sh

echo "Running release-server..."
./scripts/release-server.sh

echo "Running wsrepo..."
./scripts/release-wsrepo.sh

echo "✅ All scripts executed successfully!"

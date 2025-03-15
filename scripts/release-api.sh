#!/bin/bash

set -e

PROJECT_ROOT="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
VIRTUAL_ENV="$PROJECT_ROOT/.venv"

SERVICE_NAME="api"

cd "$PROJECT_ROOT" || exit

# Setup documentation template
pushd "scripts/semantic-release/templates" >/dev/null || exit

rm -rf scripts/semantic-release/documentation/
mkdir -p "scripts/semantic-release/documentation/docs/"
cp -r .base_changelog_template/ "scripts/semantic-release/documentation/docs/$SERVICE_NAME"

popd >/dev/null || exit

# Release the service
pushd "packages/$SERVICE_NAME" >/dev/null || exit

printf '%s\n' "Releasing $SERVICE_NAME..."
"$VIRTUAL_ENV/bin/semantic-release" -vv version

# printf '%s\n' "Writing changelog for $SERVICE_NAME..."
# "$VIRTUAL_ENV/bin/semantic-release" -v changelog

popd >/dev/null || exit
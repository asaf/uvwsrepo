#!/bin/bash

set -e

PROJECT_ROOT="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
VIRTUAL_ENV="$PROJECT_ROOT/.venv"

cd "$PROJECT_ROOT" || exit

SERVICE_NAME="api"

# Setup documentation template
pushd "documentation/templates" >/dev/null || exit

rm -rf documentation/
mkdir -p "documentation/docs/"
cp -r .base_changelog_template/ "documentation/docs/$SERVICE_NAME"

popd >/dev/null || exit

# Release the service
pushd "packages/$SERVICE_NAME" >/dev/null || exit

printf '%s\n' "Releasing $SERVICE_NAME..."
"$VIRTUAL_ENV/bin/semantic-release" -v version

"$VIRTUAL_ENV/bin/semantic-release" -v publish

# printf '%s\n' "Writing changelog for $SERVICE_NAME..."
# "$VIRTUAL_ENV/bin/semantic-release" -v changelog

popd >/dev/null || exit
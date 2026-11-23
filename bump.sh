#!/usr/bin/env bash
# Updates Casks/agentawake.rb to a published agent-awake release. Usage: ./bump.sh 1.2.0
set -euo pipefail
cd "$(dirname "$0")"
VERSION="${1:?usage: ./bump.sh X.Y.Z}"
URL="https://github.com/seneralkan/agent-awake/releases/download/v$VERSION/AgentAwake-$VERSION.zip"
SHA=$(curl -fsSL "$URL" | shasum -a 256 | awk '{print $1}')
sed -i '' -E "s/^  version \".*\"/  version \"$VERSION\"/; s/^  sha256 \".*\"/  sha256 \"$SHA\"/" Casks/agentawake.rb
echo "agentawake → $VERSION ($SHA)"

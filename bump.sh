#!/usr/bin/env bash
#
# Bump the lynkr formula to a newer release of the `lynkr` npm package.
#
# Usage:
#   ./bump.sh            # bump to the npm "latest" dist-tag
#   ./bump.sh 9.6.0      # bump to a specific version
#
# It rewrites the `url` and `sha256` lines in Formula/lynkr.rb. It does NOT
# commit — the GitHub Action (or you) handles that. Exits 0 with no changes if
# the formula is already at the target version.

set -euo pipefail

PKG="lynkr"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA="${SCRIPT_DIR}/Formula/${PKG}.rb"

[ -f "$FORMULA" ] || { echo "formula not found: $FORMULA" >&2; exit 1; }

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

# Resolve target version (arg, else npm "latest").
VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  VERSION="$(curl -fsSL "https://registry.npmjs.org/${PKG}/latest" \
    | grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)"
fi
[ -n "$VERSION" ] || { echo "could not resolve latest version from npm" >&2; exit 1; }

CURRENT="$(grep -oE "${PKG}-[0-9][^/\"]*\.tgz" "$FORMULA" \
  | sed -E "s/${PKG}-(.*)\.tgz/\1/" | head -1)"

echo "current=${CURRENT:-unknown} target=${VERSION}"
if [ "$CURRENT" = "$VERSION" ]; then
  echo "already at ${VERSION} — nothing to do"
  exit 0
fi

URL="https://registry.npmjs.org/${PKG}/-/${PKG}-${VERSION}.tgz"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
curl -fsSL "$URL" -o "$TMP"
SHA="$(sha256_of "$TMP")"
echo "url=${URL}"
echo "sha256=${SHA}"

# Rewrite only the tarball url + its sha256. The url pattern is anchored to a
# lynkr `.tgz` value so it never touches the livecheck `url` (which points at
# .../lynkr/latest). The # delimiter avoids escaping the URL slashes.
OUT="$(mktemp)"
sed -E \
  -e "s#^([[:space:]]*url \")https://registry\.npmjs\.org/${PKG}/-/${PKG}-[^\"]*\.tgz(\")#\1${URL}\2#" \
  -e "s#^([[:space:]]*sha256 \")[^\"]*(\")#\1${SHA}\2#" \
  "$FORMULA" > "$OUT"
mv "$OUT" "$FORMULA"

echo "bumped ${PKG} ${CURRENT:-?} -> ${VERSION}"

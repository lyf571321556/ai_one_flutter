#!/usr/bin/env bash
# Script to download asset file from tag release using GitHub API v3.
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# Check dependencies.
set -x
type curl grep sed tr >&2
xargs=$(which gxargs || which xargs)
#GITHUB_API_TOKEN=209dc160ef0a96213eef8d64773a7f9f14a8b3e9
#GITHUB_API_TOKEN=acddbd00328176c25e381859bb11f1c9a4a48e68


# Validate settings.
[ -f ~/.secrets ] && source ~/.secrets
#[ "$GITHUB_API_TOKEN" ] || { echo "Error: Please define GITHUB_API_TOKEN variable." >&2; exit 1; }
[ $# -ne 6 ] && { echo "Usage: $0 [owner] [repo] [tag] [name] [github_token] [save_file_name]"; exit 1; }
[ "$TRACE" ] && set -x
read owner repo tag name github_token save_file_name <<<$@

# Define variables.
GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/$owner/$repo"
GH_TAGS="$GH_REPO/releases/tags/$tag"
AUTH="Authorization: token $github_token"
WGET_ARGS="--content-disposition --auth-no-challenge --no-cookie"
CURL_ARGS="-LJO#"

# Validate token.
curl -o /dev/null -sH "$AUTH" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

# Read asset tags.
response=$(curl -sH "$AUTH" $GH_TAGS)
# Get ID of the asset based on given name.
eval $(echo "$response" | grep -C3 "name.:.\+$name" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')
[ "$id" ] || { echo "Error: Failed to get asset id, response: $response" | awk 'length($0)<100' >&2; exit 1; }
GH_ASSET="$GH_REPO/releases/assets/$id"

# Download asset file.
echo "Downloading asset..." >&2
curl -o "$save_file_name" $CURL_ARGS -H 'Accept: application/octet-stream' "$GH_ASSET?access_token=$github_token"
echo "$0 done." 
#echo "$0 done." >&2

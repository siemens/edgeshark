#!/bin/bash
set -e

# In case the user hasn't set an explicit installation location, avoid polluting
# our own project...
npm list --depth=0 browser-sync &>/dev/null || \
    (cd $HOME && npm install docsify-cli)

echo "starting docsify on port 3300 (and 3301)..."
npm exec -- docsify serve -p 3300 -P 3301 "$@"

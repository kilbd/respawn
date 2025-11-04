#!/bin/env bash
set -e

sudo apt-get update
sudo apt install -y libssl-dev openssl ca-certificates pkg-config \
  build-essential git curl wget

# Clone this repo for to run install scripts
set +e
git ls-remote -q "$HOME/respawn" > /dev/null 2>&1
if [[ "$?" -ne 0 ]]; then
  git clone https://github.com/kilbd/respawn.git "$HOME/respawn"
fi
set -e

cd respawn
# TODO: run everything in ubuntu directory
while IFS= read -r -d '' script; do
    if [[ -x "$script" ]]; then
        source "$script"
    fi
done < <(find "./ubuntu" -name "*.sh" -print0)
cd -

# Clone full dotfiles repo if missing
set +e
git ls-remote -q "$HOME/dotfiles" > /dev/null 2>&1
if [[ "$?" -ne 0 ]]; then
  git clone https://github.com/kilbd/dotfiles.git "$HOME/dotfiles"
fi
set -e

echo 'Linking dotfiles...'
source "$HOME/dotfiles/setup/link.sh"

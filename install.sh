#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt install -y libssl-dev openssl ca-certificates pkg-config \
  build-essential git curl wget
# consider postgresql-client

# Clone this repo for to run install scripts
set +e
if ! git ls-remote -q "$HOME/respawn" > /dev/null 2>&1; then
  git clone https://github.com/kilbd/respawn.git "$HOME/respawn"
fi

cd respawn
failed=()
while IFS= read -r -d '' script; do
    if [[ -x "$script" ]]; then
        source "$script"
        rc=$?
        if [[ $rc -ne 0 ]]; then
            failed+=("$script:$rc")
        fi
    fi
done < <(find "./ubuntu" -name "*.sh" -print0)
cd -

# Clone full dotfiles repo if missing
if ! git ls-remote -q "$HOME/dotfiles" > /dev/null 2>&1; then
  git clone https://github.com/kilbd/dotfiles.git "$HOME/dotfiles"
fi
set -e

echo 'Linking dotfiles...'
source "$HOME/dotfiles/setup/link.sh"

if [[ ${#failed[@]} -gt 0 ]]; then
    echo
    echo "SUMMARY: Some scripts failed:"
    for script in "${failed[@]}"; do
        echo " - $script"
    done
    echo
    echo "You can try to fix them and run again manually."
fi

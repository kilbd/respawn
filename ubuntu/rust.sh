#!/bin/bash

# Install Rust(up)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --quiet
. "$HOME/.cargo/env"

# Install Rust tools
cargo install \
bat \
difftastic \
eza \
nu \
ripgrep \
zellij
# Jujutsu install is slightly different
cargo install --locked --bin jj jj-cli

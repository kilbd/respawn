#!/bin/bash

cd /tmp
go_version="$(curl -s https://go.dev/VERSION?m=text | head -n1).linux-amd64.tar.gz"
wget -q "https://go.dev/dl/$go_version"
rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$go_version"
cd -

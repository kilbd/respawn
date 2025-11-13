#!/bin/bash

cd /tmp
wget 'https://discord.com/api/download?platform=linux&format=deb' -O discord.deb
sudo apt install ./discord.deb
rm discord.deb
cd -

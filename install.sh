#!/usr/bin/env bash
# WireGuard-Go Install
# (C) 2022 Hendra Manudinata
# Reference: https://d.sb/2019/07/wireguard-on-openvz-lxc

echo "* Updating packages index..."
apt update

echo "Installing Go..."
apt install golang-go -y

echo "Installing wireguard-tools..."
apt install wireguard-tools -y --no-install-recommends

echo "Downloading and compiling WireGuard-Go..."
cd /usr/local/src 
wget https://git.zx2c4.com/wireguard-go/snapshot/wireguard-go-0.0.20191012.tar.xz 
tar xvf wireguard-go-0.0.20191012.tar.xz 
cd wireguard-go-0.0.20191012 
make && make install

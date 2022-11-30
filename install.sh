#!/usr/bin/env bash
# WireGuard-Go Install
# (C) 2022 Hendra Manudinata
# Reference: https://d.sb/2019/07/wireguard-on-openvz-lxc
# shellcheck disable=SC2164,SC2050,SC2057

function abort() {
    echo "$1"
    exit 1
}

echo ""
echo "Installing WireGuard Go"
echo ""

echo "* Updating packages index..."
apt update

if [[ ! $(type -p curl) ]]; then
    echo "* Installing Go..."
    apt install golang-go -y
fi

echo "* Installing wireguard-tools..."
apt install wireguard-tools -y --no-install-recommends

echo "* Downloading and compiling WireGuard-Go..."
cd /usr/local/src 
wget https://git.zx2c4.com/wireguard-go/snapshot/wireguard-go-0.0.20191012.tar.xz || abort "[-] Download failed!"
tar xvf wireguard-go-0.0.20191012.tar.xz || abort "[-] Extract failed!"
cd wireguard-go-0.0.20191012
make && make install || abort "[-] Compile failed!"

echo "* Activating WireGuard-Go..."
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo ""
echo "Done!"
echo ""

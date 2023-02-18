#!/bin/bash

echo "Iniciando SSH daemon"
sudo systemctl start sshd

echo "Aplicando configuração nas interfaces 192.168.1.0/24 e 10.200.130.0/24"
sudo netplan apply

echo "Iniciando sessão com OpenVPN"
sudo openvpn3 session-start --config "/home/david/openvpn/device_config.ovpn"

sudo systemctl start netfilter-persistent

sudo sysctl net.ipv4.ip_forward=1

echo "Limpando NATs do iptables"
sudo iptables -t nat -F
sudo iptables -t nat -X

echo "Roteando para servidor MAIN.CENTER.INTERNAL"
sudo iptables -t nat -A PREROUTING -p tcp -d 100.96.1.4 --dport 3389 -j DNAT --to-destination 192.168.1.254:3389
sudo iptables -t nat -A PREROUTING -p tcp -d 100.96.1.4 --dport 2022 -j DNAT --to-destination 192.168.1.254:22
sudo iptables -t nat -A POSTROUTING ! -s 100.96.1.4 -j MASQUERADE

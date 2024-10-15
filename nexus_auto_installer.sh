#!/bin/bash

# ����� 1: ��������� ������������
echo "���������� ������� � ��������� ����������..."
sudo apt update && sudo apt upgrade -y

# ����� 2: ��������� ����������� �������
echo "��������� ����������� �������..."
sudo apt install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip

# ����� 3: ��������� Rust
echo "��������� Rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

# ��������� ��������� ��� Rust
source $HOME/.cargo/env

# ����� 4: ���������� Rust � ������� � �������� ���������
echo "���������� Rust � ������� � �������� ������..."
export PATH="$HOME/.cargo/bin:$PATH"
rustup update
rustc --version

# ����� 5: ������ Prover � ����� ������ screen
echo "������ Prover..."
screen -S nexus -d -m bash -c 'curl https://cli.nexus.xyz/install.sh | sh'

echo -e "\033[1;36m"
echo -e "----�-------�--------�----�  ------�--------�------�--------�--�-----------�-"
echo -e "--�=---�====--L====--�L=--�  --�==--�L====--�--�==--�L====--�--�-------�==--�"
echo -e "--�----�----�-------�-----�  -------�-----�=--------�-----�=---�-------�----�"
echo -e "--�----�--L--�-----�------�  --�==--�--�==-----�==--�--�==-----�-------�----�"
echo -e "----�L------�-----�-------�  --�----�-------�--�----�-------�-------�L-----�-"
echo -e "L===--L=====----L=----L===-  L=---L=-L======-L=---L=-L======-L======--L====--"
echo -e "\033[1;34m"
echo
echo -e "\033[1;32mTelegram community: \033[5;31mhttps://t.me/g7monitor\033[0m"
echo -e "\033[0m"
echo
echo "������ ��������. ����� ��������� � ������ screen, ����������� �������: screen -r nexus"

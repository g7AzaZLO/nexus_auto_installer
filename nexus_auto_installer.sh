#!/bin/bash

# Пункт 1: Установка зависимостей
echo "Обновление системы и установка обновлений..."
sudo apt update && sudo apt upgrade -y

# Пункт 2: Установка необходимых пакетов
echo "Установка необходимых пакетов..."
sudo apt install -y curl screen iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip

# Пункт 3: Установка Rust
echo "Установка Rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Настройка окружения для Rust
source $HOME/.cargo/env

# Пункт 4: Добавление Rust к контуру и проверка установки
echo "Добавление Rust к контуру и проверка версии..."
export PATH="$HOME/.cargo/bin:$PATH"
rustup update
rustc --version

# Пункт 5: Запуск Prover в новом сеансе screen
echo "Запуск Prover..."
screen -S nexus -d -m bash -c 'curl https://cli.nexus.xyz/install.sh | sh'

echo -e "\033[1;36m"
echo -e "████╗░██████╗░███████╗████╗  ░█████╗░███████╗░█████╗░███████╗██╗░░░░░░█████╗░"
echo -e "██╔═╝██╔════╝░╚════██║╚═██║  ██╔══██╗╚════██║██╔══██╗╚════██║██║░░░░░██╔══██╗"
echo -e "██║░░██║░░██╗░░░░░██╔╝░░██║  ███████║░░███╔═╝███████║░░███╔═╝██║░░░░░██║░░██║"
echo -e "██║░░██║░░╚██╗░░░██╔╝░░░██║  ██╔══██║██╔══╝░░██╔══██║██╔══╝░░██║░░░░░██║░░██║"
echo -e "████╗╚██████╔╝░░██╔╝░░████║  ██║░░██║███████╗██║░░██║███████╗███████╗╚█████╔╝"
echo -e "╚═══╝░╚═════╝░░░╚═╝░░░╚═══╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░"
echo -e "\033[1;34m"
echo -e "\033[1;32mTelegram community: \033[5;31mhttps://t.me/g7monitor\033[0m"
echo -e "\033[0m"
echo
echo "Скрипт завершен. Чтобы вернуться к сеансу screen, используйте команду: screen -r nexus"

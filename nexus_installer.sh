#!/bin/bash

# Пункт 1: Установка зависимостей
echo "Update and upgrade..."
sudo apt update && sudo apt upgrade -y

# Пункт 2: Установка необходимых пакетов
echo "Installing packages..."
sudo apt install -y curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip

# Пункт 3: Проверка и установка Rust, если отсутствует
echo "Checking for Rust installation..."
if ! command -v rustc &> /dev/null; then
    echo "Rust not found, installing..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "Rust is already installed."
fi

# Пункт 4: Добавление Rust к контуру и проверка версии
echo "Updating Rust and checking version..."
export PATH="$HOME/.cargo/bin:$PATH"
rustup update
rustc --version

# Пункт 5: Проверка и установка Nexus Prover
NEXUS_HOME=$HOME/.nexus

# Запрос на подтверждение условий использования Nexus Beta
while [ -z "$NONINTERACTIVE" ]; do
    read -p "Do you agree to the Nexus Beta Terms of Use (https://nexus.xyz/terms-of-use)? (Y/n) " yn </dev/tty
    case $yn in
        [Nn]* ) echo "Installation cancelled."; exit;;
        [Yy]* ) break;;
        "" ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Проверка наличия git
echo "Checking for git installation..."
if ! command -v git &> /dev/null; then
    echo "Git is required but not found. Please install git and try again."
    exit 1
fi

# Клонирование или обновление репозитория Nexus network-api
echo "Setting up Nexus network-api..."
if [ -d "$NEXUS_HOME/network-api" ]; then
    echo "$NEXUS_HOME/network-api exists. Updating repository."
    (cd $NEXUS_HOME/network-api && git pull)
else
    mkdir -p $NEXUS_HOME
    (cd $NEXUS_HOME && git clone https://github.com/nexus-xyz/network-api)
fi

# Запуск Prover через screen
echo "Starting Nexus Prover in a screen session..."
screen -S nexus -d -m bash -c "(cd $NEXUS_HOME/network-api/clients/cli && cargo run --release --bin prover -- beta.orchestrator.nexus.xyz)"

# Визуализация завершения работы
echo -e "\033[1;36m"
echo -e "████╗░██████╗░███████╗████╗  ░█████╗░███████╗░█████╗░███████╗██╗░░░░░░█████╗░"
echo -e "██╔═╝██╔════╝░╚════██║╚═██║  ██╔══██╗╚════██║██╔══██╗╚════██║██║░░░░░██╔══██╗"
echo -e "██║░░██║░░██╗░░░░░██╔╝░░██║  ███████║░░███╔═╝███████║░░███╔═╝██║░░░░░██║░░██║"
echo -e "██║░░██║░░╚██╗░░░██╔╝░░░██║  ██╔══██║██╔══╝░░██╔══██║██╔══╝░░██║░░░░░██║░░██║"
echo -e "████╗╚██████╔╝░░██╔╝░░████║  ██║░░██║███████╗██║░░██║███████╗███████╗╚█████╔╝"
echo -e "╚═══╝░╚═════╝░░░╚═╝░░░╚═══╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░"
echo -e "\033[1;34m"
echo
echo -e "\033[1;32mTelegram community: \033[5;31mhttps://t.me/g7monitor\033[0m"
echo -e "\033[0m"
echo
echo "Установка завершена. Для просмотра логов зайдите в скрин сессию: screen -r nexus"

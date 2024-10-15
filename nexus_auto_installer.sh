#!/bin/bash

# Функция для отображения прогресс-бара
progress_bar() {
    local duration=$1
    local bar="######################################################################"
    local max_len=${#bar}

    for ((i=1; i<=max_len; i++)); do
        printf "\r[%-*.*s]" "$i" "$i" "$bar"
        sleep "$duration"
    done
    echo
}

# Пункт 1: Установка зависимостей
echo "Пункт 1: Обновление системы и установка обновлений..."
progress_bar 0.02
sudo apt update && sudo apt upgrade -y
echo -e "\033[1;32mЗавершено: Обновление системы и установка обновлений.\033[0m"
echo

# Пункт 2: Установка необходимых пакетов
echo "Пункт 2: Установка необходимых пакетов..."
progress_bar 0.02
sudo apt install -y curl screen iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip
echo -e "\033[1;32mЗавершено: Установка необходимых пакетов.\033[0m"
echo

# Пункт 3: Установка Rust
echo "Пункт 3: Установка Rust..."
progress_bar 0.02
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
echo -e "\033[1;32mЗавершено: Установка Rust.\033[0m"
echo

# Пункт 4: Добавление Rust к контуру и проверка установки
echo "Пункт 4: Добавление Rust к контуру и проверка версии..."
progress_bar 0.02
export PATH="$HOME/.cargo/bin:$PATH"
rustup update
rustc --version
echo -e "\033[1;32mЗавершено: Добавление Rust к контуру и проверка версии.\033[0m"
echo

# Пункт 5: Запуск Prover в новом сеансе screen
echo "Пункт 5: Запуск Prover..."
progress_bar 0.02
screen -S nexus -d -m bash -c 'curl https://cli.nexus.xyz/install.sh | sh'
echo -e "\033[1;32mЗавершено: Запуск Prover.\033[0m"
echo

# Визуализация завершения работы
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

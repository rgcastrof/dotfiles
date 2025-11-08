#!/bin/bash

# Versão atual que você usa
current=$(uname -r)
DIR="/usr/src"

# Pega a lista de versões LTS do site kernel.org
avaliable=$(curl -s https://www.kernel.org/ | grep -A1 "longterm:" | grep -Eo '6\.12\.[0-9]+' | head -n1)
distfile=$(curl -s https://www.kernel.org/ | grep "$avaliable" | grep "tarball" | cut -f2 -d "\"")

# Verifica se tem nova versão
if [ "$current" != "$avaliable" ]; then
    echo "Nova versão do kernel LTS 6.12 disponível: $avaliable (atual: $current)"
	read -p "Baixar o código fonte? [s/N]: " answer
	if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
		if wget -nc -P "$DIR" "$distfile"; then
			echo "Download do fonte do kernel completo em $DIR"
		fi
	fi
else
    echo "Você já está com a versão mais recente do kernel LTS 6.12 ($current)."
fi

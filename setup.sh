#!/bin/bash

set -e

DIR_CONFIG="$HOME/.config"
ip=$(ip -4 addr show wlan0 | grep inet | awk '{print $2}')

# install packages
echo "updating system"
sudo pacman -Syu --noconfirm

echo "installing packages from pkgs.txt"
sudo pacman -S --needed --noconfirm $(< pkgs.txt)

clear

echo "enabling services"
echo "enabling tlp"
sudo ln -sf /etc/runit/sv/tlp /run/runit/service

echo "enabling ufw firewall"

sudo ln -sf /etc/runit/sv/ufw /run/runit/service
sudo ufw limit 22/tcp
sudo ufw allow from "$ip" to any port 80 proto tcp
sudo ufw allow from "$ip" to any port 443 proto tcp
sudo ufw allow from "$ip" to any port 8080 proto tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable 

echo "enabling docker"
sudo ln -sf /etc/runit/sv/docker /run/runit/service
sudo usermod -aG docker "$USER"

setup_dwm() {
	cp -rf "X11/suckless/.dwm" "$HOME"
	cp -rf "X11/suckless/.dwmblocks" "$HOME"
	cp -rf "X11/suckless/dwm" "$DIR_CONFIG"
	cp -rf "X11/suckless/st" "$DIR_CONFIG"
	cp -rf "X11/suckless/dmenu" "$DIR_CONFIG"
	cp -rf "X11/suckless/slock" "$DIR_CONFIG"

	make -C "$DIR_CONFIG/dwm" && sudo make -C "$DIR_CONFIG/dwm" install
	make -C "$DIR_CONFIG/st" && sudo make -C "$DIR_CONFIG/st" install
	make -C "$DIR_CONFIG/dmenu" && sudo make -C "$DIR_CONFIG/dmenu" install
	make -C "$DIR_CONFIG/slock" && sudo make -C "$DIR_CONFIG/slock" install
}

clear

echo "configuring graphic session"
sudo cp "X11/*.conf" "/etc/X11/xorg.conf.d/"
mkdir -p "$DIR_CONFIG"
cp -rf "scripts" "$DIR_CONFIG"
setup_dwm
cp -rf "X11/dunst" "$DIR_CONFIG"
cp -rf "X11/picom" "$DIR_CONFIG"
xdg-user-dirs-update
echo "exec dbus-run-session dwm" > "$HOME/.xinitrc"

clear

echo "Finished setup"
read -p "You want to reboot the system [s/n]: " answer

if [[ "$answer" == "s" || "$answer" == "S" ]]; then
	sudo reboot
else
	exit 0
fi

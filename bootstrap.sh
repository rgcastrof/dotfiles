#!/bin/bash
set -e

echo "Verificando conexão com a internet"

while ! ping -q -c 1 -W 2 8.8.8.8 > /dev/null; do
    echo "Sem conexão com internet. Aguarde até a conexão"
    rfkill unblock all
    sleep 10
done

echo "Conectado à internet. Iniciando instalação dos pacotes"
echo "Ativando repositorio nonfree"
xbps-install -S void-repo-nonfree

if [[ -f pkgs.txt ]]; then
    xbps-install -Sy $(< pkgs.txt)
else
    echo "Arquivo com nome dos pacotes não encontrado! Abortando"
    exit 1
fi

configurar_networkmanager() {

    echo "Configurando NetworkManager..."
    rm -f /var/service/dhcpd /var/service/wpa_supplicant
    ln -s /etc/sv/dbus/ /var/service/
    ln -s /etc/sv/NetworkManager/ /var/service/
}

configurar_tlp() {
    ln -s /etc/sv/tlp/ /var/service/
}

configurar_intel_microcode() {
    xbps-reconfigure --force $(xbps-query -l | awk '{ print $2 }' | xargs -n1 xbps-uhelper getpkgname | grep "linux6")
}

configurar_apparmor() {
    echo "configurando apparmor..."

    sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 apparmor=1 security=apparmor"/' /etc/default/grub
    update-grub
}

configurar_interface() {
    rm $HOME/.bashrc $HOME/.bash_profile
    cp $HOME/dotfiles/.bashrc $HOME/
    cp $HOME/dotfiles/.bash_profile $HOME/

    mkdir -p $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/.dwm/ $HOME/
    cp -r $HOME/dotfiles/X11/suckless/.dwmblocks/ $HOME/
    cp -r $HOME/dotfiles/X11/suckless/dwm/ $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/dmenu/ $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/st/ $HOME/.config/

    mkdir -p /etc/X11/xorg.conf.d/
    cp $HOME/dotfiles/X11/30-touchpad.conf /etc/X11/xorg.conf.d/
    cp $HOME/dotfiles/X11/10-keyboard.conf /etc/X11/xorg.conf.d/

    cd $HOME/.config/dwm/
    make && make install
    cd $HOME/.config/st/
    make && make install
    cd $HOME/.config/dmenu/
    make && make install
    cd $HOME/.config/dwm/dwmblocks/
    make && make install
    cd
}

configurar_permissoes() {
    mkdir -p $HOME/.cache/
    chown -R $USER:$USER ~/.cache/
    chmod -R u+rw ~/.cache/
    mkdir -p /etc/udev/rules.d/
    echo SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", GROUP="video", MODE="0660" > /etc/udev/rules.d/90-backlight.rules
}

configurar_fontes() {
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip

    unzip -d JetBrains JetBrainsMono.zip
    unzip -d Hack Hack.zip

    mkdir -p $HOME/.local/share/fonts/
    mv JetBrains/*.ttf $HOME/.local/share/fonts/
    mv Hack/*.ttf $HOME/.local/share/fonts/
    rm Hack.zip JetBrainsMono.zip
    rm -rf Hack JetBrains

    fc-cache -f -v
}

configurar_flatpak() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

configurar_networkmanager
configurar_tlp
configurar_intel_microcode
configurar_apparmor
configurar_interface
configurar_permissoes
configurar_fontes
configurar_flatpak

read -rp "Reiniciar agora? [s/N] " resposta
if [[ "$resposta" =~ ^[sS]$ ]]; then
  reboot
fi

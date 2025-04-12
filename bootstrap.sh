#!/bin/bash
set -e

echo "Ativando repositorio nonfree"
sudo xbps-install -Sy void-repo-nonfree

echo "Iniciando instalação dos pacotes"
if [[ -f pkgs.txt ]]; then
    sudo xbps-install -Sy $(< pkgs.txt)
else
    echo "Arquivo com nome dos pacotes não encontrado! Abortando"
    exit 1
fi

configurar_networkmanager() {

    echo "Configurando NetworkManager..."
    sudo rm -f /var/service/dhcpd /var/service/wpa_supplicant
    sudo ln -s /etc/sv/dbus/ /var/service/
    sudo ln -s /etc/sv/NetworkManager/ /var/service/
    sleep 10

    if [[ sudo sv status NetworkManager | awk '{print $6}' == "run:" && sudo sv status dbus | awk '{print $6}' == "run:" ]]; then
        echo "NetworkManager configurado."
    else
        echo "Erro ao configurar NetworkManager"
    fi

    echo "Redes disponíveis:"
    nmcli device wifi list
    echo "Conecte-se à uma rede:"
    read -rp "SSID: " ssid
    read -rsp "Senha da rede: " senha

    if sudo nmcli dev wifi connect "$ssid" password "$senha"; then
    echo "Conectado com sucesso à rede '$ssid'!"
    else
        echo "Erro ao conectar à rede '$ssid'."
    fi
}

configurar_tlp() {
    sudo ln -s /etc/sv/tlp/ /var/service/
}

configurar_intel_microcode() {
    sudo xbps-reconfigure --force $(xbps-query -l | awk '{ print $2 }' | xargs -n1 xbps-uhelper getpkgname | grep "linux6")
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

    sudo mkdir -p /etc/X11/xorg.conf.d/
    sudo cp $HOME/dotfiles/X11/30-touchpad.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/dotfiles/X11/10-keyboard.conf /etc/X11/xorg.conf.d/

    cd $HOME/.config/dwm/
    make && sudo make install
    cd $HOME/.config/st/
    make && sudo make install
    cd $HOME/.config/dmenu/
    make && sudo make install
    cd $HOME/.config/dwm/dwmblocks/
    make && sudo make install
    cd
}

configurar_permissoes() {
    mkdir -p $HOME/.cache/
    chown -R $USER:$USER ~/.cache/
    chmod -R u+rw ~/.cache/
    sudo mkdir -p /etc/udev/rules.d/
    sudo echo SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", GROUP="video", MODE="0660" > /etc/udev/rules.d/90-backlight.rules
}

configurar_slim() {
    sudo rm -f /etc/slim.conf
    sudo cp $HOME/dotfiles/X11/slim/slim.conf /etc/slim/
    sudo cp -rf $HOME/dotfiles/X11/slim/bluer/ /usr/share/slim/themes/
    sudo ln -s /etc/sv/slim /var/service/
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
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
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
  sudo reboot
fi

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


configurar_tlp() {
    echo "Ativando tlp..."
    sudo ln -s /etc/sv/tlp/ /var/service/
    sleep 3

    status=$(sudo sv status tlp | awk '{print $1}' | tr -d ':')

    if [[ "$status" == "run" ]]; then
        echo "tlp ativo"
    else
        echo "erro ao ativar tlp"
    fi

}

configurar_intel_microcode() {
    echo "Regenerando initramfs..."
    sudo xbps-reconfigure --force $(xbps-query -l | awk '{ print $2 }' | xargs -n1 xbps-uhelper getpkgname | grep "linux6")
}

configurar_apparmor() {
    echo "configurando apparmor..."

    sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 apparmor=1 security=apparmor"/' /etc/default/grub
    sudo update-grub

    echo "apparmor configurado"
}

configurar_interface() {

    echo "Atualizando arquivos .bashrc e .bash_profile..."
    rm -f $HOME/.bashrc $HOME/.bash_profile
    cp $HOME/dotfiles/bash/.bashrc $HOME/
    cp $HOME/dotfiles/bash/.bash_profile $HOME/
    sudo cp $HOME/dotfiles/fetch /usr/local/bin/

    echo "Copiando arquivos de configuração do teclado e touchpad para o xorg..."
    sudo mkdir -p /etc/X11/xorg.conf.d/
    sudo cp $HOME/dotfiles/X11/30-touchpad.conf /etc/X11/xorg.conf.d/
    sudo cp $HOME/dotfiles/X11/10-keyboard.conf /etc/X11/xorg.conf.d/

    echo "Copiando código fonte do dwm para .config..."
    mkdir -p $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/.dwm/ $HOME/
    cp -r $HOME/dotfiles/X11/suckless/.dwmblocks/ $HOME/
    cp -r $HOME/dotfiles/X11/suckless/dwm/ $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/dmenu/ $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/st/ $HOME/.config/
    cp -r $HOME/dotfiles/X11/suckless/slock/ $HOME/.config/


    echo "Compilando software da suckless..."
    cd $HOME/.config/dwm/
    make && sudo make install
    cd $HOME/.config/st/
    make && sudo make install
    cd $HOME/.config/dmenu/
    make && sudo make install
    cd $HOME/.config/slock/
    make && sudo make install
    cd $HOME/.config/dwm/dwmblocks/
    make && sudo make install

    echo "exec dbus-run-session dwm" > $HOME/.xinitrc

    mkdir -p $HOME/Imagens/
    mkdir -p $HOME/Imagens/Screenshots/
    cd $HOME/Imagens/
    git clone https://github.com/rgcastrof/Wallpapers.git
    cd
    xdg-user-dirs-update
}

configurar_dunst() {
    cp -r $HOME/dotfiles/X11/dunst/ $HOME/.config/
}

configurar_picom() {
    mkdir -p $HOME/.config/picom/
    cp $HOME/dotfiles/X11/picom.conf $HOME/.config/picom/
}

configurar_permissoes() {

    echo "Atualizando permissões do diretório ~/.cache..."
    mkdir -p $HOME/.cache/
    chown -R $USER:$USER $HOME/.cache/
    chmod -R u+rw $HOME/.cache/
    echo "Atualizando permissões do brilho da tela..."
    sudo mkdir -p /etc/udev/rules.d/
    echo 'SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", GROUP="video", MODE="0660"' | sudo tee /etc/udev/rules.d/90-backlight.rules > /dev/null
    echo "brightnessctl set 10% > /dev/null" | sudo tee -a /etc/rc.local > /dev/null
}

configurar_hosts() {
    cat <<-EOF | sudo tee /etc/hosts > /dev/null
#
# /etc/hosts: static lookup table for host names
#

#<ip-address>           <hostname.domain.org>   <hostname>
127.0.0.1               localhost.localdomain   localhost
::1                     localhost.localdomain   localhost
127.0.0.1               void.localdomain        void

# End of file
EOF
}

configurar_fontes() {
    echo "Instalando fontes..."
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Agave.zip

    unzip -d JetBrains JetBrainsMono.zip
    unzip -d Hack Hack.zip
    unzip -d Agave Agave.zip

    mkdir -p $HOME/.local/share/fonts/
    mv JetBrains/*.ttf $HOME/.local/share/fonts/
    mv Hack/*.ttf $HOME/.local/share/fonts/
    mv Agave/*.ttf $HOME/.local/share/fonts/
    rm Hack.zip JetBrainsMono.zip Agave.zip
    rm -rf Hack JetBrains Agave

    fc-cache -f -v
}

configurar_git() {
    echo "configurando usuário git"
    git config --global user.email "rogeriogirao1@proton.me"
    git config --global user.name "rgcastrof"
}

configurar_neovim() {
    echo "configurando neovim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    mkdir -p $HOME/.config/nvim/
    cp $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/
}

configurar_doas() {
    cat <<-EOF | sudo tee /etc/doas.conf > /dev/null
permit persist :wheel
permit nopass falcon as root cmd /sbin/poweroff
permit nopass falcon as root cmd /sbin/reboot
permit nopass falcon as root cmd /bin/zzz
EOF
    echo "ignorepkg=sudo" | sudo tee /etc/xbps.d/90-ignore.conf > /dev/null
    doas xbps-remove -Ry sudo
}

configurar_tlp
configurar_intel_microcode
configurar_apparmor
configurar_interface
configurar_dunst
configurar_picom
configurar_permissoes
configurar_hosts
configurar_fontes
configurar_git
configurar_neovim
configurar_doas

echo "Pós-instalação concluída"

read -rp "Reiniciar agora? [s/N] " resposta
if [[ "$resposta" =~ ^[sS]$ ]]; then
    doas reboot
fi

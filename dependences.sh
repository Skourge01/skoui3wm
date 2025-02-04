#!/bin/bash
# Função para verificar e instalar pacotes necessários
install_dependencies() {
    echo "Verificando dependências..."
    if ! command -v git &> /dev/null; then
        echo "Instalando o git..."
        sudo pacman -S --needed --noconfirm git
    fi

    if ! pacman -Qq base-devel &> /dev/null; then
        echo "Instalando base-devel..."
        sudo pacman -S --needed --noconfirm base-devel
    fi
}
check_yay(){
    if command -v yay &> /dev/null; then 
        echo "Yay verificado, instalado" 
    else
        echo "Yay não encontrado, instalando yay.." 
        install_yay 
    else 
}
# Função para baixar e instalar o yay
install_yay() {
    echo "Baixando e instalando o yay..."
    cd /tmp || exit
    if [ -d yay ]; then
        echo "Removendo diretório antigo do yay..."
        rm -rf yay
    fi
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
}
# Função para instalar aplicativos gerais
install_general_apps() {
    echo "Instalando aplicativos gerais..."
    sudo pacman -S --needed --noconfirm \
        firefox \
        neovim \
        discord \
        feh \
        lxappearance \
        materia-gtk-theme \
        ttf-fira-code \
        dmenu \
        alacritty \
        thunar \
        nodejs \
        xorg-server \
        xorg-xinit \
        libx11 \
        libxft \
        libxinerama \
        i3

    yay -S visual-studio-code-bin --noconfirm 
}
# Executar funções
install_dependencies
install_general_apps
# Verificação final
if command -v yay &> /dev/null; then
    echo "yay instalado com sucesso!"
else
    echo "Ocorreu um erro durante a instalação do yay."
fi

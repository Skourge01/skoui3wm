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
# Função para instalar aplicativos gerais
check_and_install() {
    if ! pacman -Qi "$1" &>/dev/null; then
        echo "Instalando $1..."
        sudo pacman -S --needed --noconfirm "$1"
    else
        echo "$1 já está instalado."
    fi
}

install_general_apps() {
    echo "Verificando e instalando aplicativos gerais..."

    apps=(
        firefox
        neovim
        discord
        feh
        lxappearance
        materia-gtk-theme
        ttf-fira-code
        dmenu
        alacritty
        thunar
        nodejs
        xorg-server
        xorg-xinit
        libx11
        libxft
        libxinerama
        i3
    )

    for app in "${apps[@]}"; do
        check_and_install "$app"
    done

    if ! yay -Qi visual-studio-code-bin &>/dev/null; then
        echo "Instalando Visual Studio Code..."
        yay -S visual-studio-code-bin --noconfirm
    else
        echo "Visual Studio Code já está instalado."
    fi
}

# Executar funções
check_yay 
check_and_install
install_general_apps 
# Verificação final
if command -v yay &> /dev/null; then
    echo "yay instalado com sucesso!"
else
    echo "Ocorreu um erro durante a instalação do yay."
fi

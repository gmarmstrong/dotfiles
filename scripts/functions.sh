#!/bin/bash

test_internet_connection() {
    echo "Testing Internet connection..."
    if ping -c 1 google.com >& /dev/null
    then
        echo "Internet connection successful."
    else
        echo "Internet connection failed. Aborting."
        exit 1
    fi
}

get_operating_system() {
    case "$OSTYPE" in
        darwin*) operating_system=Darwin ;;
        linux*) operating_system=Linux ;;
    esac
}

get_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        # TODO Add more cases that use /etc/os-release
        case "$ID" in
            debian) linux_distro=Debian ;;
            ubuntu) linux_distro=Ubuntu ;;
            *) exit 1 ;;
        esac
    else
        echo "Distribution unknown. Aborting."
        exit 1
    fi
}

get_macintosh_version() {
    # TODO Verify https://docs.brew.sh/Installation.html#requirements
    echo "Detecting Macintosh version."
    case sw_vers -productVersion in
        10.10*)
            echo "Macintosh version detected: Mac OS X Yosemite 10.10 (2014)"
            macintosh_version="Yosemite"
            ;;
        10.11*)
            echo "Macintosh version detected: Mac OS X El Capitan 10.10 (2015)"
            macintosh_version="El Capitan"
            ;;
        10.12*)
            echo "Maintosh version detected: macOS Sierra 10.12 (2016)"
            macintosh_version="Sierra"
            ;;
        10.13*)
            echo "Manitosh version detected: macOS High Sierra 10.13 (2017)"
            macintosh_version="High Sierra"
            ;;
        *)
            echo "Macintosh version unknown or not supported. Aborting."
            exit 1
            ;;
    esac
}

symlink_linux_dotfiles() {
    echo "Symlinking Linux dotfiles..."
    read -p "Do you want to use X11 on this system? (y/n) "
    if [ $REPLY =~ ^[Yy]$ ]
    then
        echo "Symlinking X11 dotfiles..."
        ln -s "$HOME/dotfiles/Xresources" "$HOME/.Xresources"
        ln -s "$HOME/dotfiles/i3" "$HOME/.i3"
        ln -s "$HOME/dotfiles/xinitrc" "$HOME/.xinitrc"
    fi
}

symlink_darwin_dotfiles() {
    echo "Symlinking Darwin dotfiles..."
    ln -s "$HOME/dotfiles/Brewfile" "$HOME/Brewfile"
}

symlink_agnostic_dotfiles() {
    echo "Symlinking system-agnostic dotfiles..."
    ln -s "$HOME/dotfiles/gitignore_global" "$HOME/.gitignore_global"
    ln -s "$HOME/dotfiles/newsbeuter" "$HOME/.newsbeuter"
    ln -s "$HOME/dotfiles/vimrc" "$HOME/.vimrc"
    ln -s "$HOME/dotfiles/zshenv" "$HOME/.zshenv"
    ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
    touch "$HOME/.hushlogin"
}

become_sudoer() {
    # FIXME Likely needs relog
    if [[ $linux_distro == Debian ]] || [[ $linux_distro == Ubuntu ]]
    then
        su root -c "apt-get -y install sudo"
        su root -c "adduser $(whoami) sudo"
    fi
}

homebrew_setup() {
    get_macintosh_version
    if ! [ command -v brew ]
    then
        echo "Installing Homebrew."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if ! [ command -v mas ]
    then
        echo "Installing mas."
        brew install mas
    fi
    if [ -z $(mas account) ]; then
        echo "Signing in to the Mac App Store"
        read -p "Enter email used for Mac App Store: " mas_email
        mas signin "$mas_email"
    fi
    brew bundle --file="$HOME/Brewfile"
}

aptget_setup() {
    sudo apt-get update
    sudo apt-get upgrade
    cat "$HOME/dotfiles/packages.txt" | xargs sudo apt-get install
}

git_setup() {
    echo "Configuring Git..."
    git config --global core.excludesfile "$HOME/.gitignore_global"
    if ! [ git config user.email ] || [ git config user.name ]
    then
        read -p "Enter email used for GitHub: " github_email
        git config --global user.email "$gh_email"
        read -p "Enter GitHub username: " github_username
        git config --global user.name "$github_username"
    fi
}

check_user_privileges() {
    if [ ! sudo -v ] && [ $operating_system == Linux ]
    then
        read -p "No super user privileges detected. Do you want to try to get them? (y/n) "
        test $REPLY =~ ^[Yy]$ && become_sudoer
    fi
}

setup_package_manager() {
    if [ sudo -v ]
        case $operating_system in
            Linux)
                case $linux_distro
                    Debian) aptget_setup ;;
                    Ubuntu) aptget_setup ;;
                esac
                ;;
            Darwin) homebrew_setup ;;
        esac
    fi
}

generate_key() {
    mkdir -p "$HOME/.ssh"
    if ! [ -e "$HOME/.ssh/id_rsa" ]
    then
        echo "Generating SSH key..."
        read -p "Enter a unique name for your key: " github_keyname
        ssh-keygen -t rsa -b 4096 -C "$gh_email"
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_rsa"
    fi
}

github_auth() {
    if ! [ ssh -T git@github.com ]
        echo "Uploading public key to GitHub..."
        myjson='{"title":"'"$github_keyname"'","key":"'"$(cat $HOME/.ssh/id_rsa.pub)"'"}'
        eval "curl -u $github_username --data '$myjson' https://api.github.com/user/keys"
    fi
}

vim_setup() {
    curl -fL -o $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +qall
    vim +PlugInstall +qall
}

install_pure_prompt() {
    if ! [ -d "$HOME/.zfunctions" ]
        mkdir "$HOME/.zfunctions"
    fi
    if [ ! -e "$HOME/.zfunctions/pure_prompt_setup" ] || [ ! -e "$HOME/.zfunctions/async" ]
    then
        wget https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh -O "$HOME/.zfunctions/prompt_pure_setup"
        wget https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -O "$HOME/.zfunctions/async"
    fi
}

install_pip() {
    curl https://bootstrap.pypa.io/get-pip.py | sudo python
    curl https://bootstrap.pypa.io/get-pip.py | sudo python3
}

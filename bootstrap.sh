#!/usr/bin/env bash

set -eu

export DEBIAN_FRONTEND=noninteractive

export gcloud_account="722958580111-compute@developer.gserviceaccount.com"

add_deb_repo() {
  # e.g., add_deb_repo foobar foobar.gpg https://foobar.tld/ubuntu main contrib non-free
  repository="/etc/apt/sources.list.d/${1}.list"
  signed_by="/usr/share/keyrings/$2"
  repo_uri="${3}"
  components=("${@:4}")
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$signed_by] $repo_uri $(lsb_release -cs)" "${components[@]}" \
    | sudo tee "$repository" > /dev/null
}

apt_sources() {
  echo " ==> Adding additional APT sources"
  echo -e "\tInstalling APT-related packages"
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg lsb-release software-properties-common

  echo -e "\tImporting public keys"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/hashicorp-keyring.gpg
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo -e "\tAdding apt repositories"
  add_deb_repo docker docker-archive-keyring.gpg https://download.docker.com/linux/ubuntu stable
  add_deb_repo github-cli githubcli-archive-keyring.gpg https://cli.github.com/packages main
  add_deb_repo hashicorp hashicorp-keyring.gpg https://apt.releases.hashicorp.com main
}

apt_upgrade() {
    echo " ==> Upgrading packages"
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get auto-remove -y
}

apt_installs() {
    echo " ==> Installing base packages"
    sudo apt-get update
    sudo apt-get install -y \
      gh \
      git \
      mosh \
      neovim \
      packer \
      python3 \
      python3-pip \
      terraform \
      trash-cli \
      universal-ctags \
      unzip \
      xdg-utils
    sudo apt-get auto-remove -y
}

setup_auths() {
  echo " ==> Authenticating with services"
  echo -e "\tAuthenticating gcloud"
  gcloud config set account "$gcloud_account"
  echo -e "\tAuthenticating gh-cli"
  gcloud secrets versions access latest --secret=github-api-token | gh auth login --with-token
  echo -e "\tAuthenticating git with gh-cli"
  gh auth setup-git
}

additional_installs() {
    if [ ! -d "/etc/google-cloud-ops-agent" ]; then
        echo " ==> Installing Ops Agent"
        curl -fsSL https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh | sudo bash -s -- --also-install
    fi
}

copy_dotfiles() {
    echo " ==> Copying dotfiles"
    cp config/aliases/aliases "${HOME}/.aliases"
    cp config/git/gitconfig "${HOME}/.gitconfig"
    cp config/inputrc "${HOME}/.inputrc"
    mkdir -p "${HOME}/.config/nvim"
    cp -r config/nvim/* "${HOME}/.config/nvim/"
}

vim_plugins_installs() {
    # Install vim-plug
    VIM_PLUG="${HOME}/.config/nvim/autoload/plug.vim"
    if [ ! -f "${VIM_PLUG}" ]; then
        echo " ==> Installing vim-plug"
        curl -fLo "${VIM_PLUG}" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    # Install vim plugins
    LOCAL_BIN="${HOME}/.local/bin"
    if [ -f "${LOCAL_BIN}/nvim.appimage" ]; then
      echo " ==> Installing vim plugins"
      "${LOCAL_BIN}/nvim.appimage --headless +PlugInstall +qall"
    fi
}

do_it() {
    apt_sources             # add apt repository sources
    apt_upgrade             # update apt package index and upgrade packages
    apt_installs            # install apt packages
    setup_auths             # service authentications
    additional_installs     # miscellaneous installations
    copy_dotfiles           # copy dotfiles to their respective locations
    vim_plugins_installs    # install vim plugin manager and plugins
}

do_it

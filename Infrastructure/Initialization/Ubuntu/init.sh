#!/bin/bash

################################################################################
## Author:      Devin W. Leaman (4lch4)                                       ##
## Version:     1.0.0                                                         ##
## Filename:    linux.sh                                                      ##
## Created On:  07/18/2023 @ 17:46                                            ##
################################################################################
## Description:                                                               ##
##                                                                            ##
##                                                                            ##
## This script will install the various software/tools I use and apply my     ##
## various customizations.                                                    ##
################################################################################
## Notes:                                                                     ##
##                                                                            ##
## For some god forsaken reason VSCode has a difficult time with collapsing   ##
## basic functions like `log` or `clone_dotfiles_repo` so I've had to wrap    ##
## them in `region` blocks to make them foldable.                             ##
################################################################################
## Usage:                                                                     ##
##                                                                            ##
## ./linux.sh                                                                 ##
################################################################################

#region Variables
YELLOW_TEXT="\033[1;33m"
GREEN_TEXT="\033[1;32m"
RESET_TEXT="\033[0m"

# Set the Zsh config directory variable.
ZSH_DIR="$HOME/.config/zsh"
#endregion Variables

TMP_DIR=$(mktemp -d -t dotfiles-XXXX)


#region Helper Functions
#region load_colors
function load_colors() {
  curl -o- https://raw.githubusercontent.com/4lch4/Cookbooks/main/Bash/colors.sh > $TMP_DIR/colors.sh
  source $TMP_DIR/colors.sh
}
#endregion load_colors

#region pre_reqs
# This function can be run to create the alcha user and prepare it for use.
function pre_reqs() {
  # Verify the script is running as root.
  if [[ "$EUID" -ne 0 ]]; then
    echo -e "${YELLOW_TEXT}This function must be run as root!${RESET_TEXT}"
    exit 1
  fi

  # Create my standard user account.
  adduser alcha

  # Add the user to the sudo group.
  usermod -aG sudo alcha

  # Create a sudoers file to allow the user to sudo without a password.
  echo "alcha ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/alcha

  # Copy the SSH public key from root to the new user.
  rsync --archive --chown=alcha:alcha ~/.ssh /home/alcha
}
#endregion pre_reqs

#region clone_dotfiles_repo
# Clone the Dotfiles repository into a temporary directory and return the path to the directory.
function clone_dotfiles_repo() {
  # The URL for the Dotfiles repository.
  REPO_URL="https://github.com/4lch4/Dotfiles"

  log_yellow "Cloning $REPO_URL to $TMP_DIR..."

  git clone $REPO_URL $TMP_DIR
}
#endregion clone_dotfiles_repo

#region install_oh_my_zsh
# Installs Oh My Zsh by downloading and running their install script.
function install_oh_my_zsh() {
  # Set the URL for the Oh My Zsh install script.
  OMZ_SCRIPT_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

  # Set the local path to the Oh My Zsh install script.
  OMZ_SCRIPT_PATH="$TMP_DIR/install/oh-my-zsh.sh"

  log_yellow "Downloading Oh My Zsh install script to $OMZ_SCRIPT_PATH..."

  # Download Oh My Zsh install script.
  curl -L $OMZ_SCRIPT_URL > $OMZ_SCRIPT_PATH

  log_yellow "Running Oh My Zsh install script..."

  # Run the Oh My Zsh install script with RUNZSH=no to prevent it from starting Zsh.
  RUNZSH=no sh $OMZ_SCRIPT_PATH
}
#endregion install_oh_my_zsh

#region install_zsh
# Install Zsh, download & install Oh My Zsh, and download Antigen.
function install_zsh() {
  log_yellow "Creating Zsh config directory $ZSH_DIR..."

  # Create the Zsh config directory.
  mkdir -p $ZSH_DIR

  log_yellow "Installing Zsh and Zsh documentation w/ apt..."

  # Install zsh and zsh-doc.
  sudo apt install zsh zsh-doc -y

  log_yellow "Installing Oh My Zsh..."

  # Install Oh My Zsh.
  install_oh_my_zsh

  log_yellow "Downloading Antigen to $ZSH_DIR/antigen.zsh..."

  # Download Antigen.
  curl -L git.io/antigen > $ZSH_DIR/antigen.zsh
}
#endregion install_zsh

#region apply_alchanges
# Apply my customizations/changes.
function apply_alchanges() {
  CHANGES_SOURCE="$TMP_DIR"

  log_yellow "Applying customizations..."

  # Copy the `.zshrc` file from the repository to the home directory.
  cp $CHANGES_SOURCE/ubuntu.zshrc $HOME/.zshrc

  # Copy shared scripts (aliases, functions, secrets, vars) from the repository to the Zsh config directory.
  cp $CHANGES_SOURCE/scripts/shared/aliases.sh $ZSH_DIR/aliases.sh
  cp $CHANGES_SOURCE/scripts/shared/functions.sh $ZSH_DIR/functions.sh
  cp $CHANGES_SOURCE/scripts/shared/secrets.sh $ZSH_DIR/secrets.sh
  cp $CHANGES_SOURCE/scripts/shared/vars.sh $ZSH_DIR/vars.sh
}
#endregion apply_alchanges

#region Main Function
function main() {
  # Update the system and installed packages.
  # sudo apt update && sudo apt upgrade -y
  sudo DEBIAN_FRONTEND=noninteractive apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

  log_yellow "Cloning Dotfiles repository..."

  # Clone my Dotfiles repository into a temporary directory, store the path to the directory in a variable.
  TMP_REPO=$(clone_dotfiles_repo)

  log_green "Clone successfully complete!"

  log_yellow "Installing Zsh, Oh My Zsh, and Antigen..."

  # Install Zsh, Oh My Zsh, and Antigen, and apply my customizations from the temporary directory.
  install_zsh

  log_green "Installation successfully complete!"

  log_yellow "Applying customizations..."

  # Apply my customizations from the temporary directory.
  apply_alchanges $TMP_REPO

  log_green "Customizations successfully applied!"

  log_yellow "Cleaning up..."

  # Remove the temporary directory.
  # rm -rf $TMP_REPO

  log_green "Cleanup successfully complete!"
}
#endregion Main Function
#endregion Helper Functions

# Make sure we're not logged in as root. If not, exit.
if [[ "$EUID" -eq 0 ]]; then
  echo "This script must not be run as root."
  exit 1
fi

main






# # Install Zsh.
# install_zsh

# # Apply my customizations.
# apply_alchanges $TMP_REPO

# # Install Zsh/Oh My Zsh/Antigen.

# # Download Antigen.
# curl -L git.io/antigen > $ZSH_DIR/antigen.zsh

# # Download `.zshrc` from the repository.
# curl -L https://raw.githubusercontent.com/4lch4/Dotfiles/main/.zshrc > $HOME/.zshrc

# # Download remaining config scripts from the repository.
# curl -L https://raw.githubusercontent.com/4lch4/Dotfiles/main/scripts/shared/aliases.sh > $ZSH_DIR/aliases.sh
# curl -L https://raw.githubusercontent.com/4lch4/Dotfiles/main/scripts/shared/functions.sh > $ZSH_DIR/functions.sh
# curl -L https://raw.githubusercontent.com/4lch4/Dotfiles/main/scripts/shared/secrets.sh > $ZSH_DIR/secrets.sh
# curl -L https://raw.githubusercontent.com/4lch4/Dotfiles/main/scripts/shared/vars.sh > $ZSH_DIR/vars.sh


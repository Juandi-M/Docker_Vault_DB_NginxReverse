#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to install a tool using Homebrew on ARM
install_tool() {
  tool_name="$1"
  if ! command_exists "$tool_name"; then
    arch -arm64 brew install "$tool_name" || { echo "Failed to install $tool_name"; exit 1; }
  else
    echo "$tool_name is already installed."
  fi
}

# Check if Homebrew on ARM is installed
if ! command_exists brew; then
  echo "Homebrew on ARM is not installed. Installing Homebrew on ARM..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || { echo "Failed to install Homebrew"; exit 1; }
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)" || { echo "Failed to update shell environment"; exit 1; }
else
  echo "Homebrew on ARM is already installed."
fi

# Install or verify tools
install_tool git
install_tool vault
install_tool aws
install_tool kubectl
install_tool terraform

# Verify installations
git --version || echo "Git not found"
vault --version || echo "HashiCorp Vault not found"
aws --version || echo "AWS CLI not found"
kubectl version --client || echo "kubectl not found"
terraform --version || echo "Terraform not found"
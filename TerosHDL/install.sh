#!/bin/bash
# By Pytel

# Install TerosHDL
# This script installs TerosHDL to the system

python_dependencies="pip-dependencies.txt"
apt_dependencies="apt-dependencies.txt"

# Install apt dependencies
sudo apt-get update
xargs sudo apt-get -y install < $apt_dependencies

# Install python dependencies
pip install -r $python_dependencies

echo -e "Done!"
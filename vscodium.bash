#!/bin/bash

# Note: VS Codium is an open source licenced version of VS code
# that has all of the MS telemetry stripped out of it.
# Better for privacy and seems more stable running in docker than VS Code.

# Approach from:
# https://vscodium.com/#install
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | tee /etc/apt/sources.list.d/vscodium.list

apt update
apt install -y codium

# NOTE: Newest versions of codium have broken the ability to install
#       extensions in an image of a different architecture.  For example,
#       it will not install extensions into the amd64 images when building
#       on an arm64 or vice versa...
#  
#       The approach below explicitly installs a specific version of codium
#       that does not suffer from this issue.
# 
#       This still has not been fixed and newer versions of codium are 
#       needed for some extensions. So the choice was made to install the
#       latest version of codium and not pre-install extensions.

# # Download and install a specific version of codium.
# ARCH=$(dpkg --print-architecture)
# VER="1.77.3.23102"   # Works
# #VER="1.78.2.23132"  # Does not work.
# VER="1.88.1.24104"

# DEB="codium_"$VER"_"$ARCH".deb"
# URL="https://github.com/VSCodium/vscodium/releases/download/"$VER"/"$DEB
# wget $URL
# apt install -y ./$DEB
# rm ./$DEB

# Patch the xfce menu item for VS Codium so it runs correctly.
sed -i 's+/usr/share/codium/codium+/usr/bin/codium --no-sandbox+g' /usr/share/applications/codium.desktop
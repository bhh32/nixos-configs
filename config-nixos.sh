#!/bin/bash

type=$1

if [ ${type} == "" ] 
then
    type="generic"
fi

if [ ${type} ==  "generic" ]
then
    wget https://raw.githubusercontent.com/bhh32/nixos-configs/main/config-files/non-nvidia-non-dev-configuration.nix
else if [ ${type} == "nvidia-laptop" ]
then
    wget https://raw.githubusercontent.com/bhh32/nixos-configs/main/config-files/nvidia-optimus-configuration.nix
else if [ ${type} == "system76-laptop" ]
then
    wget https://raw.githubusercontent.com/bhh32/nixos-configs/main/config-files/system76-configuration.nix
else
    echo "You didn't choose an appropriate config!"
    exit 0
fi

sudo mv ./*configuration.nix /etc/nixos/configuration.nix

if ($?)
then
    sudo nixos-rebuild switch

    restart="no"

    read -p "Do you want to reboot the system? type yes or no" restart

    if [ $restart == "yes" ]
    then
        reboot
    fi
else
    echo "Configuration file transfer to /etc/nixos/configuration.nix not successful!"
    exit 1
fi
#! /bin/bash

# Update, Upgrade, Install new (/ uninstall old) packages, and
# remove unused packages & associated config files.
apt update -y && apt upgrade -y && apt full-upgrade -y && apt autoremove --purge -y

#! /bin/bash

# Clean temp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

# Clear apt cache
apt clean -y

# Clear thumbnails cache for sysadmin
rm -rf /home/sysadmin/.cache/thumbnails

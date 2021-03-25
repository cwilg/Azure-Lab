#! /bin/bash

tar cvf /var/backups/home.tar /home
mv /var/backups/home.tar /var/backups/home.01192021.tar
ls -lah /var/backups >> /var/backups/file_report.txt
free -h >> /var/backups/disk_report.txt


#!/bin/bash

# Conditional statement to create "research" directory
if [! -d ~/research]
then
 mkdir ~/research
fi

# Variable stored
output=$HOME/research/sys_info.txt
inet=$(ip addr | grep inet | tail -2 | head -1)

# Conditional statement to remove any previous contents of "sys_info.txt"
if [-f $output]
then
 rm $output
fi

# Machine info from previous activity
echo "System Information Script" >> $output
date >> $output
echo "Machine Type Info: $MACHTYPE" >> $output
echo -e "Uname info: $(uname -a) \n" >> $output
echo -e "IP Info: $(ip addr | head -9 | tail -1) \n" >> $output
echo "INET Info: $inet" >> $output
echo -e "Hostname: $(hostname -s) \n" >> $output

# Whole bunch of random info for another activity
find -perm 777 >> $output
top | head -17 | tail -11 >> $output



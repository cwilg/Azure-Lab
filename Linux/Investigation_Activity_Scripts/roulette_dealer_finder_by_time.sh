#!/bin/bash

grep -i  $2 $1_Dealer_schedule | grep -iw $3 | awk -F" " '{print $1,$2,$5,$6}'

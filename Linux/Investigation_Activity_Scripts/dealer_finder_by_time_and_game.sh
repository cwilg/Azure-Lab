#!/bin/bash

echo "Date? [MMDD format]"
read date
echo "Time? [XX:XX format]"
read hour
echo "AM / PM?"
read ampm
echo "Game: 1) Blackjack, 2) Roulette, or 3) Texas Hold Em? [select number]"
read game

# Conditional
if [ $game -lt 2 ]
	then echo "Blackjack Dealer, "$date":"
	grep $hour $date\_Dealer_schedule | grep -iw $ampm | awk -F" " '{print $1,$2,$3,$4}'
	elif [ $game -eq 2 ]
	then echo "Roulette Dealer, "$date":"
	grep $hour $date\_Dealer_schedule | grep -iw $ampm | awk -F" " '{print $1,$2,$5,$6}'
	else
	echo "Texas Hold em Dealer, "$date":" 
	grep $hour $date\_Dealer_schedule | grep -iw $ampm | awk -F" " '{print $1,$2,$7,$8}'
	fi




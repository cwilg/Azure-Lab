#! /bin/bash

states=(
 'Vermont'
 'Montana'
 'Maine'
 'Kentucky'
 'California'
)

for state in ${states[@]}
 do
  if [ $state == 'Vermont' ]
  then
   echo "Vermont is the best!"
  else 
   echo "I'm not fond of Vermont..."
  fi
 done

nums=$(echo {0..9})
for num in ${nums[@]}
 do
  if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
  then
   echo $num
  fi
 done

lsout=$(ls)
for item in ${lsout[@]}
 do
  echo $item
 done

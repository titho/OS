#!/bin/bash

i=1
for p in $(cat secret_message); do
	while read i;	do
	if [ "$(echo $i | cut -f2 -d" ")" = "$p" ]
	then
		echo $(echo $i | cut -f1 -d" ") >> new.txt
	fi
	done < morse	
done
echo $(tr -d '\n' < new.txt | tr 'A-Z' 'a-z') > encrypted
rm new.txt

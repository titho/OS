#!/bin/bash
echo "$(cat morse | cut -f1 -d" " | tr 'A-Z' 'a-z'| nl)" > alpha

i=1
while [[ $i -lt "$(cat encrypted | wc -c)" ]]
do
	fir=$(grep "$(head -c$i encrypted | tail -c1)" alpha | awk '{print $1}');
	let "second = $fir + 15"	




	if [[ ${second} -gt 26 ]]
	then
	let "second = $second - 26"
	fi
	let2=$(head -n$second alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+1)) encrypted | tail -c1) != $let2 ]]
	then
	((i++))
	continue
	fi

	let "third = $fir + 25"
	
	if [[ ${third} -gt 26 ]]
	then
	let "third = $third - 26"
	fi 
		let3=$(head -n$third alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+2)) encrypted | tail -c1) != $let3 ]]
	then
	((i++))
	continue
	fi

	let "forth = $fir + 2"
	
	if [[ ${forth} -gt 26 ]]
	then
	let "forth = $forth - 26"
	fi
		let4=$(head -n$forth alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+3)) encrypted | tail -c1) != $let4 ]]
	then
	((i++))
	continue
	fi
	
	let "fifth = $fir + 12"

	if [[ ${fifth} -gt 26 ]]
	then
	let "fifth = $fifth - 26"
	fi
	let5=$(head -n$fifth alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+4)) encrypted | tail -c1) != $let5 ]]
	then
	((i++))
	continue
	fi

	let "sixth = $fir + 25"

	if [[ ${sixth} -gt 26 ]]
	then
	let "sixth = $sixth - 26"
	fi
	let6=$(head -n$sixth alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+5)) encrypted | tail -c1) != $let6 ]]
	then
	((i++))
	continue
	fi

	let "seventh = $fir + 12"

	if [[ ${seventh} -gt 26 ]]
	then
	let "seventh = $seventh - 26"
	fi
	let7=$(head -n$seventh alpha | tail -n1 | awk '{print $2}')
	if [[ $(head -c$(($i+4)) encrypted | tail -c1) != $let7 ]]
	then
	((i++))
	continue
	fi

	let1=$(head -n$fir alpha | tail -n1 | awk '{print $2}')
	
	let "key = $fir + 6"
	if [[ ${key} -gt 26 ]]
	then
	let "key = $key - 26"
	fi

	break
done

j=1
while [[ $j -lt "$(cat encrypted | wc -c)" ]]
do
	curr=$(grep "$(head -c$j encrypted | tail -c1)" alpha | awk '{print $1}');
	let "curr = $curr + $key"
	if [[ ${curr} -gt 26 ]] 
	then 
	let "curr = $curr - 26"
	fi
	
	echo $(head -n$curr alpha | tail -n1 | awk '{print $2}') >> temp.txt
	((j++))	
done
echo $(tr -d '\n' < temp.txt) > file
cat file
rm file
rm temp.txt
rm alpha

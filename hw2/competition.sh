		echo "$p2"
#!/bin/bash

DIR="$1"
FUNC="$2"

for i in $(ls $DIR/all); do
echo "$(cat $DIR/all/$i | egrep "^QSO.*" | awk '{print $9}')" >> $DIR/allposives
done
echo "$(cat $DIR/allposives | sort | uniq)" > $DIR/allposives
echo "$(ls $DIR/all | tr ' ' '\n')" > $DIR/players
participants() {
	cat players
}
outliers() {
	grep -v -F -x -f $DIR/players $DIR/allposives
}
unique() {

	for posive in $(cat $DIR/allposives); do
	   counter=0
	   for file in $(ls $DIR/all); do
		if [[ "$posive" != "$file" ]] && [[ $(grep "$posive" $DIR/all/$file) ]]
		then
		let "counter = $counter + 1"
		fi
		test $counter -ge 3 && break		
	   done
		test $counter -lt 3 && echo "$posive" >> uniq_f
	done
	cat uniq_f
	rm uniq_f
}
cross_check() {
flag=false
	for p1 in $(cat $DIR/players); do
	for p2 in $(egrep "^QSO.*" $DIR/all/$p1 | awk '{print $9}'); do
		if [[ $(grep "$p1" $DIR/all/$p2 2> errors.txt) ]]; then
		flag=true
		fi
	done
	if [[ "$flag" = false ]]; then
		echo "$p2"
	fi
	flag=false
	done
}
bonus() {
	for p1 in $(cat players); do
	for((i=1;i<$(egrep "^QSO.*" $DIR/all/$p1 | wc -l);i++)); do 
		p2=$(egrep "^QSO.*" $DIR/all/$p1 | head -n$i | tail -n1);
		date1=$(echo "$p2" | awk '{print $5}');
		match=$(echo "$p2" | awk '{print $9}');
		date2=$(cat $DIR/all/$match | grep "$p1" | awk '{print $5}' 2> errors.txt);
		if [[ $date1 -gt $(($date2 + 3)) ]] || [[ $date1 -lt $(($date2 - 3)) ]]; then
		echo "$p2"
		fi		
	done
	done		
}
if [[ $FUNC = "unique" ]]; then
unique
elif [[ $FUNC = "participants" ]]; then
participants
elif [[ $FUNC = "outliers" ]]; then
outliers
elif [[ $FUNC = "cross_check" ]]; then
cross_check
elif [[ $FUNC = "bonus" ]]; then
bonus
else
echo "There is no such function."
fi
rm players 2> errors.txt
rm allposives 2> errors.txt
rm errors.txt


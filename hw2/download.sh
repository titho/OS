#!/bin/bash

dir="$1"
link="$2"

wget -q -P $dir -O data $link
mkdir $dir/all
cd $dir/all

for i in $(echo $(egrep -o 'href=".*"' $dir/data | cut -f2 -d'"' | tail -n+2)); do
wget -q -O $i "$link"/$i
done
cd $dir

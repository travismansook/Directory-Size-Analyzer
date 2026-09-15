#!/bin/bash

echo "Enter directory:"
read directname
if [ -d "$directname" ]; then
	echo ""
	echo "Analyzing directory: $directname"
	echo""
	echo "All items with sizes:"
	cd $directname
	#i=0
	total_size=0
	items=0
	size=$(ls -l | tail -n +2 | tr -s " " | cut -f 5 -d " ")
	#fnames=$(ls -l | tail -n +2 | tr -s " " | cut -f 9 -d " ")
	
	#calculate total lines except the first line with total
	total_lines=$(ls -l | wc -l)
	total_lines=$((total_lines-1)) #subtract the first line with total
	
	#echo "total lines: $total_lines"
	for i in $size; do
		total_size=$((i+total_size))
		items=$((items+1))
	done

	
	avg=$(($total_size/$items))
	
	#all items with sizes
	ls -l | tail -n +2 | tr -s " " | awk '{print "-",$9,":",$5,"bytes"}'
	
	#echo "total is $total_size"
	#echo "items is $items"
	echo ""
	echo "Average size: $avg bytes"
	echo ""	
 	echo "Items larger than average ($avg bytes):"
        #greater than avg
	iteration_num=0
	gta=0
	for i in $size; do
		iteration_num=$((iteration_num+1))
		if [ "$i" -gt "$avg" ]; then
			gta=$(($gta+1))
			echo "$gta. " $(ls -l | tail -n +2 | tr -s " " | cut -f 9 -d " " | sed -n "${iteration_num}p") "- $i bytes"
		fi
	done
	echo ""
	echo "Total items above average: $gta out of $items"
else
	echo "Directory does not exist."
fi

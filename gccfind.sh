#!/bin/bash
#David Berkovits 318844685


if [ $# -lt 2 ]
then 
	echo "Not enough parameters" 
	exit
fi ;

path=$1
word=$2

if [ -n "$(find $path -maxdepth 1 -name '*.out' -print -quit)" ]
then
	for file_to_delete in $path/*.out; 
	do
		rm "$file_to_delete" 
	done
fi


if [ -n "$(find $path -maxdepth 1 -name '*.c' -print -quit)" ]
then
	file_to_compile=$(find $path -name "*.c" -exec grep -l "$word" {} \;)
	for file in  $file_to_compile;
	do
		gcc -w -o ${file%.*}.out $file
	done
fi

if [ "$3" == "-r" ]
then
	if [ -d "$path/*" ]
	then 
		exit
	fi
	for folder in $path/*/
	do
		newpath=${folder%/}
		$($0 $newpath $word -r) &
	done
fi



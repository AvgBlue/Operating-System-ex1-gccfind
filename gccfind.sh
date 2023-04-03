#!/bin/bash
#David Berkovits 318844685

if [ $# -lt 2 ]
then 
	echo "Not enough parameters" 
	exit
fi ;

path=$1
word=$2
ogpath="$(pwd)"
cd $path
if [ -n "$(find . -maxdepth 1 -name '*.out' -print -quit)" ]
then
	for file_to_delete in *.out; 
	do
		rm "$file_to_delete" 
	done
fi

if [ -n "$(find . -maxdepth 1 -name '*.c' -print -quit)" ];then
	file_to_compile=$( grep -l "$word\s" *.c)
	for file in  $file_to_compile;
	do
		gcc -w -o ${file%.*}.out $file
	done
fi

if [ "$3" == "-r" ]
then
	if [ -d "*" ]
	then 
		exit
	fi
	for folder in */
	do
		newpath=$path/${folder%/}
		nowpath="$(pwd)"
		cd $ogpath
		$($0 $newpath $word "-r") &
		cd $nowpath
	done
fi

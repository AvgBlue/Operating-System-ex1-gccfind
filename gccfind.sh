#!/bin/bash
#David Berkovits 318844685

#check the number of parameters
if [ $# -lt 2 ]
then 
	echo "Not enough parameters" 
	exit 0
fi ;

path=$1
word=$2
extension_to_delete=".out"
extension_to_compile=".c"

#check if files exists in the folder
if [ -z "$(ls -A $path)" ] 
then
	exit 0
fi


#running of the for delision
for file in $path/*
do 
	#check if file not exists
	if ! [ -f "$file" ]
	then
		continue
	fi
	#check if the file extension is not equal to $extension_to_delete
	if [[ "$(basename "$file")" != *$extension_to_delete ]]
	then	
		continue
	fi
	rm "$file" 
done

#check if files exists in the folder
if [ -z "$(ls -A $path)" ] 
then
	exit 0
fi

#run on the file to compilion
for file in $path/*
do 
	#check if file not exists
	if ! [ -f "$file" ]
	then
		continue
	fi
	#check if the file extension is not equal to $extension_to_compile
	if [[ "$(basename "$file")" != *$extension_to_compile ]]
	then	
		continue
	fi
	# check if the $word is in file
	if grep -qw "$word"  "$file"
	then
		gcc -w -o ${file%.*}.out $file
	fi
done

# checking for the not exist flag
if [ "$3" != "-r" ]
then
	exit 0
fi

# run on every folder in the directory
for folder in $path/*/
	do
		newpath=${folder%/}
		$0 $newpath $word -r &
	done

exit 0


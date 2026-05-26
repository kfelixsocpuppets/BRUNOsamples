#!/bin/bash

# source of files separated by "space" this script creates bulk host objects for the FMC 

# hosts.txt

#

filename="fixedup.txt"


#

#convert source.file to UPPERCASE


HDR="NAME,DESCRIPTION,TYPE,VALUE,LOOKUP"

 

# Prompt for an Upper or Lower Case


read -p "Please enter your 'lcase' for lower-case OR 'ucase' for upper-case: " case


# Prompt for a name of a source file

read -p "Please enter your source filename: " fileloc


 

< $fileloc  dd conv=$case  >fixedup.txt


#

#

IFS=' '


#

#

while read -r hostname ipv4; do

echo "$hostname,,,$ipv4,"  >> hostentry.txt

done < "$filename"

 

sed -i '1i\'"$HDR" "hostentry.txt"



 

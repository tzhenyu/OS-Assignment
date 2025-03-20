#!/bin/bash


sortById(){
    #read the file from patron into array form
    mapfile -t patron < patron.txt

    #a freaking header
    header="${patron[0]}"

    # Extract the data [array[@]:start:end]
    datas=("${patron[@]:1}")

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${datas[@]}" | sort -t ':' -k1)

    echo "$header"
    echo "$sorted"

}

sortById

sortByDate(){
    #read the file from patron into array form (the -t is to remove the new line occurence or it will mess up the indexes)
    mapfile -t patron < patron.txt
    
    #a freaking header
    header="${patron[0]}"

    # Extract the data [array[@]:start:end]
    datas=("${patron[@]:1}")

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${datas[@]}" | sort -t':' -k7,7 -k7.4,7.5n -k7.7,7.10n)

    echo "$header"
    echo "$sorted"
}

echo -e "\n\n"
sortByDate
#how the heck should I sort using the date?

#!/bin/bash


sortById(){
    #read the file from patron into array form
    mapfile -t patron < patron.txt

    #a freaking header
    header="${patron[0]}"

    # Extract the data [array[@]:start:end]
    datas=("${patron[@]:1}")

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${datas[@]}" | sort -t ':' -k7)

    echo "$header"
    echo "$sorted"

}


#how the heck should I sort using the date?

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

DeletePatron(){

    patron_file="test.txt"

    echo "DELETE PATRON DETAILS"
    echo -n "ENTER PATRON ID: "
    read patron_id

    patron_details=$(grep "^$patron_id" "$patron_file")

    if [ -z "$patron_details" ]; 
    then
        echo "Patron ID not found!"
        return
    fi

    id=$(echo "$patron_details" | cut -d':' -f1)
    fname=$(echo "$patron_details" | cut -d':' -f2)
    lname=$(echo "$patron_details" | cut -d':' -f3)
    mobile=$(echo "$patron_details" | cut -d':' -f4)
    dob=$(echo "$patron_details" | cut -d':' -f5)
    type=$(echo "$patron_details" | cut -d':' -f6)
    joined=$(echo "$patron_details" | cut -d':' -f7)


    echo "---------------------------------------"
    echo " First Name: $fname"
    echo " Last Name: $lname"
    echo " Mobile Number: $mobile"
    echo " Birth Date (MM-DD-YYYY): $dob"
    echo " Membership Type: $type"
    echo " Joined Date (MM-DD-YYYY): $joined"
    echo "---------------------------------------"

    echo -n "Are you sure you want to DELETE the above Patron Details? (y)es or (q)uit: "
    read confirm

    if [["$confirm" =~ ^[yY]$]]; #this statement got an issue on accepting input
    then
        #finds all details that is NOT the one that has been prompted, then save it to the temp file , later on it renames back to patron_file which is kind of overwriting
        grep -v "^$patron_id:" "$patron_file" > temp.txt && mv temp.txt "$patron_file"
        echo "Patron details deleted successfully."
    else
        echo "Action Cancelled"
        exit 1
    fi
    
    
}

DeletePatron
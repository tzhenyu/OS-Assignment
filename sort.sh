#!/bin/bash


sortById(){
    #read the file from patron into array form
    mapfile -t patron < patron.txt

    #a freaking header
    echo -e "PatronID\tFName\tLName\tMobileNum\tBirthDate\tType\tJoinedDate"
    echo "-----------------------------------------------------------------------"

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1)

    while IFS=':' read -r id fname lname mobile dob type joined; 
    do
        echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined"
    done <<< $sorted

}

sortByDate(){
    #read the file from patron into array form (the -t is to remove the new line occurence or it will mess up the indexes)
    mapfile -t patron < patron.txt
    
     # Print the header with spacing
    echo -e "PatronID\tFName\tLName\tMobileNum\tBirthDate\tType\tJoinedDate"
    echo "-----------------------------------------------------------------------"

    # Sort the data and format it
    sorted_data=$(printf "%s\n" "${patron[@]:1}" | sort -t':' -k7.7,7.10n -k7.4,7.5n -k7.1,7.2n)
     
    while IFS=':' read -r id fname lname mobile dob type joined; 
    do
        echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined"
    done <<< $sorted_data

}
    


DeletePatron(){ #functioning very well (insyallah)

    patron_file="test.txt"

    #print out the header and prompt
    echo -e "\n\n\t\t\t\tDelete a Patron Details"
    echo -e "\t\t\t\t=======================\n"
    echo -n "Enter Patron ID: "
    read patron_id

    #saves the file to a variable
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

    if [ "$confirm" = "Y" ] || [ "$confirm" = "y" ]; 
    then
        #finds all details that is NOT the one that has been prompted, then save it to the temp file , later on it renames back to patron_file which is kind of overwriting
        grep -v "^$patron_id:" "$patron_file" > temp.txt && mv temp.txt "$patron_file"
        echo "Patron details deleted successfully."
    elif [ "$confirm" = "Q" ] || [ "$confirm" = "q" ];
    then
        echo "Action Cancelled, Returning to the menu"
        return

    else 
        echo "Invalid choice, returning to the menu"
        return
    fi
    
    
}


#do the second phase of formatting and directly add it to assignment.sh file to make it fully functional

#just > and >> so to file (add user prompt, cat and touch)
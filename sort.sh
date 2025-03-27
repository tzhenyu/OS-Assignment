#!/bin/bash


sortById()
{
    #read the file from patron into array form
    mapfile -t patron < patron.txt

    #a freaking header
    echo -e "PatronID\tFName\tLName\tMobileNum\tBirthDate\tType\tJoinedDate"
    echo "-----------------------------------------------------------------------"

    outputFile="output.txt"

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1)

    while IFS=':' read -r id fname lname mobile dob type joined; 
    do
        echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined"
    done <<< $sorted

    echo -e " Press (q) to return to Patron Maintenance Menu.\n"
    echo -e "Would you like to export the report as ASCII text file? (y)es (q)uit:"

    read -r response

    if [ $response = "y" ] || [ $response = "Y" ];
    then
        echo -e "PatronID\tFName\tLName\tMobileNum\tBirthDate\tType\tJoinedDate" > $outputFile
        echo -e "-----------------------------------------------------------------------" >>  $outputFile

        # Sort the array by PatronID (first field) using sort
        sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1)

        while IFS=':' read -r id fname lname mobile dob type joined; 
        do
            echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined" >> $outputFile
        done <<< $sorted 

        echo "Exported to $outputFile successfully."
        main_menu
    elif [ $response = "q"] || [ $response = "Q"];
    then 
        echo "Returning to Main Menu"
        sleep -s 1500
        main_menu;
    else
        echo "invalid choice, returning to main menu"
        sleep -s 1500
        main_menu;
    fi

}

sortByDate()
{
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
    

sortById

#do the second phase of formatting and directly add it to assignment.sh file to make it fully functional

#just > and >> so to file (add user prompt, cat and touch)
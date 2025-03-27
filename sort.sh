#!/bin/bash


sortById()
{
    #read the file from patron into array form
    mapfile -t patron < patron.txt

    #a freaking header
    echo -e "PatronID\tFirst Name\tLast Name\tMobile Number\tBirth Date"
    echo "----------------------------------------------------------------------------------"

    outputFile="SortByID.txt"

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1)

    while IFS=':' read -r id fname lname mobile dob _ _ ; 
    do
        echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t"
    done <<< $sorted

    echo -e " Press (q) to return to Patron Maintenance Menu.\n"
    echo -e "Would you like to export the report as ASCII text file? (y)es (q)uit:"

    read -r response

    if [ $response = "y" ] || [ $response = "Y" ];
    then
        echo -e "PatronID\tFirst Name\tLast Name\tMobile Number\tBirth Date" > "$outputFile"
        echo -e "----------------------------------------------------------------------------------" >>  "$outputFile"

        ##Sort the array by PatronID (first field) using sort
        sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1 )

        while IFS=':' read -r id fname lname mobile dob _ _ ; 
        do
            echo -e "$id\t$lname\t$fname\t$mobile\t$dob" >> "$outputFile"
        done <<< "$sorted"

        echo "Exported to $outputFile successfully."
        
        echo "done"
    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo "Returning to Main Menu"
        sleep 2
        echo "executed";
    else
        echo "invalid choice, returning to main menu"
        sleep 2
        echo "executed";
    fi

}

sortByDate()
{
    #read the file from patron into array form (the -t is to remove the new line occurence or it will mess up the indexes)
    mapfile -t patron < patron.txt
    
     # Print the header with spacing
    echo -e "PatronID\tFirst Name\tLast Name\tMobile Number\tBirth Date\tType\tJoined Date"
    echo "---------------------------------------------------------------------------------------------------"

    outputFile="SortByDate.txt"

    # Sort the data and format it
    sorted_data=$(printf "%s\n" "${patron[@]:1}" | sort -t':' -k7.7,7.10n -k7.4,7.5n -k7.1,7.2n )
     
    while IFS=':' read -r id fname lname mobile dob type joined; 
    do
        echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined"
    done <<< $sorted_data

    echo -e " Press (q) to return to Patron Maintenance Menu.\n"
    echo -e "Would you like to export the report as ASCII text file? (y)es (q)uit:"

    read -r response

    if [ $response = "y" ] || [ $response = "Y" ];
    then
        echo -e "PatronID\tFirst Name\tLast Name\tMobile Number\tBirth Date\tType\tJoined Date" > "$outputFile"
        echo -e "----------------------------------------------------------------------------------" >>  "$outputFile"

        ##Sort the array by PatronID (first field) using sort based on MM/DD/YYYY
        sorted_data=$(printf "%s\n" "${patron[@]:1}" | sort -t':' -k7.7,7.10n -k7.1,7.2n -k7.4,7.5n )

        while IFS=':' read -r id fname lname mobile dob type joined ; 
        do
            echo -e "$id\t$fname\t$lname\t$mobile\t$dob\t$type\t$joined" >> "$outputFile"
        done <<< "$sorted_data"

        echo "Exported to $outputFile successfully."
        
        echo "done"
    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo "Returning to Main Menu"
        sleep 1
        echo "executed";
    else
        echo "invalid choice, returning to main menu"
        sleep 1
        echo "executed";
    fi

}
    

sortByDate

#do the second phase of formatting and directly add it to assignment.sh file to make it fully functional

#just > and >> so to file (add user prompt, cat and touch)
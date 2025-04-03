#BACS2093 OPERATING SYSTEMS ASSIGNMENT 
#GROUP 1
#MEMBERS:
#  - TAN ZHEN YU
#  - JONATHAN HO YOON CHOON
#  - MOHAMED MAHIR BIN HABIBULLAH

#uses bash to run
#!/bin/bash 

#word formatting
bold=$(tput bold)
normal=$(tput sgr0)

## ADD PATRON FUNCTION
add_patron () {

    choice=y

    while [ "$choice" = "y" ]
    do
        clear
                
        echo "${bold}Add New Patron Details Form"
        echo "=========================== ${normal}"

        # echo -n "Patron ID: "; read patronID

        # Read Patron ID
        while true; do
            echo -n "Patron ID: "; read patronID
            if [[ "$patronID" =~ ^[A-Z][0-9]{4}$ ]]; then
                break
            else
                echo "Invalid Patron ID. Format should be P0001"
            fi
        done

        # Read Patron First Name
        while true; do
            echo -n "First Name: "; read patronFirstName
            if [[ "$patronFirstName" =~ ^[a-zA-Z]+$ ]]; then
                break
            else
                echo "Invalid First Name. Use letters."
            fi
        done

        #Read Patron Last Name
        while true; do
            echo -n "Last Name: "; read patronLastName
            if [[ "$patronLastName" =~ ^[a-zA-Z\ ]+$ ]]; then
                break
            else
                echo "Invalid Last Name. Use letters."
            fi
        done

        #Read Patron Phone Number
        while true; do
            echo -n "Mobile Number: "; read patronPhoneNum
            if [[ "$patronPhoneNum" =~ ^[0-9]{3}-[0-9]{7,9}$ ]]; then
                break
            else
                echo "Invalid Phone Number. Use XXX-XXXXXXX."
            fi
        done

        #Read Patron Birth Date
        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "; read patronBirthDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo "Invalid Birth Date."
            fi
        done

        #Read Patron Membership
        while true; do
            echo -n "Membership type (Student / Public): "; read patronMembership
            if [[ "$patronMembership" == "Student" || "$patronMembership" == "Public" ]]; then
                break
            else
                echo "Invalid membership type. Choose 'Student' or 'Public'."
            fi
        done
        
        #Read Patron Join Date
        while true; do
            echo -n "Join Date (MM-DD-YYYY): "; read patronJoinDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo "Invalid Join Date."
            fi
        done

        # Check if user inputs join date, if no then use current date
        if [ -z "$patronJoinDate" ]
        then
            patronJoinDate=$(date '+%m-%d-%Y') 
        fi

        # Check if theres text file, if no then create file
        if [ ! -f patron.txt ]
        then
            touch patron.txt
            echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" >> patron.txt
            echo "$patronID:$patronFirstName:$patronLastName:$patronPhoneNum:$patronBirthDate:$patronMembership:$patronJoinDate" >> patron.txt
        else
            echo "$patronID:$patronFirstName:$patronLastName:$patronPhoneNum:$patronBirthDate:$patronMembership:$patronJoinDate" >> patron.txt
        fi

        echo
        echo "Press (q) to return to Patron Maintenance Menu."
        echo 

        while true; 
        do
            echo -ne "\rAdd another new patron details? (y)es or (q)uit: "
            read -n1 -s choice
            if [[ "$choice" == "y" || "$choice" == "q" ]]; then
                echo  # Move to a new line before breaking
                break
            else
                echo -ne "\rInvalid choice!                                              "
                sleep 1  # Brief delay so user sees the message
            fi
        done
    done
    main_menu
}

##DELETE PATRON FUNCTION
DeletePatron(){ #functioning very well (insyallah)

    patron_file="patron.txt"

    #print out the header and prompt
    echo -e "\n\n\t\t\t\tDelete a Patron Details"
    echo -e "\t\t\t\t=======================\n"
    echo -n "Enter Patron ID: "
    read patron_id

    #saves the file to a variable
    patron_details=$(grep "^$patron_id" "$patron_file")

    if [ -z "$patron_details" ]; 
    then
        echo "Patron ID not found! Try Again"
        DeletePatron;
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
        sleep 1.5
        main_menu;
    elif [ "$confirm" = "Q" ] || [ "$confirm" = "q" ];
    then
        echo "Action Cancelled, Returning to the menu"
        sleep 1.5
        main_menu;

    else 
        echo "Invalid choice, returning to the menu"
        sleep 1.5
        main_menu;
    fi
}

##SORT USER BY ID
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
    echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit:"

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

        sleep 1.5
        
        main_menu
    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo "Returning to Main Menu"
        sleep 1
        main_menu;
    else
        echo "invalid choice, returning to main menu"
        sleep 1
        main_menu;
    fi

}

##SORT BY DATE
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
    echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit:"

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

        sleep 1.5
        
        main_menu
    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo "Returning to Main Menu"
        sleep 1
        main_menu
    else
        echo "invalid choice, returning to main menu"
        sleep 1
        main_menu
    fi

}

## MAIN MENU FUNCTION
main_menu () {
    clear

    echo "${bold}Patron Maintenance Menu"
    echo "${normal}"

    echo "A - Add New Patron Details"
    echo "S - Search a Patron (by Patron ID)"
    echo "U - Update a Patron Details"
    echo "D - Delete a Patron Details"
    echo "L - Sort Patrons by Last Name"
    echo "P - Sort Patrons by Patron ID"
    echo "J - Sort Patrons by Joined Date (Newest to Oldest Date)"
    echo "Q - Exit from Program"

    echo
    echo -n "Please select a choice: "

    read choice

    case "$choice" in 
    A|a) 
        add_patron;;
    S|s)
        echo "insert function here";;
    U|u)
        echo "insert function here";;
    D|d)
        clear;
        DeletePatron;;
    L|l)
        echo "insert function here";;
    P|p)
        clear;
        sortById;;
    J|j)
        clear;
        sortByDate;;
    Q|q)
        clear;
        exit ;;
    *)
        echo  -n "Invalid choice. Please try again."
        sleep 1
        main_menu   
    esac

}
main_menu



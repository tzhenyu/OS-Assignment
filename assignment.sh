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


center_title() {
    text="$1"  # The title text

    width=$(tput cols)   # Get terminal width
    text_length=${#text} # Length of the title
    line_length=$(( text_length - 6)) 

    # Ensure separator doesn't exceed terminal width
    if [ "$line_length" -gt "$width" ]; then
        line_length=$((width))  # Adjust to fit
    fi

    separator=$(printf "%${line_length}s" | tr ' ' "-")
    padding=$(( (width - line_length + 3) / 2 ))
    
    # Print centered separator and title
    printf "%*s%s\n" "$(( (width + 12 - text_length) / 2 ))" "" "$text"
    printf "%*s%s\n" "$padding" "" "$separator"
}

clear



## ADD PATRON FUNCTION
##TODO MENU BOLD FORMATTING
add_patron () {
    choice=y

    while [ "$choice" = "y" ]
    do
        clear
        center_title "${bold}Add New Patron Details Form${normal}"
        echo

        # echo -n "Patron ID: "; read patronID
        #TODO: VALIDATE IF PATRON ID EXISTS
        # Read Patron ID
        while true; do

            echo -n " Patron ID                          : "
            read patronID

            # Check if the ID matches the format P0001
            if [[ "$patronID" =~ ^[A-Z][0-9]{4}$ ]]; then
                # Check if patron.txt exists before checking for duplicates
                if [[ -f patron.txt ]] && grep -q "^$patronID:" patron.txt; then
                    echo " ${bold}Patron ID already exists!"
                    echo -n " ${normal}Press Enter to try again."
                    read
                    tput cuu 3 # move cursor up 2 lines
                    tput ed    # clear everything below
                else
                    break
                fi
            else
                echo " ${bold}Invalid Patron ID! Format should be P0001."
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        # Read Patron First Name
        while true; do
            echo -n " First Name                         : "; read patronFirstName
            if [[ "$patronFirstName" =~ ^[a-zA-Z]+$ ]]; then
                break
            else
                echo " ${bold}Invalid First Name! Use letters."
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Last Name
        while true; do
            echo -n " Last Name                          : "; read patronLastName
            if [[ "$patronLastName" =~ ^[a-zA-Z\ ]+$ ]]; then
                break
            else
                echo " ${bold}Invalid Last Name! Use letters."
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Phone Number
        while true; do
            echo -n " Mobile Number                      : "; read patronPhoneNum
            if [[ "$patronPhoneNum" =~ ^[0-9]{3}-[0-9]{7,9}$ ]]; then
                break
            else
                echo " ${bold}Invalid Phone Number! Use XXX-XXXXXXX."
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Birth Date
        while true; do
            echo -n " Birth Date (MM-DD-YYYY)            : "; read patronBirthDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo " ${bold}Invalid Birth Date!"
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Membership
        while true; do
            echo -n " Membership type (Student / Public) : "; read patronMembership
            if [[ "$patronMembership" == "Student" || "$patronMembership" == "Public" ]]; then
                break
            else
                echo " ${bold}Invalid membership type! Choose 'Student' or 'Public'."
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done
        
        #Read Patron Join Date
        while true; do
            echo -n " Join Date (MM-DD-YYYY)             : "; read patronJoinDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo " ${bold}Invalid Join Date!"
                echo -n " ${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
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
            read -r choice
            if [[ "$choice" == "y" || "$choice" == "q" ]]; then
                echo  # Move to a new line before breaking
                break
            else
                echo "${bold}Invalid choice!"
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done
    done
    main_menu
}

##DELETE PATRON FUNCTION
DeletePatron(){ #functioning very well (insyallah)

    patron_file="patron.txt"

    #print out the header and prompt
    echo -e "\n\n\t\t\t\t${bold}Delete a Patron Details"
    echo -e "\t\t\t\t=======================\n"
    echo -n "${bold}Enter Patron ID:${normal} "
    read patron_id

    #saves the file to a variable
    patron_details=$(grep "^$patron_id" "$patron_file")

    if [ -z "$patron_details" ]; 
    then
        echo -n "Patron ID not found! Try Again"
        sleep 1
        clear
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
    echo " ${bold}First Name:${normal} $fname"
    echo " ${bold}Last Name:${normal} $lname"
    echo " ${bold}Mobile Number:${normal} $mobile"
    echo " ${bold}Birth Date (MM-DD-YYYY):${normal} $dob"
    echo " ${bold}Membership Type:${normal} $type"
    echo " ${bold}Joined Date (MM-DD-YYYY):${normal} $joined"
    echo "---------------------------------------"

    echo
    echo -n "Are you sure you want to ${bold}DELETE${normal} the above Patron Details? (y)es or (q)uit: "
    read confirm

    if [ "$confirm" = "Y" ] || [ "$confirm" = "y" ]; 
    then
        #finds all details that is NOT the one that has been prompted, then save it to the temp file , later on it renames back to patron_file which is kind of overwriting
        grep -v "^$patron_id:" "$patron_file" > temp.txt && mv temp.txt "$patron_file"
        echo -n "Patron details deleted successfully."
        sleep 1.5
        main_menu;
    elif [ "$confirm" = "Q" ] || [ "$confirm" = "q" ];
    then
        echo -n "Action Cancelled, Returning to the menu"
        sleep 1.5
        main_menu;

    else 
        echo -n "Invalid choice, returning to the menu"
        sleep 1.5
        main_menu;
    fi
}

##SORT USER BY ID
sortById()
{
    #read the file from patron into array form
    mapfile -t patron < patron.txt
    printf "${bold}\t\tPatron Details By sorted Patron ID"
    echo -e "\n\n"

    #a freaking header
    printf "${bold}%-11s %-17s %-20s %-15s %-10s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Birth Date"
    echo "${bold}---------------------------------------------------------------------------------"

    outputFile="SortByID.txt"

    # Sort the array by PatronID (first field) using sort
    sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1)

    while IFS=':' read -r id fname lname mobile dob _ _ ; 
    do
        printf "${normal}%-11s %-17s %-20s %-15s %-12s %-8s %-12s\n" "$id" "$lname" "$fname" "$mobile" "$dob"
    done <<< $sorted

    echo -e "\n"
    echo -e "Press (q) to return to Patron Maintenance Menu.\n"
    echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "

    read -r response

    if [ $response = "y" ] || [ $response = "Y" ];
    then
        printf "\t\tPatron Details By sorted Patron ID" > "$outputFile"
        echo -e "\n\n" >> "$outputFile"
        printf "%-11s %-17s %-20s %-15s %-10s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Birth Date" >> "$outputFile"
        echo -e "---------------------------------------------------------------------------------" >>  "$outputFile"

        ##Sort the array by PatronID (first field) using sort
        sorted=$(printf "%s\n" "${patron[@]:1}"| sort -t ':' -k1 )

        while IFS=':' read -r id fname lname mobile dob _ _ ; 
        do
            printf "%-11s %-17s %-20s %-15s %-10s\n" "$id" "$lname" "$fname" "$mobile" "$dob" >> "$outputFile"
        done <<< "$sorted"

        echo -n "Exported to $outputFile successfully."

        sleep 1.5
        main_menu

    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo -n "Returning to Main Menu"
        sleep 1
        main_menu;
    else
        echo -n "Invalid choice, returning to main menu"
        sleep 1
        main_menu;
    fi

}

##SORT BY DATE
sortByDate()
{
    #read the file from patron into array form (the -t is to remove the new line occurence or it will mess up the indexes)
    mapfile -t patron < patron.txt
    printf "${bold}\t\tPatron Details By sorted Date Joined"
    echo -e "\n\n"

     # Print the header with spacing
    printf "${bold}%-10s %-17s %-20s %-15s %-10s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Joined Date"
    echo "${bold}-----------------------------------------------------------------------------"

    outputFile="SortByDate.txt"

    # Sort the data and format it
    sorted_data=$(printf "%s\n" "${patron[@]:1}" | sort -t':' -k7.7,7.10n -k7.1,7.2n -k7.4,7.5n )
     
    while IFS=':' read -r id fname lname mobile dob type joined; 
    do
        printf "${normal}%-10s %-17s %-20s %-15s %-12s %-8s %-12s\n" "$id" "$lname" "$fname" "$mobile" "$joined"
    done <<< $sorted_data
    echo -e "\n"

    echo -e "Press (q) to return to Patron Maintenance Menu.\n"
    echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "

    read -r response

    if [ $response = "y" ] || [ $response = "Y" ];
    then
        printf "\t\tPatron Details By sorted Date Joined"
        echo -e "\n\n"
        printf "%-10s %-17s %-20s %-15s %-10s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Joined Date" > "$outputFile"
        echo -e "-----------------------------------------------------------------------------" >>  "$outputFile"

        ##Sort the array by PatronID (first field) using sort based on MM/DD/YYYY
        sorted_data=$(printf "%s\n" "${patron[@]:1}" | sort -t':' -k7.7,7.10n -k7.1,7.2n -k7.4,7.5n )

        while IFS=':' read -r id fname lname mobile dob type joined ; 
        do
            printf "%-10s %-17s %-20s %-15s %-12s %-8s %-12s\n" "$id" "$lname" "$fname" "$mobile" "$joined" >> "$outputFile"
        done <<< "$sorted_data"
        echo -e "\n"

        echo -n "Exported to $outputFile successfully."

        sleep 1.5
        main_menu

    elif [ $response = "q" ] || [ $response = "Q" ];
    then 
        echo -n "Returning to Main Menu"
        sleep 1
        main_menu
    else
        echo -n "Invalid choice, returning to main menu"
        sleep 1
        main_menu
    fi

}

## MAIN MENU FUNCTION
main_menu () {
    clear
    center_title "${bold}Patron Maintenance Menu${normal}"

    echo " A - Add New Patron Details"
    echo " S - Search a Patron (by Patron ID)"
    echo " U - Update a Patron Details"
    echo " D - Delete a Patron Details"
    echo " L - Sort Patrons by Last Name"
    echo " P - Sort Patrons by Patron ID"
    echo " J - Sort Patrons by Joined Date (Newest to Oldest)"
    echo " Q - Exit from Program"

    echo
    echo -n "Please select a choice >>"

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



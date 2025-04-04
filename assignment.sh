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
        echo "${normal}"

        while true; do

            echo -n "Patron ID                          : "
            read patronID

            # Check if the ID matches the format P0001
            if [[ "$patronID" =~ ^[A-Z][0-9]{4}$ ]]; then
                # Check if patron.txt exists before checking for duplicates
                if [[ -f patron.txt ]] && grep -q "^$patronID:" patron.txt; then
                    echo "${bold}Patron ID already exists!"
                    echo -n "${normal}Press Enter to try again."
                    read
                    tput cuu 3 # move cursor up 2 lines
                    tput ed    # clear everything below
                else
                    break
                fi
            else
                echo "${bold}Invalid Patron ID! Format should be P0001."
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        # Read Patron First Name
        while true; do
            echo -n "First Name                         : "; read patronFirstName
            if [[ "$patronFirstName" =~ ^[a-zA-Z]+$ ]]; then
                break
            else
                echo "${bold}Invalid First Name! Use letters."
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Last Name
        while true; do
            echo -n "Last Name                          : "; read patronLastName
            if [[ "$patronLastName" =~ ^[a-zA-Z\ ]+$ ]]; then
                break
            else
                echo "${bold}Invalid Last Name! Use letters."
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Phone Number
        while true; do
            echo -n "Mobile Number                      : "; read patronPhoneNum
            if [[ "$patronPhoneNum" =~ ^[0-9]{3}-[0-9]{7,9}$ ]]; then
                break
            else
                echo "${bold}Invalid Phone Number! Use XXX-XXXXXXX."
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Birth Date
        while true; do
            echo -n "Birth Date (MM-DD-YYYY)            : "; read patronBirthDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo "${bold}Invalid Birth Date!"
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done

        #Read Patron Membership
        while true; do
            echo -n "Membership type (Student / Public) : "; read patronMembership
            if [[ "$patronMembership" == "Student" || "$patronMembership" == "Public" ]]; then
                break
            else
                echo "${bold}Invalid membership type! Choose 'Student' or 'Public'."
                echo -n "${normal}Press Enter to try again."
                read
                tput cuu 3 # move cursor up 3 lines
                tput ed    # clear everything below
            fi
        done
        
        #Read Patron Join Date
        while true; do
            echo -n "Join Date (MM-DD-YYYY)             : "; read patronJoinDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo "${bold}Invalid Join Date!"
                echo -n "${normal}Press Enter to try again."
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
            echo -n "Add another new patron details? (y)es or (q)uit: "
            read choice
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



## ADD OTHER FUNCTIONS HERE >>



## MAIN MENU FUNCTION
main_menu () {
    clear

    echo "${bold}Patron Maintenance Menu"
    echo "${normal}"

    echo "A - Add New Patron Details"
    echo "S - Search a Patron (by Patron ID)"
    echo "U - Update a Patron Details"
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
    L|l)
        echo "insert function here";;
    P|p)
        echo "insert function here";;
    J|j)
        echo "insert function here";;
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


#mahir pushed
# mahir tried again
#To run, type bash assignment.sh or ./assignment.sh

#uses bash to run
#!/bin/bash 

#word formatting
bold=$(tput bold)
normal=$(tput sgr0)

#turn cursor off
nocursor=$(tput civis)
oncursor=$(tput cvvis)

validate_input() {
    local prompt="$1"
    local regex="$2"
    local error_message="$3"
    local input

    while true; do
        echo -n "$prompt"
        read input
        if [[ "$input" =~ $regex ]]; then
            echo "$input"
            return
        else
            echo "$error_message"
        fi
    done
}

## ADD PATRON FUNCTION
add_patron () {

    choice=y

    while [ "$choice" = "y" ]
    do
        clear
                
        echo "${bold}Add New Patron Details Form"
        echo "=========================== ${oncursor} ${normal}"

        # echo -n "Patron ID: "; read patronID
        

        # Read Patron ID
        while true; do
            echo -n "Patron ID: "; read patronID
            if [[ "$patronID" =~ ^[A-Z][0-9]{4}$ ]]; then
                break
            else
                echo "Invalid Patron ID."
            fi
        done
        while true; do
            echo -n "First Name: "; read patronFirstName
            if [[ "$patronFirstName" =~ ^[a-zA-Z]+$ ]]; then
                break
            else
                echo "Invalid First Name. Use letters."
            fi
        done
        while true; do
            echo -n "Last Name: "; read patronLastName
            if [[ "$patronLastName" =~ ^[a-zA-Z\ ]+$ ]]; then
                break
            else
                echo "Invalid Last Name."
            fi
        done
        while true; do
            echo -n "Mobile Number: "; read patronPhoneNum
            if [[ "$patronPhoneNum" =~ ^[0-9]{3}-[0-9]{7,9}$ ]]; then
                break
            else
                echo "Invalid Phone Number."
            fi
        done
        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "; read patronBirthDate
            if [[ $patronBirthDate =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                break
            else
                echo "Invalid Birth Date."
            fi
        done
        while true; do
            echo -n "Membership type (Student / Public): "; read patronMembership
            if [[ "$patronMembership" == "Student" || "$patronMembership" == "Public" ]]; then
                break
            else
                echo "Invalid membership type. Choose 'Student' or 'Public'."
            fi
        done
        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "; read patronJoinDate
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

        echo "${nocursor}"

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



## MAIN MENU FUNCTION
main_menu () {
    clear

    echo "${bold}Patron Maintenance Menu"
    echo "${normal}${nocursor}"

    echo "A - Add New Patron Details"
    echo "S - Search a Patron (by Patron ID)"
    echo "U - Update a Patron Details"
    echo "L - Sort Patrons by Last Name"
    echo "P - Sort Patrons by Patron ID"
    echo "J - Sort Patrons by Joined Date (Newest to Oldest Date)"
    echo "Q - Exit from Program"

    echo
    echo -n "Please select a choice"

    read -n1 -s choice

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
        clear
        exit
    esac

}
#hi there, I'm John Wick, You are??
#hi there, me mahir the handsome
main_menu

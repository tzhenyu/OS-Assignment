## TASK 3 SEARCH PATRON BY ID

bold=$(tput bold)
normal=$(tput sgr0)


#Makes sure that working directory is same as script directory
cd $(dirname "$0")

patron_search() {
	clear
	
	echo "${bold}Search a Patron Details"
	echo "${normal}"
	read -p "Enter Patron ID: " patron_id
	echo

	#get line where patron_id is a match
	x=$(grep "$patron_id" ./testing.txt)
	
	if [[ -n "$x" ]]; then
		#read $x and assign fields to variables x(1-7)
		IFS=':' read -r x1 x2 x3 x4 x5 x6 x7 <<< "$x"
		echo "First Name : $x2"
		echo "Last Name : $x3"
		echo "Mobile Number : $x4"          
		echo "Birth Date (MM-DD-YYYY) : $x5"
		echo "Membership type : $x6"
		echo "Joined Date (MM-DD-YYYY) : $x7"
		
		echo ; echo ; echo
		echo "Press (q) to return to Patron Maintenance Menu."
		echo 
		read -p "Search another patron? (y)es or (q)uit : " choicePS
	else
  		echo "No matching ID found."
  		read -p "Search another patron? (y)es or (q)uit : " choicePS

		case "$choice" in 
    	Y|y)
    		patron_search;;
    	Q|q)
    	##########################
    	esac
	fi
	
}

patron_search #function call

## TASK 4 

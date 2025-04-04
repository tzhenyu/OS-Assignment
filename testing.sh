## TASK 3 SEARCH PATRON BY ID

bold=$(tput bold)
normal=$(tput sgr0)


#Makes sure that working directory is same as script directory
cd $(dirname "$0")

patron_search_id() {
	choicePS='y' #initailize choicePS variable for while-loop
	while [ "$choicePS" == 'y' ] || [ "$choicePS" == 'Y' ] ; do
		clear
		
		echo "${bold}Search a Patron Details"
		echo 
		read -p "Enter Patron ID: ${normal}" patron_id
		echo

		#validates id length = 5
		length=$( echo -n "$patron_id" | wc -c)
		## echo $length
		if [[ $length -ne 5 ]]; then
			echo "Invalid ID length, please try again."
		elif [[ ! "$patron_id" =~ ^[A-Z]+[0-9]{4}$ ]]; then
			echo "Invalid ID format, please try again."
		else 
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
			else
		  		echo "No matching ID found."
			fi
		fi
		
		read -p "Search another patron? (y)es or (q)uit : " choicePS
		
		case "$choicePS" in 
			Q | q)
				exit;; ####
			n | N)
				patron_update;;
				*)
				choicePS='y';; 
		esac
	done 
}

#patron_search_id #function call



## TASK 4 Update Patron Details

patron_update() {
	choiceU='y' #initailize choiceU variable for while-loop
	while [ "$choiceU" == 'y' ] || [ "$choiceU" == 'Y' ] ; do
		clear
		
		echo "${bold}Update a Patron Details"
		echo 
		read -p "Enter Patron ID: ${normal}" patron_id
		echo

		#validates id length = 5
		length=$( echo -n "$patron_id" | wc -c)
		## echo $length
		if [[ $length -ne 5 ]]; then
			echo "Invalid ID length, please try again."
		elif [[ ! "$patron_id" =~ ^[A-Z]+[0-9]{4}$ ]]; then
			echo "Invalid ID format, please try again."
		else 
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
			else
		  		echo "No matching ID found."
			fi
		fi
		
		read -p "Are you sure you want to ${bold}UPDATE ${normal}the above Patron Details? (y)es or (q)uit : " choiceU
		
		case "$choiceU" in 
			Q | q)
				return;; ####
			*)
				choiceU='y';;
		esac
	done 
}

#patron_update


patron_search_id #call first function to start test flow

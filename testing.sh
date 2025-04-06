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
				echo "Birth Date (DD-MM-YYYY) : $x5"
				echo "Membership type : $x6"
				echo "Joined Date (DD-MM-YYYY) : $x7"
				
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
				patron_update;; #### for test flow only
				*)
				choicePS='y';; 
		esac
	done 
}

#patron_search_id 




## TASK 4 Update Patron Details

patron_update() {
	choiceU='n' #initailize choiceU variable for while-loop
	while [ "$choiceU" == 'n' ] ; do
		clear
		
		echo "${bold}Update a Patron Details"
		echo 
		read -p "Enter Patron ID: ${normal}" patron_id
		echo

		length=$(echo -n "$patron_id" | wc -c)

		#validates id length = 5		
		if [[ $length -ne 5 ]]; then
			echo "Invalid ID length."
			read -p "Press any key to try again."
			
		elif [[ ! "$patron_id" =~ ^[A-Z]+[0-9]{4}$ ]]; then
			echo "Invalid ID format."
			read -p "Press any key to try again."
			
		else 
			#get line where patron_id is a match
			x=$(grep "$patron_id" ./testing.txt)
			
			if [[ -n "$x" ]]; then
				#read $x and assign fields to variables x(1-7)
				IFS=':' read -r x1 x2 x3 x4 x5 x6 x7 <<< "$x"
				echo "First Name : $x2"
				echo "Last Name : $x3"
				echo "Mobile Number : $x4"          
				echo "Birth Date (DD-MM-YYYY) : $x5"
				echo "Membership type : $x6"
				echo "Joined Date (DD-MM-YYYY) : $x7"
				
				echo ; echo ; echo
				echo "Press (q) to return to Patron Maintenance Menu."
				echo 
				read -p "Are you sure you want to ${bold}UPDATE ${normal}the above Patron Details? (y)es or (q)uit : " choiceU
				echo
				case "$choiceU" in 
					Q | q)
						return;; ####
					Y | y)
						edit_patron;;
						*)
						choiceU='n';;
				esac				

			else
		  		echo "No matching ID found."
				read -p "Press any key to try again."
			fi
		fi
		
	done 
}

edit_patron(){
	condition=997
	condition2=886
	
	clear
	echo "Patron ID: $x1"
	
	while [[ $condition -gt 996 && $condition -lt 1000 ]]; do
		echo "Current Mobile Number: $x4"
		read -p "Enter new Mobile Number: " x4_new
		echo 
					
		if [[ -z "$x4_new" ]]; then
			echo "Mobile Number cannot be empty."
			echo
		elif [[ ! "$x4_new" =~ ^01[0-9]-[0-9]{7,8}$ ]]; then 
			echo "Invalid Mobile Number format."		
			echo 
		else 
			echo "Mobile Number updated to $x4_new"
			echo
			condition=1
		fi
		
		#Limit Errors not more than 3
		if [[ $condition -eq 999 ]]; then
			echo "Too many errors."
			unset x4_new
			condition2=1 # skip Date editing
		fi
		condition=$((condition + 1))
	done
						
	while [[ $condition2 -gt 885 && $condition2 -lt 889 ]]; do
		echo "Current Birth Date: $x5"
		read -p "Enter new Birth Date (DD-MM-YYYY): " x5_new
		echo
		
		year_now=$(date +"%Y")
		
		IFS='-' read -r DD MM YYYY <<< "$x5_new"
		if [[ -z "$x5_new" ]]; then
			echo "Birth Date cannot be empty."
			echo
		elif [[ ! "$x5_new" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4} ]]; then
			echo "Invalid date format."
			echo
		elif [[ $DD -gt 31 || $DD -lt 1 ]]; then
			echo "Day between 1 to 31."
			echo
		elif [[ $MM -gt 12 || $MM -lt 1 ]]; then
			echo "Month between 1 to 12."
			echo
		elif [[ $YYYY -gt $year_now || $YYYY -lt $(($year_now - 120)) ]]; then
			echo "Invalid year."
			echo 
		elif [[ $MM -eq 02 && $DD -gt 29 ]]; then
			echo "February has less than 29 days."
			echo
		else
			echo "Birth Date updated to $x5_new"
			echo
			break
		fi		
		
		#Limit Errors not more than 3
		if [[ $condition2 -eq 888 ]]; then
			echo "Too many errors."
			unset x5_new
			break 
		fi
		condition2=$((condition2 + 1))					
	done
	
	if [[ -z "$x5_new" || -z "$x4_new" ]]; then
		x5_new=$x5 ; x4_new=$x4 ; msg="unsuccessful."
	else 
		msg="successful."
	fi
						
	updated_entry="${x1}:${x2}:${x3}:${x4_new}:${x5_new}:${x6}:${x7}"
	sed -i "s/^$x/${updated_entry}/" ./testing.txt
	echo "Patron Details update ${bold}$msg${normal}"		
}

#patron_update




## TASK 5 Sort by Last Name ASC


patron_search_id #call first function to start test flow

## TASK 4 SEARCH PATRON BY ID

bold=$(tput bold)
normal=$(tput sgr0)


#Makes sure that working directory is same as script directory
cd $(dirname "$0")

#set data file name so that all functions can run
data_file="testing.txt"


patron_search_id() {
	choicePS='y' #initailize choicePS variable for while-loop
	
	#tests if data file exists
	if [[ ! -f ./"$data_file" ]]; then
		echo "$data_file not found." 
		choicePS='y' 
		read -p "Press enter to exit"
	fi 
	
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
			x=$(grep "$patron_id" ./"$data_file")
			
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




## TASK 5 Update Patron Details

patron_update() {
	choiceU='n' #initailize choiceU variable for while-loop
	
	#tests if data file exists
	if [[ ! -f ./"$data_file" ]]; then
		echo "$data_file not found." 
		choiceU='y' 
		read -p "Press enter to exit"
	fi 
	
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
			x=$(grep "$patron_id" ./"$data_file")
			
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
					n | N)
						sort_last_name;; #### for test flow only
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
	sed -i "s/^$x/${updated_entry}/" ./"$data_file"
	echo "Patron Details update ${bold}$msg${normal}"		
}

#patron_update




## TASK 6.1 Sort by Last Name ASC

sort_last_name() {
	choiceSL='n' #initialize choiceSL variable for while-loop
	header="Patron ID:First Name:Last Name:Phone Number:Birth Date:Type:Joined Date"
	IFS=':' read -r h1 h2 h3 h4 h5 h6 h7 <<< "$header"

	declare -a last_name
	declare -a sorted_lname

	#tests if data file exists
	if [[ ! -f ./"$data_file" ]]; then
		echo "$data_file not found." 
		choiceSL='y' 
		read -p "Press enter to exit"
	fi 
	
  	while [ "$choiceSL" == 'n' ] ; do
    	clear

    	echo "${bold}Patron Details Sorted by Last Name${normal}"
    	echo ; echo 

		while IFS=':' read -r x1 x2 x3 x4 x5 x6 x7 ; do
        	#skip first line placeholder
        	if [[ "$x1" =~ ^[A-Z]+[0-9]{4}$ ]]; then
        	    modified_lname=$(echo "$x3" | sed 's/ /,/g') # Replace space with comma
				last_name+=("$modified_lname")
            fi
 		done < "$data_file"

 		# Sort the array based on comma-separated last names
 		sorted_temp=($(printf "%s\n" "${last_name[@]}" | sort))

 		# Replace commas back with spaces for the final sorted array
 		for item in "${sorted_temp[@]}"; do
  			restored_lname=$(echo "$item" | sed 's/,/ /g') # Replace comma with space
  			sorted_lname+=("$restored_lname")
 		done

    	printf "%-15s %-20s %-11s %-15s %-12s %-9s %-12s\n" "$h3" "$h2" "$h1" "$h4" "$h5" "$h6" "$h7"
		
 		for sorted_ln in "${sorted_lname[@]}"; do
      		grep "^[^:]*:[^:]*:${sorted_ln}:" "$data_file" | while IFS=':' read -r f1 f2 f3 f4 f5 f6 f7; do
        	if [[ "$f1" != "PatronID" ]]; then
          		printf "%-15s %-20s %-11s %-15s %-12s %-9s %-12s\n" "$f3" "$f2" "$f1" "$f4" "$f5" "$f6" "$f7"
        	fi
      		done
    	done
	
	echo
	echo "Press (q) to return to Patron Maintenance Menu."
	echo
    read -p "Would you like to export the report as ASCII text file? (y)es or (q)uit: " choiceSL

    case "$choiceSL" in
      Y | y)
        # Output the header and sorted data to a file
        { printf "%-15s %-20s %-11s %-15s %-12s %-9s %-12s\n" "$h3" "$h2" "$h1" "$h4" "$h5" "$h6" "$h7" 
           
        for sorted_ln in "${sorted_lname[@]}"; do
      		grep "^[^:]*:[^:]*:${sorted_ln}:" ./"$data_file" | while IFS=':' read -r f1 f2 f3 f4 f5 f6 f7; do
       		if [[ "$f1" != "PatronID" ]]; then
        		printf "%-15s %-20s %-11s %-15s %-12s %-9s %-12s\n" "$f3" "$f2" "$f1" "$f4" "$f5" "$f6" "$f7"
        	fi
      		done 
      	done 
      	} > ./sortedlnoutput.txt 
      	;;
      Q | q)
        exit;; ####
      *)
        choiceSL='y';;
    esac
  done
}

#sort_last_name


patron_search_id #call first function to start test flow



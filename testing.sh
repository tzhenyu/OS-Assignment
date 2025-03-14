## TASK 3 SEARCH PATRON BY ID
patron_search() {
	clear
	
	echo "${bold}Search a Patron Details"
	echo
	read -p "Enter Patron ID: " patron_id

	while IFS=: 
	    read -r part1 part2 part3 part4;
	do
	    array=("$part1" "$part2" "$part3" "$part4")
		
		if [[ "$patron_id" == "$part1" ]]; then
			echo "$part3" "$part2"
		fi
			    
   	done < testing.txt
	
	
	
}


patron_search

## TASK 4 

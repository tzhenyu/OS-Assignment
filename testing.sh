## TASK 3 SEARCH PATRON BY ID
patron_search() {
	clear
	
	echo "${bold}Search a Patron Details"
	echo
	read -p "Enter Patron ID: " patron_id
	{
	declare -a input_array
      	while IFS="," read -a input_array -u "./testing.txt" 
        	do
			echo "${input_array[0]},${input_array[2]}" 
        	done
	}
}

patron_search

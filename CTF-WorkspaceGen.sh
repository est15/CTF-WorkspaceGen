#!/bin/bash
#
# Bash Script to Automate the Process of Setting
# up my terminal workspace for various CTF and
# Box challenges.
#

# The directory will be created in the working directory
create_dir=$(pwd)


# Script Useage Function
display_help () {
echo -e """
\e[32m*** CTF & HTB Box Space Terminal Automator *** \e[0m
	
Useage: spacemake.sh [-h] [-n WINDOW-NAME] [-t WINDOWS-#] [-d WORKING-DIR]

options:

	-h		Display tool usage and exit
	-n		Window naming convetion to use (Default = Work #)
	-t		Total number of windows to create (Default = 3 || Max = 10)
	-d		Working directory to create
	"""
exit
}

# Function to set the title of the Window Tab
settitle() {
	# Use xdotool to change tab title
        xdotool type "MY_FIXED_TITLE=1 && echo -e '\033]2;$display_window_name $counter\007' && cd $create_dir/$working_directory && clear"

        # Launch command
        xdotool key Return
}

# Window Variables 
display_window_name=""
display_window_count=""
working_directory=""

# Handeling the arguements passed to the script
# # Get the options 
while getopts ":hn:t:d:" option; do
case $option in
	h) # display help
		display_help
		exit;;
	n) # Window Name Convention to use
		if [[ $(expr "$OPTARG" : "$OPTARG") -gt 7 ]] then
			echo -e "\n\e[32mError: \e[31m-n\e[0m \e[32mstring must be Less than 7 characters\e[0m"
			display_help
		else 
			display_window_name=$OPTARG
		fi ;;
	t) # Create the following number of windows
		# Ensure that the Windows Number is between 1 - 10
		if [[ $OPTARG =~ ^[1-9]$|^10$ ]]; then
			display_window_count=$OPTARG
		else
			echo -e "\n\e[32mError: The values for \e[31m-t\e[0m \e[32mmust be between 1-10\e[0m"
			display_help
			exit 1
		fi ;;
	d) # Create working directory	
		if [[ -z $OPTARG ]]
		then 
			echo -e "\n\e[32mError: \e[31m-d\e[0m \e[32mstring must be have a value\e[0m"
		else
			working_directory=$OPTARG
		fi ;;
	\?) # Invalid Options
		echo -e "\e[32mError: Invalid Option\e[0m"
		display_help
		exit;;
esac
done

# Check to make sure arguments are Passed to Script
# -z returns true if string is empty
if [[ -z $display_window_name ]] || [[ -z $display_window_count ]] || [[ -z $working_directory ]]
then 
	echo -e "\e[32mError: the \e[31m-t\e[0m & \e[31m-n\e[0m & \e[31m-d\e[0m \e[32moptions are required to be set\e[0m"
	display_help
else
	full_directory="$create_dir/$working_directory"
	if [[ ! -d $full_directory ]]
	then
		mkdir $full_directory
	fi
fi

# counter to create each new terminal window accordingly 
counter=1

while [ $counter -le $display_window_count ]
do
	# Create the new tab 
	xdotool key ctrl+Shift+T
	
	# Allow for tab to open
	sleep 0.5 
	
	# First Half-Window
	settitle

	# Split Terminal Vertically
	xdotool key ctrl+Shift+R

	# Second Half-Window
	settitle

	# Incrementor 
	((counter++))
done
	

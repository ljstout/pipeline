## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Randomly extract sequences at specified odds for the purpose of sampling your data.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# Argument 1 is the input file
filename=$1
# Argument 2 is the output file
outputfile=$2
# The title sequence preface character is the greater than symbol
seqID="^>"
selected=false
# Chose the odds (in percent) that a sequence will be selected, e.g. 3% here
odds=3

while IFS='' read -r line || [[ -n "$line" ]]; do
	# If the line is a sequence identifier..
        if [[ $line =~ $seqID ]]; then
		# Upon finding a new seqID, set selected to be false so all prior data (on 
		#  multiple lines) will be removed).
		selected=false
                # Generate a random number between 1 and 100 inclusive (MAX value being 100).
                MAX=100
		# Beginning value of random is arbitrary.
                random=101
		# Compute a random number.
                let "random = $RANDOM % $MAX +1"

                echo "$random"

		# If the random number qualifies with our odds, then...
                if [[ $random -le $odds ]]; then
			# Echo the seqID line to the output file, and...
                       	echo "$line" >> $outputfile
			# Mark this seq title as selected so its basepair data to follow will also be copied over.
                        selected=true
                fi          
	# Else if it is not a sequence ID but is the basepair data following a selected seqID, then...
        elif [[ $selected == true ]]; then
		# Copy this basepair data to the file as well.
		echo "$line" >> $outputfile
	fi

	# If neither a seqID nor the data of a selected ID, simply skip to next iteration because this sequence wasn't "selected for" by our odds

done < "$filename"

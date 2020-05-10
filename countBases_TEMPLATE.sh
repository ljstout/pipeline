## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Count the nucleotide basepairs (individual characters) in a file (excluding any basepairs that may occur in the title line of a sequence)
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# First argument is a file we read in from
filename=$1
# RegEx denoting that the start of a title sequence line must always have the greater than sign
ID="^>"
# Running total of line count and total basepair count
lineNmbr=0
totalBaseCount=0

while IFS='' read -r line || [[ -n "$line" ]]; do
	# If the line we are reading is not a title line
	if [[ $line =~ $ID ]]; then
		# Code to make this if condition valid if you do not wish to print the running total (this line is needed if you chose not to).
		lineNmbr=$lineNmbr
		# Un comment the line below to get the running total after each line.
		#echo "Running total by line $lineNmbr : $totalBaseCount"
	else
		# Former line was a title, therefore this line is basepair data and should have its bases counted.
		((totalBaseCount+=${#line}))
	fi
	# Move to the next line
	((lineNmbr++))
done < "$filename"

# Print out to the terminal the total number of bases in the file.
echo "Total bases in file: $totalBaseCount"

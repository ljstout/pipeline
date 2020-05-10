## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Locates all instances of diversity sequences labeled <label> in the file passed as argument 1 and exports them to a new file (2nd arg).
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash


# File to search for certain sequences is argument 1
filename=$1
# The label to search for. Change this to specific value or RegEx depending on what you want to search for.
# Here, I am searching for sequence titles that BEGIN '^' with the text ">Steward".
label="^>Steward"
isLabelData=false
# Can be used to track which line the program is working on if you echo it during the file reading process. Not necessary.
lineNmbr=1

while IFS='' read -r line || [[ -n "$line" ]]; do
	# If the line EITHER matches our search criteria OR is the base pair data following a line that did match, export its data to the output file 
	if [[ $line =~ $label ]] || [[ $isLabelData = true ]]; then
		if [[ $isLabelData = true ]]; then
			echo "$line" >> $2
			isLabelData=false
		else
			echo "$line" >> $2
			isLabelData=true
		fi		
	fi
	((lineNmbr++))
done < "$filename"

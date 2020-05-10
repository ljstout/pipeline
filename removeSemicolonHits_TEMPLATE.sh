## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Output BLAST "compound" hits that contain a semicolon to a new file to be dealt with as your study sees fit. These are hits that match a query sequence equally likely and so BLAST separates them by a semicolon on the same line of the result file. In my experience, these commonly refer to species within a larger taxa (e.g. two bacteria both within Bacteroidetes phylum). Also prints the offending semicolon lines, and gives their line number.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

#EXAMPLE EXECUTION (All 3 parameters MANDATORY):
#bash removeSemiColonHits_TEMPLATE.sh [file w/cmpd hits] [new file name with cmpds removed] [new file name where list of removed cmpds will go]
# e.g.
# bash removeSemiColonHits_TEMPLATE.sh blastResults.csv blastResultsNoCompounds.csv blastResultsWithExtractedCompoundsOnly.csv

# Argument 1 is our input file
filename=$1
# Argument 2 is our first output file
outputNoSemicolons=$2
# Argument 3 is our second output file
outputFileOfCmpdHits=$3
lineNmbr=1

while IFS='' read -r line || [[ -n "$line" ]]; do
	# Search for lines with semicolons in them
        if [[ $line =  *";"* ]]; then
		# If the hit returned on this line has a semicolon, output it to the destination file and print it in the terminal 
                echo "$line" >> "$outputFileOfCmpdHits"
                echo "Semicolon (cmpd hit) found on line $lineNmbr: $line"
        else
		# This line must not contain a semicolon, and is a regular hit
                echo "$line" >> "$outputNoSemicolons"
        fi
	((lineNmbr++))
done < "$filename"

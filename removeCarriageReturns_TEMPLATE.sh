## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Removes all \n returns from the sequence data of .fa/.fasta files (not the ID line \n's). This is useful if your .fasta files look like this:
## ...
## >Some sequence title of a sequence with undesired line returns in the base pair data after sequencing/assembly
## ATACGATCGCGATGCTAGCTAGCTAGCTGACTAGTCGATCGAT
## TGCTAGTACGAGCTAGCTAGCTAGCTGCGAGGGGATCGAGTAC
## ACTGATCGTAGGCGTACGATGGAGCTGATGGGGATCGGTAAAA
## AATGATAGTAGATAGA 
## ...
##
## And instead you want the base pairs to all be on the same line so that your line count corresponds to 2X the amount of reads in your file, the file is simpler to read, and mistakes are easier to catch down the line.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# Argument 1 is the input file
filename=$1
# Argument 2 is the output file
outputFilename=$2
# The sequence title line identifier (all title lines must begin with >)
ID="^>"
lineNmbr=1
# A placeholder for basepair data later on
entireSeq=""

while IFS='' read -r line || [[ -n "$line" ]]; do
	# If our identifier matches the line (it's a sequence title line), we've been holding the previous sequence's bases and must...
	if [[ $line =~ $ID ]]; then
		# ...Print the previous seq's bases to the file and then clear the entireSeq string to begin collecting new sequence data over multiple lines (so long as we aren't on the very first iteration)
		if [ $lineNmbr -ne 1 ]; then
			echo "$entireSeq" >> "$outputFilename"
			entireSeq=""
		fi

		#If the line is a sequence title stop removing \n's because seq IDs should keep their \n to end the title line and denote the seq data line to follow
		#Simply output the title as is to the new file.
		echo "$line" >> "$outputFilename"

	else
		#Former line was a title, therefore this line is the actual seq. Collect its sequence data by appending this line to the seqdata variable
		entireSeq+=${line//$'\r'/}
	fi
	((lineNmbr++))
done < "$filename"

#The last sequence data is a case exception, and needs to be written explicitly or else the while loop will last output the last seq's title and no data
echo "$entireSeq" >> "$outputFilename"

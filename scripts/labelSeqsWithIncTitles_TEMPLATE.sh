## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Replaces all the original sequence titles with normalized incrementing titles to better track them throughout the pipeline.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# First argument is our read-in file
filename=$1
# Second arg is our output file
outputFilename=$2
# Sequence titles formerly began with a greater than sign, which must still be true after we are done to preserve FASTA format, but in this case we do not want the information that follows (usually applied by the assembler or sequencer, like plate/well information.
formerID="^>"
# The line number that we will use to rename our titles to. Makes it easy to see BLAST results when done and trace them back to individual sequences in your original data. We commonly employed this to grab interesting sequences after a BLAST and then use Web BLAST to get further information on a case-by-case basis.
lineNmbr=1

while IFS='' read -r line || [[ -n "$line" ]]; do
	# If our line matches the ID we are expecting (if your file is FASTA it will)
	if [[ $line =~ $formerID ]]; then
		# Then write the incrementing counter title to the file in lieu of the former title
		newTitle="$lineNmbr"
		echo ">$newTitle" >> "$outputFilename"
		((lineNmbr++))
	else
		#Former line was a title, therefore this line is the actual seq.. Simply read it to file
		echo "$line" >> "$outputFilename"
	fi
done < "$filename"

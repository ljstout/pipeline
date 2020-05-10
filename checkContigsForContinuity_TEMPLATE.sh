## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## After assigning incrementing number titles to sequences with our other script, now you can check the contigs in a file of hits to see if the they are incrementing properly (e.g. to see why the number of hits do not match the number of seqs in the query or other intermediate-step quality check measures).
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# Argument 1 is the filename to read from.
filename=$1
# The ID is a preface to the sequence title
ID="Contig"
# Which number to begin counting from
lineNmbr=1

while IFS=',' read -r f1 f2
do
	# $f2 is assumed to be the position in the CSV of the incrementing number title we assigned earlier.
	#echo "$ID$lineNmbr | $f2" # Remove this comment if you want to see what the program is working on "live" in the terminal
	if [ "$ID$lineNmbr" != "$f1" ]
	then
		# Our results file skipped over the expected sequence title, meaning no hit occurred for that sequence.
		echo "Expected $ID$lineNmbr ; Received $f1 ; Thus, $ID$lineNmbr had no significant results when blasted."
		# ...So we need to increment our line an additional time before we keep counting because now we expect the next sequence title
		((lineNmbr++))
	fi
	# Expect the next sequence title.
        ((lineNmbr++))
done < "$filename"

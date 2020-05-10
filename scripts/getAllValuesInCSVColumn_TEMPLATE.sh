## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Get a specified value in each row from a CSV (column value) and output it to a new file (the second argument).
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# Argument 1 is the read-in file
filename=$1
# Argument 2 is the file to output your extracted values to
writeFile=$2

# f1, f2, etc., correspond to fields in a CSV, add or remove them as needed but they must be consecutive up until the greatest number you want (and can be named anything but numbers are straightforward to relate back to which column)
while IFS="," read f1 f2 f3 f4 f5 f6
do
	#***CHANGE $f1 to whatever you named the desired CSV column value***
        echo "$f1" >> $writeFile
done < "$filename"

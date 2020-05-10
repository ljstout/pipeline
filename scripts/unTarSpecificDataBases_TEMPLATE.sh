## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## After installing the massive, compressed NT database, you will want to "un tar" the folders to be able to use your database. This script automates unpacking all of the volumes.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

# I untar everything from 0 to 50, i.e. nt.00.tar.gz -> nt.50.tar.gz, but you can change these numbers according to your needs (and the 'nt' part if you are using a different database)
for i in $(seq -f "%02g" 0 50)
do
	echo "$i"
	tar zxvpf nt."$i".tar.gz
done
exit 0

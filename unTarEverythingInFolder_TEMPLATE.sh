## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Un tar all .gz files in the same folder as this script.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/bash

for a in $(ls -1 *.gz); do tar -zxvpf $a; done

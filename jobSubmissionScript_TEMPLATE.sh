## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## A template BLAST+ job submission script for a Moab job scheduler.
## Change values to adapt to your experiment as necessary.
####################################################################

#!/bin/sh
#PBS -l nodes=1:ppn=32
#PBS -N #NAME_OF_JOB
#PBS -S /bin/bash
#PBS -j oe
#PBS -a #[DATE_TIME_OF_EXECUTION_START: MMDDhhmm]
#PBS -l walltime=#[EXECUTION_TIME: DD:HH:mm:ss]

# Tell the server node that is executing this script to load the BLAST program from memory
module load blast

# Use a "nucleotide blast" (blastn) to "blast" our query data against the desired database. Specify additional formatting preferences, and importantly,  
#  include "staxids" to get Taxonomy database references to be used later to obtain lineages, also include e-value, and limit the number of 
#  maximum matches to 1 in order to obtain only the best match. Use -num_threads for parallelized execution when possible to speed up computations.
#  Finally, specify an output file. More information on BLAST parameters here: 
#    https://www.ncbi.nlm.nih.gov/books/NBK279684/#_appendices_Options_for_the_commandline_a_

blastn -query ~/DIRECTORY_TO_QUERY_DATA/SOME_QUERY_DATA.fasta -db ~/DIRECTORY_CONTAINING_DESIRED_DATABASE -task blastn -dust no -outfmt "10 staxids qseqid sscinames evalue sseqid sacc" -max_target_seqs 1 -max_hsps 1 -num_threads 32 > ~/DIRECTORY_TO_OUTPUT_FOLDER/OUTPUT_FILE_BLAST_RESULTS.csv

# pipeline
### A bioinformatics pipeline written by Luke Stout to facilitate local BLAST searches and analyze and process data.  
---
05/09/2020

This pipeline and associated data correspond to the study by Luke Stout and Marisa Pedulla:

  _COMPARISON OF BACTERIAL DIVERSITY INTERPRETED BY 16S rRNA AND SHOTGUN METAGENOMIC SEQUENCE PROFILES_

We have made our results public in the process of publishing our own study, but we encourage you to adapt and leverage our methodology as well, which we have uploaded in the form of scripts with the _\_TEMPLATE_ suffix to remind you to adapt them as needed. Scripts have been generalized in an effor to appeal to a broader audience, but they are still coupled with our study's goals and thus will likely require changes to be applicable to your experiment.

## Assumptions

This is not a guide. 

You are welcome to ask questions about our approach and technique, and we welcome how-to questions, but we cannot at this time provide a comprehensive guide to starting. You are encouraged to search for bioinformatics shortcuts and code which are available on various blogs ([we recommend this one for some good one-liners](https://bioinformaticsworkbook.org/dataWrangling/fastaq-manipulations/converting-fastq-format-to-fasta.html)) and sites like the [Bioinformatics Stack Exchange.](https://bioinformatics.stackexchange.com)

In spite of this, the majority of the scripts/code you would need to conduct a similar study is present herein (only missing the terminal commands to submit jobs to your scheduler, run little housekeeping tasks like moving files, etc., which all can be learned quickly by following a LINUX tutorial). Apart from this, we only really assume that you have access to a server with:

+ Your FASTA sequences files in known directories (if they are FASTQ you can change them to FASTA with [commands listed here.](https://bioinformaticsworkbook.org/dataWrangling/fastaq-manipulations/converting-fastq-format-to-fasta.html)

+ The databases you intend to use and their known directories. We used the FTP site provided by NCBI (https://ftp.ncbi.nlm.nih.gov) to download the Nucleotide Database (NT), 16SrRNA database (16SMicrobial), and Taxonomy database. We include a script to unpackage these once you have downloaded them by your preferred means.

+ Necessary software installed, not limited to 
  + [BLAST+](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download) 
  + [hmp_client](https://github.com/michbur/hmp_client) if you intend to use data from the [Human Microbiome Project](https://www.hmpdacc.org)
  + [ETE3 Python module](https://pypi.org/project/ete3/#description) for obtaining lineages from your local copy of the Taxonomy database, assuming you do not use...
  + [NCBI's Entrez-Direct E-Utilities; "eutils"](https://www.ncbi.nlm.nih.gov/books/NBK179288/) an API for accessing taxonomic information in small input loads via 
  + [Python](https://www.python.org/downloads/)

If you are just starting out, a lot of troubleshooting can be avoided by creating a simplistic file structure with your sequences, databases, scripts, and results each as subfolders of your overall "project" folder. The software and databases are necessarily picky about where things go, and going through these tutorials myself it isn't always clear whether things should be placed in folders, subfolders, etc.

## Script Usage

Please note that all but one script are bash shell scripts (the ETE3 script uses Python). We kept a general convention so that most scripts can be run like so:

  `$ bash <script name> [input file]? [outputfile]? [output 2]?`
  
For specific questions, feel free to contact me directly (Luke, lukejaystout@gmail.com). 

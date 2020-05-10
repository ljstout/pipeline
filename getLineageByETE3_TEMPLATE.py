## LStout, MPedulla
## Montana Technological University
## 05/09/2019
## https://github.com/ljstout/pipeline
## Utilize ETE3 to get lineages for taxIDs after BLAST results. Requires the Taxonomy DB be local and accessible.
## NOTE: Derived from BioGeek at... 
##   https://stackoverflow.com/questions/36503042/how-to-get-taxonomic-specific-ids-for-kingdom-phylum-class-order-family-gen
## Change values to adapt to your experiment as necessary.
####################################################################

# Import the modules we need
import csv
import time
import sys
from ete3 import NCBITaxa

# Reference to the NCBI object we will use to map taxIDs to lineages
ncbi = NCBITaxa()

def get_desired_ranks(taxid, desired_ranks):
    lineage = ncbi.get_lineage(taxid)   
    names = ncbi.get_taxid_translator(lineage)
    lineage2ranks = ncbi.get_rank(names)
    ranks2lineage = dict((rank,taxid) for (taxid, rank) in lineage2ranks.items())
    return{'{}_id'.format(rank): ranks2lineage.get(rank, '<not present>') for rank in desired_ranks}

# Main method, read in file of taxIDs
if __name__ == '__main__':
    file = open(sys.argv[1], "r")    
    taxids = []
    contigs = []
    for line in file:
        line = line.split("\n")[0]
	tID = line.split(",")[0]
	if ';' in tID: 
	    tID = tID.split(";")[0]
	taxids.append(tID)
        contigs.append(line.split(",")[1])

    # A list of NCBI's taxa we want specified in our output
    desired_ranks = ['superkingdom', 'phylum']
    results = list()
    for taxid in taxids:
        results.append(list())
	results[-1].append(str(taxid))
	ranks = get_desired_ranks(taxid, desired_ranks)
	for key, rank in ranks.items():
            # If a taxID results in a "<not present>", for this study we don't want it, you may wish to remove this condition and keep the line inside if this doesn't apply to your experiment
            if rank != '<not present>':
	        results[-1].append(list(ncbi.get_taxid_translator([rank]).values())[0])
            else:
		results[-1].append(rank)

    i = 0
    for result in results:
        print(contigs[i] + ','),
        print(','.join(result))
	i += 1

    file.close()

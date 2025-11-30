# E.Coli Variant Pipeline

# INTRODUCTION
	This automatic pipeline analyzes DNA sequencing data from "E.Coli" to identify genetic mutation (Variants). IT was built to replicate the findings of Lenski Long-Term Evolution Experiment.


## FUNCTIONS
---> Automated Download: Fetching Reference Genome & NGS Reads from NCBI
---> Aligning & Indexing reads using BWA
---> Identifying Mutation using Bcftools.
---> Filtering and removing low-quality variants.

### REQUIREMENTS
.....Conda needs to be installed with:
---bwa
---sratools
---samtools
---bcftools

### RUN
1. Clone the repository
2. Make the script executable:
	```bash
	chmod +x pipeline.sh

## Run the pipelin:
	./pipeline.sh


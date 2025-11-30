#!/bin/bash

set -e

echo "Starting my pipeline....."

REF = "ref.fa"
READS = "reads.fq"
OUTPUT = "results.vcf"

echo "Reference Genome: $REF"
echo "Input Reads : $READS"

echo "STEP 1: Downloading Data...."

if [ ! -f $REf ]; then
	wget -O $REF
"https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz"
	gunzip -f GCA_000017985.1_ASM1798v1_genomic.fna.gz
	mv GCA_000017985.1_ASM1798v1_genomic.fna $REF
else 
	echo "Reference already found. Skipping..."
fi

if [ ! -f $READS ]; then
	fastq-dump -X 25000 -stdout SRR2584866 > $READS
else 
	echo "READS found skipping..."
fi

echo "STEP 2: Indexing Reference..."
bwa index $REF

echo "STEP 3: Aligning Reads..."
bwa mem $REF $READS > aligned.sam

echo "STEP 4: CONVERTING AND SORTING..."
samtools view -S -b aligned.sam | samtools sort -o sorted.bam
samtools index sorted.bam

echo "STEP 5: calling variant..."
bcftools mpileup -f $REF sorted.bam | bcftools call -mv > raw_variants.vcf

echo "STEP 6: Filtering ..."
bcftools filter -e "QUAL<20 || DP<10" raw_variants.vcf > $OUTPUT

echo "Pipeline Finished Succesfully! Results are in $OUTPUT"



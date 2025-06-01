#!/bin/bash
set -euo pipefail

#----------------------------#
# Configuration and Inputs  #
#----------------------------#

THREADS=80
KMER_SIZE=31
MIN_COUNT=1
MAX_COUNT=10000
TMP_DIR="tmp"

GENOME_FASTA="cadenzaHB4_genome.fasta"
PLASMIDS_FASTA="Plasmids_up.fasta"
PRIMARY_BED="primary.bed"
KMC_GENOME_DB="genome_kmc"
KMC_PLASMID_DB="plasmids_kmc"
KMC_SHARED_DB="shared_kmers"
KMC_QUERY_DB="kmers_query"
KMERS_FINAL_DB="kmers_present"
CS_GENOME_FASTA="GCA_018294505.1_IWGSC_CS_RefSeq_v2.1_genomic.fna"
KARIEGA_GENOME_FASTA="GCA_910594105.1_Tae_Kariega_v1_genomic.fna"

#----------------------------#
# Step 1: Align plasmids to genome using Minimap2
#----------------------------#
echo "[Step 1] Aligning plasmids to genome..."
minimap2 -x asm5 -t "$THREADS" "$GENOME_FASTA" "$PLASMIDS_FASTA" > plasmids_vs_genome.paf

#----------------------------#
# Step 2: Extract primary genomic regions using BEDTools
#----------------------------#
echo "[Step 2] Extracting primary genomic regions..."
bedtools getfasta -fi "$GENOME_FASTA" -bed "$PRIMARY_BED" -fo primary_sequences.fa

#----------------------------#
# Step 3: Count 31-mers in genome and plasmids
#----------------------------#
echo "[Step 3] Counting 31-mers in genome..."
kmc -k"$KMER_SIZE" -ci"$MIN_COUNT" -cs"$MAX_COUNT" -fm "$GENOME_FASTA" "$KMC_GENOME_DB" "$TMP_DIR"

echo "[Step 4] Counting 31-mers in plasmids..."
kmc -k"$KMER_SIZE" -ci"$MIN_COUNT" -cs"$MAX_COUNT" -fm "$PLASMIDS_FASTA" "$KMC_PLASMID_DB" "$TMP_DIR"

#----------------------------#
# Step 5: Find shared k-mers between genome and plasmids
#----------------------------#
echo "[Step 5] Intersecting genome and plasmid k-mers..."
kmc_tools simple "$KMC_PLASMID_DB" "$KMC_GENOME_DB" intersect "$KMC_SHARED_DB"

#----------------------------#
# Step 6: Dump shared k-mers to a readable text file
#----------------------------#
echo "[Step 6] Dumping shared k-mers..."
kmc_dump "$KMC_SHARED_DB" shared_kmers.txt

#----------------------------#
# Step 7: Analyze additional genome (e.g., CS RefSeq)
#----------------------------#
echo "[Step 7] Counting k-mers in CS genome..."
kmc -k"$KMER_SIZE" -ci"$MIN_COUNT" -cs"$MAX_COUNT" -fm "$CS_GENOME_FASTA" "$KMC_GENOME_DB" "$TMP_DIR"

echo "[Step 8] Dumping all k-mers from CS genome..."
kmc_tools transform "$KMC_GENOME_DB" dump genome_kmers_all.txt

#----------------------------#
# Step 9: Analyze Kariega genome
#----------------------------#
echo "[Step 9] Counting k-mers in Kariega genome..."
kmc -k"$KMER_SIZE" -ci"$MIN_COUNT" -cs"$MAX_COUNT" -fm "$KARIEGA_GENOME_FASTA" "$KMC_GENOME_DB" "$TMP_DIR"

#----------------------------#
# Step 10: Find shared k-mers with a query file
#----------------------------#
echo "[Step 10] Counting k-mers in query fasta (Shared_Kmers_Uniq.fasta)..."
kmc -k"$KMER_SIZE" -ci"$MIN_COUNT" -cs"$MAX_COUNT" -fm Shared_Kmers_Uniq.fasta "$KMC_QUERY_DB" "$TMP_DIR"

echo "[Step 11] Intersecting query with Kariega genome..."
kmc_tools simple "$KMC_QUERY_DB" "$KMC_GENOME_DB" intersect "$KMERS_FINAL_DB"

echo "[Step 12] Dumping present k-mers..."
kmc_dump "$KMERS_FINAL_DB" kmers_present.txt

#----------------------------#
# Step 13: Map k-mers to genome
#----------------------------#
echo "[Step 13] Mapping k-mers to genome using Python script..."
python map_kmers_to_genome.py

echo "[✅ Done] Pipeline completed successfully!"


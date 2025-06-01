# Insert_Check
An alternative approach to check for the absence of insertions in undesired regions of the genome assemblies.
Plasmid–Genome K-mer Intersection Pipeline
This pipeline performs a comprehensive comparison between plasmid sequences and a reference genome using sequence alignment and k-mer-based set operations. It identifies shared and unique k-mers, maps them to genomes, and outputs them for downstream analysis.

📂 Overview
The script performs the following major steps:

Aligns plasmids to the genome using Minimap2

Extracts specific genome regions using BEDTools

Counts 31-mers in genome and plasmid FASTA files using KMC

Identifies shared k-mers via KMC Tools

Maps shared k-mers to genome coordinates using a Python script

🚀 Getting Started
🔧 Prerequisites
Make sure the following tools are installed and available in your $PATH:

minimap2

bedtools

kmc

python

map_kmers_to_genome.py (custom script provided by user)

✅ Recommended to run inside a Linux environment with high-performance compute resources.

📄 Input Files
Filename	Description
cadenzaHB4_genome.fasta	Reference genome sequence
Plasmids_up.fasta	Plasmid sequences
primary.bed	BED file of primary regions to extract
Shared_Kmers_Uniq.fasta	Fasta of known k-mers of interest
map_kmers_to_genome.py	Python script to map k-mers to genome

📜 Usage
1. Clone or copy this repository
bash
Copy
Edit
git clone https://github.com/yourusername/plasmid-kmer-pipeline.git
cd plasmid-kmer-pipeline
2. Make the script executable
bash
Copy
Edit
chmod +x plasmid_kmer_pipeline.sh
3. Run the script
bash
Copy
Edit
./plasmid_kmer_pipeline.sh
📦 Outputs
Output File	Description
plasmids_vs_genome.paf	PAF alignment file from Minimap2
primary_sequences.fa	Extracted genomic regions from BED file
shared_kmers.txt	Shared k-mers between plasmid and genome
genome_kmers_all.txt	All k-mers from CS reference genome
kmers_present.txt	Final list of mapped shared k-mers
*.kmc_*	KMC binary databases
tmp/	Temporary directory used by KMC

⚙️ Configuration
You can adjust key parameters at the top of the script:

bash
Copy
Edit
THREADS=80
KMER_SIZE=31
MIN_COUNT=1
MAX_COUNT=10000
TMP_DIR="tmp"
🧾 Citation
If you use this pipeline or any of the tools in your research, please cite the corresponding tools:

Minimap2: Li (2018), Bioinformatics

BEDTools: Quinlan & Hall (2010), Bioinformatics

KMC: Kokot et al. (2017), Bioinformatics

Biopython: Cock et al. (2009), Bioinformatics (if using the Python script)

🧠 Notes
Ensure tmp/ exists before running, or create it in the script.

The pipeline overwrites KMC databases (genome_kmc) during different stages—use separate names if you want to retain intermediate versions.

The Python script map_kmers_to_genome.py must match the k-mer length and input format of kmers_present.txt.


# Insert_Check
# 🧬 Plasmid–Genome K-mer Intersection Pipeline

This repository contains a Bash pipeline that compares plasmid sequences to a reference genome using **k-mer-based analysis** and sequence alignment. It identifies shared k-mers, maps them to genome positions, and outputs them in standard formats.

## 📂 Overview

- Align plasmid to genome using **Minimap2**
- Extract genomic sequences using **BEDTools**
- Count and compare k-mers using **KMC**
- Identify and map shared k-mers to genome positions
- Output data for further genomic comparison and analysis

---

## 🚀 Getting Started

### 🔧 Requirements

Make sure the following tools are installed:

- `minimap2`
- `bedtools`
- `kmc` and `kmc_tools`
- `python`
- `Biopython` (for the `map_kmers_to_genome.py` script)

### 📦 Input Files

| File | Description |
|------|-------------|
| `cadenzaHB4_genome.fasta` | Reference genome |
| `Plasmids_up.fasta` | Plasmid sequences |
| `primary.bed` | BED file of regions to extract |
| `Shared_Kmers_Uniq.fasta` | FASTA file with known query k-mers |
| `map_kmers_to_genome.py` | Python script to map k-mers |

### 📜 Running the Pipeline

```bash
chmod +x plasmid_kmer_pipeline.sh
./plasmid_kmer_pipeline.sh

# 🧪 Method Description

## Plasmid Residue Screening in Transformed Wheat Using K-mer and Alignment-Based Approaches

To ensure the absence of residual plasmid sequences outside the targeted insertion site on chromosome 2D in transformed wheat plants, we implemented a two-tiered bioinformatics screening strategy.

---

### 1. Alignment-Based Screening

A whole-genome alignment was conducted using **Minimap2**, comparing plasmid sequences (`Plasmids_up.fasta`) against the transformed wheat genome (`cadenzaHB4_genome.fasta`). This alignment revealed a 52 bp match on chromosome 4. However, further coordinate validation and sequence annotation confirmed this region to be native to wheat (see Supplementary Files).

---

### 2. K-mer-Based Screening with KMC

To increase resolution and capture even short shared regions:

- **31-mers** were independently generated from both the genome and plasmid sequences using `kmc`.
- Intersections were computed with `kmc_tools` to identify shared k-mers.
- These were mapped back to the genome and exported as BED files.
- This analysis revealed **107 shared k-mers** outside chromosome 2D's insertion site.
- **21 unique k-mers** were selected for further validation based on uniqueness and genome mapping.

---

### 3. Validation Against Non-Transformed References

To determine whether the 21 k-mers were artifacts or naturally occurring:

- They were queried using the same KMC pipeline against:
  - **GCA_018294505.1** (cv. Chinese Spring, IWGSC RefSeq v2.1)
  - **GCA_910594105.1** (cv. Kariega)

All 21 k-mers were found in both references, confirming they are **endogenous wheat sequences** rather than plasmid-derived residues.

---

### Supplementary Files

Supplementary materials include:
- Coordinate tables
- BED and PAF files
- Sequence annotations
- Alignment screenshots

(You may add a link here if hosted on [Zenodo](https://zenodo.org/), Dryad, or an institutional repo.)


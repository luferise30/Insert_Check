from Bio import SeqIO
import sys

# Parámetros
genome_fasta = "cadenzaHB4_genome.fasta"
kmers_file = "shared_kmers.txt"
output_bed = "shared_kmers_hits.bed"

# Cargar k-mers en un set para búsqueda rápida
with open(kmers_file) as f:
    kmers = set(line.strip().split()[0] for line in f)

kmer_len = len(next(iter(kmers)))

# Abrir archivo BED de salida
with open(output_bed, "w") as out_bed:
    for record in SeqIO.parse(genome_fasta, "fasta"):
        chrom = record.id
        seq = str(record.seq).upper()
        for i in range(len(seq) - kmer_len + 1):
            subseq = seq[i:i+kmer_len]
            if subseq in kmers:
                out_bed.write(f"{chrom}\t{i}\t{i + kmer_len}\t{subseq}\n")


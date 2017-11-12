#!/bin/bash

#SBATCH -A b2014097
#SBATCH -p node
#SBATCH -n 32
#SBATCH -t 200:00:00
#SBATCH -J star-mapping-and-counts
#SBATCH -o /proj/b2014097/nobackup/Niyaz/logs/star-mapping-and-counts.out
#SBATCH -e /proj/b2014097/nobackup/Niyaz/logs/star-mapping-and-counts.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=niyaz.yoosuf@ki.se

module load bioinfo-tools
module load star/2.5.3a

for read1 in *R1_001_val_1.fq.gz; do read2=$(echo $read1| sed 's/R1_001_val_1.fq.gz/R2_001_val_2.fq.gz/');

star --runThreadN 32 --runMode alignReads --readFilesCommand zcat --outFilterMultimapNmax 30 \
--outFilterScoreMinOverLread 0.3 --outFilterMatchNminOverLread 0.3 --outSAMtype BAM SortedByCoordinate \
--twopassMode Basic --outWigType bedGraph --outFileNamePrefix /proj/b2014097/nobackup/Niyaz/FastQ_files/STAR_Output/Mapped_$read1 --outWigStrand Unstranded \
--outSAMstrandField intronMotif --genomeLoad NoSharedMemory --genomeDir /proj/b2014097/nobackup/Niyaz/STAR/Genome/STAR-Index/ --quantMode GeneCounts --sjdbGTFfile /proj/b2014097/nobackup/Niyaz/STAR/Annotation/gencode.v27.annotation.gtf --readFilesIn $read1 $read2

done
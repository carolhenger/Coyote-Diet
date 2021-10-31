#remove unaligned sequences: 
obigrep -p 'mode!="joined"' plantsBoth.fastq > plantsBoth.ali.fastq
#only keep unique sequences:
obiuniq -m sample plantsBoth.ali.fastq > plantsBoth.ali.assigned.uniq.fasta
#edit the header:
obiannotate -k count -k merged_sample plantsBoth.ali.assigned.uniq.fasta > $$ ; mv $$ plantsBoth.ali.assigned.ann2.uniq.fasta
#remove sequences shorter than 80 bp and count less than or equal to 10:
obigrep -l 30 -p 'count>=10' plantsBoth.ali.assigned.ann2.uniq.fasta > plantsBoth.ali.assigned.ann2.uniq.count.fasta
#classify sequence records as head, internal, or singleton
obiclean -s merged_sample -r 0.05 -H plantsBoth.ali.assigned.ann2.uniq.count.fasta > plantsBoth.ali.assigned.ann2.uniq.count.clean.fasta
#match sequences to database:
ecotag -d /plant -R plantdb_uniq.fasta plantsBoth.ali.assigned.ann2.uniq.count.clean.fasta > plantsBoth.ali.assigned.ann2.uniq.count.tag.fasta
#sort by count:
obisort -k count -r plantsBoth.ali.assigned.ann2.uniq.count.tag.fasta > plantsBoth.ali.assigned.ann2.count.tag.sort.fasta
#make text file:
obitab -o plantsBoth.ali.assigned.ann2.count.tag.sort.fasta > plantsBoth.txt
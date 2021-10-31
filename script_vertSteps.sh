#remove unaligned sequences: 
obigrep -p 'mode!="joined"' vertsBoth.ann.fastq > vertsBoth.ann.ali.fastq
#only keep unique sequences:
obiuniq -m sample vertsBoth.ann.ali.fastq > vertsBoth.ann.ali.assigned.uniq.fasta
#edit the header:
obiannotate -k count -k merged_sample vertsBoth.ann.ali.assigned.uniq.fasta > $$ ; mv $$ vertsBoth.ann.ali.assigned.ann2.uniq.fasta
#remove sequences shorter than 80 bp and count less than or equal to 10:
obigrep -l 80 -p 'count>=10' vertsBoth.ann.ali.assigned.ann2.uniq.fasta > vertsBoth.ann.ali.assigned.ann2.uniq.count.fasta
#classify sequence records as head, internal, or singleton
obiclean -s merged_sample -r 0.05 -H vertsBoth.ann.ali.assigned.ann2.uniq.count.fasta > vertsBoth.ann.ali.assigned.ann2.uniq.count.clean.fasta
#match sequences to database:
ecotag -d vertAll -R vertCombined_uniq.fasta vertsBoth.ann.ali.assigned.ann2.uniq.count.clean.fasta > vertsBoth.ann.ali.assigned.ann2.uniq.count.tag.fasta
#sort by count:
obisort -k count -r vertsBoth.ann.ali.assigned.ann2.uniq.count.tag.fasta > vertsBoth.ann.ali.assigned.ann2.count.tag.sort.fasta
#make text file:
obitab -o vertsBoth.ann.ali.assigned.ann2.count.tag.sort.fasta > vertsBoth.ann.txt
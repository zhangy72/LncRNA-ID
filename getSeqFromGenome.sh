#!/bin/bash

[ $# -eq 1 ] || { echo "$0 <bed_file>"; exit;}

# bed file
#chr1    63270175        63272901        linc1643.3_5    0       +       63270175        63270175        0,0,0   1       2726,   0,
#chr1    64726442        64737228        linc1644.3_0    0       -       64726442        64726442        0,0,0   2       517,191,        0,10595,
bedFile=$1
preChr="";

cat $bedFile | while read line
do
	chr=`echo $line|awk '{print $1}'`
	# load genome file
	if [[ "$chr" != "$preChr" ]]; then
		# load new genome file
		genomeFile=$chr".fa1"
		preChr=$chr;
	fi
	
	# cut out the sequence from the chrosome
	beg=`echo $line|awk '{print $2}'`
	end=`echo $line|awk '{print $3}'`
	seqname=`echo $line|awk '{print $4}'`
	strand=`echo $line|awk '{print $6}'`
	seq=`tail -1 $genomeFile| awk -v beg=$beg -v end=$end -v strand="$strand" '{ len=end-beg+1; print substr($0,beg,len);}'`

	if [[ "$strand" == "-" ]]; then
		seq=${seq//A/t}
		seq=${seq//T/a}
		seq=${seq//C/g}
		seq=${seq//G/c}
		seq=`echo "$seq" |awk '{print toupper($0);}' |rev`
	fi

	# generate a mRNA	sequence (only exon)
	mrna=`echo $line | awk -v seq="$seq" '{
		size=split($11,len,",");
		size=split($12,position,",");
		mrna="";
		for (i=1; i<size; i++) {
			tmp=substr($seq,position[i]+1,len[i]);
			mrna=mrna""tmp;
		}
		print mrna;
	}'`

	echo ">$seqname" >> mouse_dna.fa;
	echo ">$seq" >> mouse_dna.fa;

	echo ">$seqname" >> mouse_rna.fa;
	echo ">$mrna" >> mouse_rna.fa;
done

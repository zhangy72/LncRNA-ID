# calculate expression in coding region and 3'utr

if [[ $# -ne 2 ]]; then
	echo "Usage:"`basename $0` "<file_index1.orf> <bowtie.sam>"
	exit
fi

file1=$1
file2=$2

awk '
FNR==NR {
	# script a header line
	# read a coding region (ORF) of a transcript 	
	if (FNR>1) {
		tran[$1]=$1;
		orf_begin[$1]=$5;
		orf_end[$1]=$6;
		orf_len[$1]=$2;
		cread_pos[$1]=0;
		cread_neg[$1]=0;
		utr3_pos[$1]=0;
		utr3_neg[$1]=0;
	}
}
FNR < NR {
	if ($4<orf_begin[$3]) {
		
	} else if ($4>=orf_begin[$3]) {
			split($1,read,"-");
			if ($4<=orf_end[$3]) {
				# cds
				if ($2=="16") {
					# read is on a reverse strand;
					cread_neg[$3]+=read[2];
				} else {
					# read is on the same strand;
					cread_pos[$3]+=read[2];
				}
			} else if ($4<=orf_len[$3]-5) {
				# 3utr
				if ($2=="16") {
					# read is on a reverse strand;
					utr3_neg[$3]+=read[2];
				} else {
					# read is on the same strand;
					utr3_pos[$3]+=read[2];
				}
			}
	}
}
END {
	print "tranID orf_len orf_begin orf_end cds_read 3utr_read cds_read+ cds_read- 3utr_read+ 3utr_read-";
	for (x in tran) {
		print tran[x],orf_len[x],orf_begin[x],orf_end[x],(cread_pos[x]+cread_neg[x]),(utr3_pos[x]+utr3_neg[x]),cread_pos[x],cread_neg[x],utr3_pos[x],utr3_neg[x];
	}
}' $file1 $file2

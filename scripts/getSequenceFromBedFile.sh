#!/bin/bash

[ $# -eq 4 ] || { echo "$0 <genome_in_fasta> <begin_position> <end_position> <strand>"; exit;}

genomeFile=$1
beg=$2
end=$3
strand=$4


#read genome
genome=`grep -E -v "^>" $genomeFile`
#genome=`grep -E -v "^>" $genomeFile| awk 'BEGIN {seq="";} 
#		{
#			seq=seq""$0
#		}
#		END {
#			print seq;
#		}'`
#echo ">chr2" >> tair10_chr2.fs
#echo $genome >> tair10_chr2.fs
seq=`echo $genome| awk -v beg=$beg -v end=$end -v strand="$strand" '{ len=end-beg+1; print substr($0,beg,len);}'`

if [[ "$strand" == "-" ]]; then
	seq=${seq//A/t}
	seq=${seq//T/a}
	seq=${seq//C/g}
	seq=${seq//G/c}
	seq=`echo "$seq" |awk '{print toupper($0);}' |sed 's/./&\n/g' |tac |tr -d '\n'`
fi
echo $seq

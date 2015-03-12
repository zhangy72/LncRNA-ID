LncRNA-ID
=========

This project contains supporting scripts and data for the paper **Long non-coding RNA IDentification using balanced random forest** by Rujira Achawanantakun, Yanni Sun, and Yuan Zhang.

Files
===========

Scripts:
------------------
expression.sh: calculate expression in coding region and 3'utr  

getSeqFromGenome.sh: get genes and lncRNAs from genomic sequence    

getSequenceFromBedFile.sh: get sequences from Bed format files  

DNA2Protein.cpp: Tranlsate DNA sequences into a protein sequence using multiple frame translations  

Data:
--------------------
The data are available for download at [here](https://www.dropbox.com/sh/7yvmqknartttm6k/AAAGJrYG2eZSn8QG7oVsYCyOa?dl=0).

The data files used in our experiments are organized into the following four folders:

1. H1_gencode/ : the human GENCODE data set (H1)  

2. M1_gencode/ : the mouse GENCODE data set (M1)

3. H2_cpat/ : CPAT’s human data set (H2)

4. M2_ribosomeRelease/ : experimentally verified mouse lncRNA data set (M2)

#!/bin/bash

cd ../../genomes

awk '{ if ( $0 ~ /^>/ ) { print ">"$NF } else { print } }'  Ahal_W302_V2.2.fasta > Ahal_W302_V2.2_Head.fasta
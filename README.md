# BactStream
![Python](https://badges.aleen42.com/src/python.svg) 

Code that downloads one bacterial genome at a time, maps the reads, calls the variants, annotates them and outputs a pseudoalignment

BactStream avoids the storage requirements of downloading thousands of _.fastq__ and gets right to the much smaller .vcf


## Quick start 

```shell
BactStream --reference <reference.fasta> --sra_ids <accessions.txt>
```

If the run is interrupted just run _BactStream_ again and it'll continue where it left off

## Options
If any of your dependencies are not in the path they can be provided:

```shell
BactStream <reference.fasta>
```





## Build a phylogeny

Combine whole reference SNP alignments, extract the core genome with [BactCore](https://github.com/moorembioinfo/BactCore) and generated a phylogeny with [IQTREE](https://github.com/Cibiv/IQ-TREE) and [ClonalFrameML](https://github.com/xavierdidelot/ClonalFrameML)


```shell
cat */*aln > wga.aln 
BactCore wga.aln > core_alignment.fasta
iqtree -s core_alignment.fasta -B 1000
ClonalFrameML core_alignment.fasta.treefile core_alignment.fasta bactvarproject
```

## Dependencies

BactVar is written in python3 and requires the following python packages:

> - Biopython

BactVar has been built around bwa, GATK, snpEff etc. The most up to date versions (mid 2023) have been used:

> - prokka
> - Java ≥v17 
> - GATK (tested on v4.4.0) 
> - bwa (tested on 0.7.13-r1126)
> - snpEff (tested on v5.1f)
> - samtools (tested on v1.9)

It won't work with much earlier versions of GATK for example, so I reccomend installing these versions 

For local installations of java I reccommend: https://pypi.org/project/install-jdk/


## Citations

BWA:  
Li H. and Durbin R. (2009) Fast and accurate short read alignment with Burrows-Wheeler Transform. Bioinformatics, 25:1754-60. [PMID: 19451168]  

SnpEff:    
"A program for annotating and predicting the effects of single nucleotide polymorphisms, SnpEff: SNPs in the genome of Drosophila melanogaster strain w1118; iso-2; iso-3.", Cingolani P, Platts A, Wang le L, Coon M, Nguyen T, Wang L, Land SJ, Lu X, Ruden DM. Fly (Austin). 2012 Apr-Jun;6(2):80-92. PMID: 22728672  

BioPython:    
Cock PA, Antao T, Chang JT, Chapman BA, Cox CJ, Dalke A, Friedberg I, Hamelryck T, Kauff F, Wilczynski B and de Hoon MJL (2009) Biopython: freely available Python tools for computational molecular biology and bioinformatics. Bioinformatics, 25, 1422-1423  

GATK:    
McKenna A, Hanna M, Banks E, Sivachenko A, Cibulskis K, Kernytsky A, Garimella K, Altshuler D, Gabriel S, Daly M, DePristo MA. (2010). The Genome Analysis Toolkit: a MapReduce framework for analyzing next-generation DNA sequencing data. Genome Res, 20:1297-303. DOI: 10.1101/gr.107524.110.  

You may also include the following for GATK:    
DePristo M, Banks E, Poplin R, Garimella K, Maguire J, Hartl C, Philippakis A, del Angel G, Rivas MA, Hanna M, McKenna A, Fennell T, Kernytsky A, Sivachenko A, Cibulskis K, Gabriel S, Altshuler D, Daly M. (2011). A framework for variation discovery and genotyping using next-generation DNA sequencing data. Nat Genet, 43:491-498. DOI: 10.1038/ng.806.  

Poplin R, Ruano-Rubio V, DePristo MA, Fennell TJ, Carneiro MO, Van der Auwera GA, Kling DE, Gauthier LD, Levy-Moonshine A, Roazen D, Shakir K, Thibault J, Chandran S, Whelan C, Lek M, Gabriel S, Daly MJ, Neale B, MacArthur DG, Banks E. (2017). Scaling accurate genetic variant discovery to tens of thousands of samples bioRxiv, 201178. DOI: 10.1101/201178  

Van der Auwera GA & O'Connor BD. (2020). Genomics in the Cloud: Using Docker, GATK, and WDL in Terra (1st Edition). O'Reilly Media.  
PROKKA:    
Seemann T. Prokka: rapid prokaryotic genome annotation, Bioinformatics 2014 Jul 15;30(14):2068-9. PMID:24642063




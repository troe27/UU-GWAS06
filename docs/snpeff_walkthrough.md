# 2.1 Annotating a VCF
The Goal of this exercise is to familiarise yourself with a common annotation tool, and learn how to interpret the results.


for this exercise, we are going to annotate a ```.vcf```.
It was created by subsetting a larger (184GB) Database-style ```.vcf```, [the Single Nucleotide Polymorphism Database (dbSNP)](https://www.ncbi.nlm.nih.gov/books/NBK21088/), which you can [download from the NCBI ftp-server](https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/).
The file we are working with is much smaller and contains variants from a small subsection of the human chromosome 22.

For annotating these variants, we will be using [SnpEff](http://pcingola.github.io/SnpEff/) by [Cingolani et al (2012)](http://pcingola.github.io/SnpEff/adds/SnpEff_paper.pdf).
We will be working on Rackham for this, where SnpEff is installed as a module.

- log into rackham, start an interactive session with the reservation code ```reservation code```
- load the modules ```bioinfo-tools``` and ```snpEff/4.3t```
- copy the file ```/path/to/20220425_chr22_targetregion.recode_diff_chrname.vcf``` to your working directory.


SnpEff works by comparing the positions of these SNPs against a database of genes, ORFs and other genome annotations to estimate the function and impact of individual SNPs.
Many databases e.g. for humans and model organisms (and an update mechanism) are built into snpEff, so we do not have to [make them ourselves](http://pcingola.github.io/SnpEff/se_buildingdb/), though it is possible to do so from a ```.gff``` file.
You can have a look at the list of databases using ```snpEff databases```. Be warned, its a long list!

It is important however, to match the reference genome your ```.vcf``` was based on, to a database based on the same reference. This information is stored in the ```.vcf``` file.  
- Can you tell which reference our ```.vcf```file was built on? if you are unsure where to look, remember the [VCFv4.2 fileformat specifications](https://samtools.github.io/hts-specs/VCFv4.2.pdf).
    - _You can find this information in the header of the ```.vcf```file, on line 5. The reference used was [**GRch38.p13**](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.39/)_
    ```bash
    head -10 /path/to/20220425_chr22_targetregion.recode_diff_chrname.vcf
    ```

    >```
    >##fileformat=VCFv4.2
    >##fileDate=20210513
    >##source=dbSNP
    >##dbSNP_BUILD_ID=155
    >##reference=GRCh38.p13
    >##phasing=partial
    >##INFO=<ID=RS,Number=1,Type=Integer,Description="dbSNP ID (i.e. rs number)">
    >##INFO=<ID=GENEINFO,Number=1,Type=String,Description="Pairs each of gene symbol:gene id.  The gene symbol and id are delimited by a colon (:) and each pair is delimited by a vertical bar (|).  Does not include pseudogenes.">
    >##INFO=<ID=PSEUDOGENEINFO,Number=1,Type=String,Description="Pairs each of pseudogene symbol:gene id.  The pseudogene symbol and id are delimited by a colon (:) and each pair is delimited by a vertical bar (|)">
    >##INFO=<ID=dbSNPBuildID,Number=1,Type=Integer,Description="First dbSNP Build for RS">
    ```

we will be using the ```eff ``` command within snpEff to annotate our ```.vcf```-file and generate a ```.html``` report:

```bash
snpEff eff GRCh38.86 file.vcf  > file.ann.vcf
```

this will take a minute or two.
- have a look at the summary file using firefox. If you do not have X11 forwarding enabled, or lack a X11 backend on your computer, you'll have to download the file.
  - how many of the SNPs are in the exonic regions?  
    - _751_
  - how many variants result in a new stop-codon?  
    - _22_
  - what is the Ts/Tv ratio?
    -  _The [ratio of transitions to transversions](https://en.wikipedia.org/wiki/Point_mutation#Transition/transversion_categorization)_
  - why are are the plot for the quality histogram and allele-frequency empty?
    - _because the VCF file only contains the variants, no samples._
  - what is the most common amino-acid change?
    - _leucine to phenylalanin, with 14 occurences._
  - how many times was the **GAG** codon mutated to **AAG** ?  
    - _this codon change happened 3 times._
  - how many times was the **TTG** codon mutated to **GTG**?
      - _this codon change also happened 3 times._
  - which of these two point mutations will likely have a larger impact on the protein structure?
    - _the first mutation will on average have a stronger impact on protein structure, as it represents a change from Glutamic Acid to Lysine, which changes the sidechange charge from negative to positive. in contrast, the second point mutation results in a change from leucine to valine, which are very similar and both have hydrophobic sidechains._

Annotations for each individual variant will be stored in the newly created ```.vcf``` file.

- have a look at the ```.vcf``` file.
  - Can you find the annotation fields?
  - what is the prediction for variants  ```rs1459497417``` , ```rs1194205126```, ```rs74315486``` and ``` rs758790937 ``` ?
    - rs1459497417:
```
ANN=T|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_32-A_95:ENST00000354760|protein_coding|4/6|c.283C>T||||||,T|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_55-A_95:ENST00000354760|protein_coding|4/6|c.283C>T||||||,T|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|4/6|c.283C>T|p.Arg95Trp|318/811|283/591|95/196||,T|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|3/5|n.180C>T||||||
```

    - rs1194205126:
```
ANN=A|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_150-A_192:ENST00000354760|protein_coding|6/6|c.449T>A||||||,A|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|6/6|c.449T>A|p.Val150Asp|484/811|449/591|150/196||,A|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|5/5|n.346T>A||||||
```
    - rs74315486:
```
ANN=C|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_33-A_94:ENST00000354760|protein_coding|4/6|c.281T>C||||||,C|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|4/6|c.281T>C|p.Phe94Ser|316/811|281/591|94/196||,C|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|3/5|n.178T>C||||||
```
    - rs758790937:
```
	ANN=A|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_150-A_192:ENST00000354760|protein_coding|6/6|c.575G>A||||||,C|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_150-A_192:ENST00000354760|protein_coding|6/6|c.575G>C||||||,T|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_150-A_192:ENST00000354760|protein_coding|6/6|c.575G>T||||||,A|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_70-A_192:ENST00000354760|protein_coding|6/6|c.575G>A||||||,C|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_70-A_192:ENST00000354760|protein_coding|6/6|c.575G>C||||||,T|structural_interaction_variant|HIGH|CRYBA4|ENSG00000196431|interaction|3LWK:A_70-A_192:ENST00000354760|protein_coding|6/6|c.575G>T||||||,A|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|6/6|c.575G>A|p.Arg192His|610/811|575/591|192/196||,C|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|6/6|c.575G>C|p.Arg192Pro|610/811|575/591|192/196||,T|missense_variant|MODERATE|CRYBA4|ENSG00000196431|transcript|ENST00000354760.3|protein_coding|6/6|c.575G>T|p.Arg192Leu|610/811|575/591|192/196||,A|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|5/5|n.472G>A||||||,C|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|5/5|n.472G>C||||||,T|non_coding_transcript_exon_variant|MODIFIER|CRYBA4|ENSG00000196431|transcript|ENST00000466315.1|processed_transcript|5/5|n.472G>T||||||
```

  - is this in line with the predictions from Wang et al?
    - _yes! while Wang et al. use different software to predict different features for these variants, they are largely in line with the annotation of snpEff. for example, the preservation times  predicted by PANTHER_PSEP are quite high, indicating a high level of conservation - usually a sign that variants here are deleterious. Similar, both PhD-SNP and polyphen 2.0 predict pathogenicity of disease causing effects for these variants.
    this is in line with the "HIGH" or "MODERATE" impact predicted by snpEff and the finding that all of these are exonic variants that result in amino-acid changes._

for the subsequent analysis, we are only interested in the variants that have a "HIGH" or "MODERATE" predicted effect.

- extract these variants and put them in separate files. this will help us later when investigating these variants in the UCSC genome browser.
```bash
grep "#" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf > annot_mod.vcf && grep "MODERATE" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf >> annot_mod.vcf
grep "#" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf > annot_high.vcf && grep "HIGH" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf >> annot_high.vcf
```

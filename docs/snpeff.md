# 2.1 Annotating a VCF
The Goal of this exercise is to familiarise yourself with a common annotation tool, and learn how to interpret the results.


for this exercise, we are going to annotate a ```.vcf```.
It was created by subsetting a larger (184GB) Database-style ```.vcf```, [the Single Nucleotide Polymorphism Database (dbSNP)](https://www.ncbi.nlm.nih.gov/books/NBK21088/), which you can [download from the NCBI ftp-server](https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/).
The file we are working with is much smaller and contains variants from a small subsection of the human chromosome 22.

For annotating these variants, we will be using [SnpEff](http://pcingola.github.io/SnpEff/) by [Cingolani et al (2012)](http://pcingola.github.io/SnpEff/adds/SnpEff_paper.pdf).
We will be working on Rackham for this, where SnpEff is installed as a module.

- log into rackham, start an interactive session with the reservation code ```reservation code```
- load the modules ```bioinfo-tools``` and ```snpEff/4.3t```
- copy the file ```/proj/g2020004/private/computer_practicals/GWAS06/20220425_chr22_targetregion.recode_diff_chrname.vcf``` to your working directory.


SnpEff works by comparing the positions of these SNPs against a database of genes, ORFs and other genome annotations to estimate the function and impact of individual SNPs.
Many databases e.g. for humans and model organisms (and an update mechanism) are built into snpEff, so we do not have to [make them ourselves](http://pcingola.github.io/SnpEff/se_buildingdb/), though it is possible to do so from a ```.gff``` file.
You can have a look at the list of databases using ```snpEff databases```. Be warned, its a long list!

It is important however, to match the reference genome your ```.vcf``` was based on, to a database based on the same reference. This information is stored in the ```.vcf``` file.
- Can you tell which reference our ```.vcf```file was built on? if you are unsure where to look, remember the [VCFv4.2 fileformat specifications](https://samtools.github.io/hts-specs/VCFv4.2.pdf).

we will be using the ```eff ``` command within snpEff to annotate our ```.vcf```-file and generate a ```.html``` report:

```bash
snpEff eff GRCh38.86 file.vcf  > file.ann.vcf
```

this will take a minute or two.
- have a look at the summary file using firefox. If you do not have X11 forwarding enabled, or lack a X11 backend on your computer, you'll have to download the file.
  - how many of the SNPs are in the exonic regions?
  - how many variants result in a new stop-codon?
  - what is the Ts/Tv ratio?
  - why are are the plot for the quality histogram and allele-frequency empty?
  - what is the most common amino-acid change?
  - how many times was the **GAG** codon mutated to **AAG** ?
  - how many times was the **TTG** codon mutated to **GTG**?
  - which of these two point mutations will likely have a larger impact on the protein structure? [hint](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amino_Acids.svg/831px-Amino_Acids.svg.png)



Annotations for each individual variant will be stored in the newly created ```.vcf``` file.

- With that in mind, have a look at the ```.vcf``` file.
  - Can you find the annotation fields?
  - what is the prediction for variants  ```rs1459497417``` , ```rs1194205126```, ```rs74315486``` and ``` rs758790937 ``` ?
  - is this in line with the predictions from Wang et al?

for the subsequent analysis, we are only interested in the variants that have a "HIGH" or "MODERATE" predicted effect.

- extract these variants and put them in separate files. this will help us later when investigating these variants in the UCSC genome browser.
```bash
grep "#" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf > annot_mod.vcf && grep "MODERATE" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf >> annot_mod.vcf
grep "#" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf > annot_high.vcf && grep "HIGH" 20220425_chr22_targetregion.recode_diff_chrname.ann.vcf >> annot_high.vcf
```

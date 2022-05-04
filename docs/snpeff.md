# 2.1 Annotating a VCF

for this exercise, we are going to annotate a ```.vcf``` using [SnpEff](http://pcingola.github.io/SnpEff/adds/SnpEff_paper.pdf).
We will be working on Rackham for this.
- log into rackham, start an interactive session with the reservation code ```reservation code```
- load the modules ```bioinfo-tools``` and ```snpEff/4.3t```
- copy the file ```/path/to/20220425_chr22_targetregion.recode_diff_chrname.vcf``` to your working directory.

The VCF contains clinical variants from a small subsection of the human chromosome 22.
SnpEff works by comparing the positions of these SNPs against a database of genes, ORFs and other genome annotations to estimate the function and impact of individual SNPs.
Many databases e.g. for humans and model organisms (and an update mechanism) are built into snpEff, so we do not have to [make them ourselves](http://pcingola.github.io/SnpEff/se_buildingdb/), though it is possible to do so from a ```.gff``` file.
You can have a look at the list of databases using ```snpEff databases```. Be warned, its a long list!

It is important however, to match the reference genome your ```.vcf``` was based on, to a database based on the same reference. This information is stored in the VCF-header.
- Can you tell which reference our ```.vcf```file was built on?

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
  - what is the most common amino-acid change, and how many times was the **ACA** codon mutated to **ACT**?

Annotations for each individual variant will be stored in the newly created ```.vcf``` file.

- have a look at the ```.vcf``` file
- what is the prediction for variants  ```rs1459497417``` , ```rs1194205126```, ```rs100002124``` and ``` rs758790937 ``` ?
- is this in line with the predictions from Wang et al?

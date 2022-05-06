wget https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/GCF_000001405.39.gz

bunzip2  GCF_000001405.39.gz # probably not necessary

vcftools \
            --vcf GCF_000001405.39 \
            --chr NC_000022.11 \
            --to-bp 26635672 \
            --out 20220425_chr22_targetregion \
            --recode \
            --from-bp 26602982


sed "s:NC_000022\.11:22:g"  data/20220425_chr22_targetregion.recode.vcf > data/20220425_chr22_targetregion.recode_diff_chrname.vcf


# UNDER CONSTRUCTION


# Table of Contents

# Learning Goals
## Requirements for completion

# Introduction & Overview
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
## Dataset & Condition
## Methodology
### Scope and limitations of the bioinformatics approach



# 1: Choosing a gene
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
#### 1.1: is the gene relevant for the disease?
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
[OMIM](https://www.omim.org/entry/123631?search=CRYBA4&highlight=cryba4)

</p>
</details>


<br>
<br>

<details><summary>hint</summary>
<p>


![test_figure](figures/test_figure1.png)

</p>
</details>


<br>
<br>

#### 1.2: Where and when is the gene expressed?


#### 1.3: Does the loss of function animal model have a phenotype?

#### 1.4: is the three-dimensional structure resolved?

### code section
```R
pow.calc <- function(n, rsquare, maf, beta){
  ncp <- n*rsquare*2*maf*(1-maf)*beta*beta
  return(ncp)
}
```

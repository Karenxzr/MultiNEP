# MultiNEP: a Multi-omics Network Enhancement framework for Prioritizing disease genes and metabolites

<img width="898" alt="image" src="https://user-images.githubusercontent.com/27308407/206234973-b4c3a6b0-0bce-48a7-ac79-8bb2f74fbcbb.png">

MultiNEP is an improved analytical tool to prioritize disease-associated genes and metabolites simultanuously using multi-omics network with the ability to handle network imbalance. Multinep first reweight a general multi-omics network $S^0$ from database and a multi-omics similarity matrix $E$ based on disease profiles into $\tilde{S^0}$ and $\tilde{E}$ using weighting parameters $\lambda_g$ and $\lambda_m$. Then using reweighted $\tilde{E}$ to enhance reweighted $\tilde{S^0}$ into a disease-specific network $S_E$. At last, update initial disease-association gene and metabolite scores by diffusing on the enhanced and denoised multi-omics network $S_E$, and prioritize candidate disease-associated genes and metabolites simultanuously using updated disease-association gene and metabolite scores. 

## Installation

- The R package of MultiNEP can be installed through:<br />
`if (!requireNamespace("devtools", quietly = TRUE))` <br />
`install.packages("devtools")`<br />
`library("devtools")`<br />
`install_github("Karenxzr/MultiNEP")`

## Usage

It is quite simple to run MultiNEP through a wrapper function of `nep`. 
Input required:
- General network `s0`: an $n \times n$ matrix. With rownames and colnames being set as gene/metabolite names.
- Disease similarity matrix `E`: an $n \times n$ matrix. With rownames and colnames being set as gene/metabolite names. Note, all values in E should range from 0 - 1.
- Initial disease association scores `signal`: a dataframe with the first column being feature names, the second column being initial association scores. Input p-values as default association scores.
- Feature name list `feature_name_list`: a list with the first element containing all gene names and the second containing all metabolite names. 

You can find sample input data within pacakge or in the `data` folder. See an application example as below:

`library(MultiNEP)` <br />
`results = nep(s0=s0,E=E,signals=signal,feature_name_list = feature_name_list, model='multinep')` <br />

Run `results$vec` to get prioritized candidate disease-associated multi-omics features. If you want to get re-weighted and enhanced disease-specific multi-omics network $S_E$, run `results$enhanced_mat$unprocessed` or `results$enhanced_mat$processed` with `return_mat` argument set as TRUE.  <br />

You can also change parameters such as $\lambda_g$ or $\lambda_m$. Run `?nep` to find more details.

## Reference
- Xu Z, Lee B, Marchionni L, Wang S. MultiNEP: a Multi-omics Network Enhancement framework for Prioritizing disease genes and metabolites. 
- Ruan P, Wang S. DiSNEP: a Disease-Specific gene Network Enhancement to improve Prioritizing candidate disease genes. Brief Bioinform. 2021 Jul 20;22(4):bbaa241. doi: 10.1093/bib/bbaa241. PMID: 33064143.


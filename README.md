# MultiNEP: disease-specific Multi-omics Network Enhancement for Prioritizing disease genes and metabolites

<img width="898" alt="image" src="https://user-images.githubusercontent.com/27308407/206234973-b4c3a6b0-0bce-48a7-ac79-8bb2f74fbcbb.png">

MultiNEP is an improved analytical tool to prioritize disease-associated genes and metabolites simultanuously using multi-omics network with the ability to handle network imbalance. Multinep first reweight a general multi-omics network $S^0$ from database and a multi-omics similarity matrix $E$ based on disease profiles into $\tilde{S^0}$ and $\tilde{E}$ using weighting parameters $\lambda_g$ and $\lambda_m$. Then using reweighted $\tilde{E}$ to enhance reweighted $\tilde{S^0}$ into a disease-specific network $S_E$. At last, update initial disease-association gene and metabolite scores by diffusing on the enhanced and denoised multi-omics network $S_E$, and prioritize candidate disease-associated genes and metabolites simultanuously using updated disease-association gene and metabolite scores. 

## Installation

- The R package of MultiNEP can be installed through:<br />
`if (!requireNamespace("devtools", quietly = TRUE))` <br />
`install.packages("devtools")`<br />
`library("devtools")`<br />
`install_github("Karenxzr/MultiNEP")`

## Usage

It is quite simple to run MultiNEP through a wrapper function of `nep`, see example below:

`library(MultiNEP)` <br />
`results = nep(s0=s0,E=E,signals=signal,feature_name_list = feature_name_list, model='multinep')` <br />

You can also change parameters such as $\lambda_g$ or $\lambda_m$. Run `?nep` to find more details.

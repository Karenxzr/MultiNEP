# MultiNEP: disease-specific Multi-omics Network Enhancement for Prioritizing disease genes and metabolites
<img width="800" height="400" alt="image" src="https://user-images.githubusercontent.com/27308407/200651148-300d4cdb-9029-46db-b312-f23b054955c4.png">

MultiNEP is an improved analytical tool to prioritize disease-associated genes and metabolites simultanuously using multi-omics network with the ability to handle network imbalance. Multinep first reweight a general multi-omics network $S^0$ from database and a multi-omics similarity matrix $E$ based on disease multi-omics profiles using $\lambda_g$ and $\lambda_m$. Then using reweighted disease multi-omics similarity matrix to enhance reweighted general network into disease-specific network. At last, update initial disease-association gene and metabolite scores by diffusing on the enhanced and denoised multi-omics network $S_E$, and prioritize disease signal genes and metabolites simultanuously using updated disease-association gene and metabolite scores. 


## Installation

- The R package of MultiNEP can be installed through:<br />
if (!requireNamespace("devtools", quietly = TRUE)) <br />
install.packages("devtools")<br />
library("devtools")<br />
install_github("Karenxzr/MultiNEP")

## Usage

It is quite simple to run MultiNEP through a wrapper function of `nep`, see example below:

library(MultiNEP) <br />
results = nep(s0=s0,E=E,signals=signal,feature_name_list = feature_name_list, model='multinep') <br />

You can also change parameters such as $\lambda_g$ or $\lambda_m$. Run `?nep` to find more details.

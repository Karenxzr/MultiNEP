multinep = function(s0,E,signals,signal_type = 'pvalue',feature_name_list,
                    post_process_percent=c(0.95,0.7,0.85),lambda_g=0.05,lambda_m=20,
                    alpha=0.75,beta=0.75,iter=30,difference=1e-6,
                    return_mat = T,parallel=F,nworker=4){
  require(dplyr)
  if (is.null(E)){#no enhancement
    se = s0
    se_=post_process(se,percent=post_process_percent,feature_name_list=feature_name_list)
  }else{#use disease profiles to enhance general network
    se = diffuse_matrix(s0,E,alpha=alpha,iter=iter,difference=difference,heter_diffuse = T,
                        heter_param = list(feature_name_list=feature_name_list,lambda_g=lambda_g,lambda_m=lambda_m),
                        parallel=parallel, nworker=nworker)
    se_=post_process(se,percent=post_process_percent,feature_name_list=feature_name_list)
  }
  
  vec = diffuse_vec(signals,se_,type=signal_type,beta=beta,iter=iter,difference=difference)
  enhanced_mat=list(unprocessed = se,processed = se_)
  if (return_mat==T){
    return(list(vec=vec,enhanced_mat=enhanced_mat))
  }else{return(list(vec = vec))}
}

disnep = function(s0,E,signals,signal_type = 'pvalue',post_process_percent=0.9,
                  alpha=0.75,beta=0.75,iter=30,difference=1e-6,
                  return_mat=T,feature_name_list=NULL,parallel=F,nworker=4){
  if (is.null(E)){
    se = s0
    se_=post_process(se,percent=post_process_percent,feature_name_list=feature_name_list)
  } else {
    se = diffuse_matrix(s0,E,alpha=alpha,iter=iter,difference=difference,heter_diffuse = F,
                        parallel=parallel,nworker=nworker)
    se_=post_process(se,percent=post_process_percent,feature_name_list=feature_name_list)
  }
  vec = diffuse_vec(signals,se_,type=signal_type,beta=beta,iter=iter,difference=difference)
  enhanced_mat=list(unprocessed = se,processed = se_)
  if (return_mat==T){
    return(list(vec=vec,enhanced_mat=enhanced_mat))
  }else{return(list(vec = vec))}
}

nep = function(s0,E,signals,signal_type = 'pvalue',alpha=0.75,beta=0.75,
               feature_name_list,post_process_percent=c(0.95,0.7,0.85),
               iter=30,difference=1e-6,return_mat=T,lambda_g=0.05,lambda_m=20,
               model = 'multinep',parallel=F,nworker=4){
  
  #' Wrapper function to perform network enhancement and prioritize using MultiNEP or DiSNEP
  #'
  #' @param s0 matrix of the general network
  #' @param E disease similarity matrix
  #' @param signals dataframe of initial disease-association signal scores, first column is gene/metabolite names, second column is initial scores
  #' @param signal_type choose from "pvalue" (default) or "score"
  #' @param alpha default value is 0.75 to control the degree to use disease omics profiles for enhancement
  #' @param beta default value is 0.75 to control the degree to use enhanced network to update signals
  #' @param feature_name_list list for omics feature names, should be length of 2
  #' @param post_process_percent a vector of thresholds for post-processing enhanced disease-specific matrix. Should be in order of: c(gene network, metabolite network, gene-metabolite network)
  #' @param iter iteration number, default as 30
  #' @param difference iteration stop criteria
  #' @param return_mat if TRUE, return a list for enhanced networks before and after postprocessing
  #' @param lambda_g value to downweight gene-gene network to gene-metabolite network
  #' @param lambda_m value to upweight metabolite-metabolite network to gene-metabolite network
  #' @param model choose from 'multinep' and 'disnep'
  #' @param parallel whether opt for parallel computing
  #' @param nworker if opt for parallel computing, how many works to use
  #' @return result list with the first element being prioritized signals, the second is a list of enhanced networks if set return_mat as TRUE
  #' @examples
  #' nep(s0,E,signals,signal_type = 'pvalue',feature_name_list=list(gene_names,metabolite_names),
  #' post_process_percent=c(0.95,0.7,0.85),lambda_g=0.05,lambda_m=20,model = 'multinep')
  #' @export
  if (model=='multinep'){
    res = multinep(s0,E,signals,signal_type,feature_name_list,post_process_percent,
                   lambda_g,lambda_m,alpha,beta,iter,difference,return_mat,parallel,nworker)
  }else if (model=='disnep'){
    res = disnep(s0,E,signals,signal_type,post_process_percent=post_process_percent,
                 alpha=alpha,beta=beta,iter=iter,difference=difference,return_mat=return_mat,
                 feature_name_list=feature_name_list,parallel,nworker)
  }else{print('choose mode from multinep and disnep')}
  return(res)
}

diffuse_matrix=function(s0,E,alpha=0.75,iter=30,difference=1e-6,
                        heter_diffuse = F,
                        heter_param = list(feature_name_list=NULL,lambda_g=0.05,lambda_m=20),
                        parallel=F, nworker=4){
 
  #preprocess
  mat_list = mat_intersect(s0,E)
  s0 = mat_list[[1]];E = mat_list[[2]]
  diag(E) = 0;diag(s0) = 0
  
  if (heter_diffuse==T){#heternep
    s0=mat_block(mat = s0,feature_name_list=heter_param$feature_name_list,
                 weights=c(heter_param$lambda_g,heter_param$lambda_m,1))
    E=mat_norm(mat_block(mat = E,feature_name_list=heter_param$feature_name_list,
                         weights=c(heter_param$lambda_g,heter_param$lambda_m,1)),norm ='col')
    }else{E=mat_norm(E,norm ='col')} #disnep
  
  #initialize
  snet_1=s0
  snet=snet_1
  
  #diffusion on adjacency matrix
  print('start diffusion:')
  for(kk in 1:iter){
    if (parallel==T){
      snet_1<-alpha*matprod.par(E,snet,nworker = nworker )+(1-alpha)*(s0)
    }else{
      snet_1<-alpha*eigenMapMatMult(E,snet)+(1-alpha)*(s0) 
    }
    diff=max(abs(snet_1-snet))
    print(paste0("iteration",kk," difference: ",diff))
    if(diff<difference){return(snet_1)}
    snet=snet_1
  }
  return(snet_1)
}



#matrix multiplication in parallel
matprod.par <- function(A, B,nworker=4,rcpp=T){
  cl=makePSOCKcluster(nworker)
  if (ncol(A) != nrow(B)) stop("Matrices do not conforme")
  idx   <- splitIndices(nrow(A), nworker)
  Alist <- lapply(idx, function(ii) A[ii,,drop=FALSE])
  if (rcpp){
    ans   <- clusterApply(cl, Alist, get('eigenMapMatMult'), B)
  }else{ans   <- clusterApply(cl, Alist, get('%*%'), B)}
  return(do.call(rbind, ans))
  stopCluster(cl)
}


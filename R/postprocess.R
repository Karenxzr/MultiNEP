

#post process for a single network
post_process_disnep = function (mat, percent = 0.9,feature_name_list=NULL) {
  diag(mat) = 0
  q = quantile(mat, percent)
  mat[mat <= q] = 0
  mat[mat > q] = 1
  mat = (mat + t(mat))/2
  mat[mat == 0.5] = 1
  return(mat)
}

#make mat symmatric 
post_process_sym = function(mat){
  diag(mat)=0
  mat = (mat+t(mat))/2
  return(mat) 
}



post_process = function(mat,feature_name_list,percent=0.9){
  if (length(percent)==1){percent=rep(percent,3)}
  
    mat = post_process_sym(mat) 
    mat[feature_name_list[[1]],feature_name_list[[1]]] = post_process_disnep(mat[feature_name_list[[1]],feature_name_list[[1]]],percent = percent[1])
    mat[feature_name_list[[2]],feature_name_list[[2]]] = post_process_disnep(mat[feature_name_list[[2]],feature_name_list[[2]]],percent = percent[2])
    m=mat[feature_name_list[[2]],feature_name_list[[1]]]
    q = quantile(m, percent[3])
    m[m <= q] = 0
    m[m > q] = 1
    mat[feature_name_list[[2]],feature_name_list[[1]]]=m
    mat[feature_name_list[[1]],feature_name_list[[2]]]=t(m)

  return(mat)
}



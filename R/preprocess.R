#####----matrix normalization----#####
mat_norm=function(mat,norm){
  mat=mat+.Machine$double.eps
  dcol=sqrt(colSums(mat))
  drow=sqrt(rowSums(mat))
  if(norm=='colrow'){
    mat=t(t(mat)/dcol)/drow
  }
  if(norm=='col'){
    dcol=colSums(mat)
    mat=t(t(mat)/dcol)}
  if(norm=='row'){
    dcol=colSums(mat)
    mat=t(mat)/dcol
  }
  return(mat)
}


#####----matrix blocking----#####
mat_block=function(mat,feature_name_list,weights = c(1,1,1)){
  
  m=length(feature_name_list[[1]])
  n=length(feature_name_list[[2]])
  
  #reorder mat 
  index = unlist(feature_name_list)
  mat=mat[index,index]
  
  
  mat[1:m,1:m]= weights[1]*mat[1:m,1:m]
  mat[(m+1):(m+n),(m+1):(m+n)]=weights[2]*mat[(m+1):(m+n),(m+1):(m+n)]
  
  mat[(m+1):(m+n),1:m]=weights[3]*mat[(m+1):(m+n),1:m]
  mat[1:m,(m+1):(m+n)]=weights[3]*mat[1:m,(m+1):(m+n)]
  
  
  return(mat)
}



##############mat intersect################
mat_intersect = function(mat1,mat2){
  
  features=intersect(rownames(mat1),rownames(mat2))
  
  mat1 = mat1[features,features]
  mat2 = mat2[features,features]
  
  return(list(mat1,mat2))
}



diffuse_vec=function(signals,snet,type='pvalue',beta=0.75,iter=30,difference=1e-6){
  require(SMUT)
  #pre-precoss association signals
  if (type=="pvalue"){
    signals[,2]=qnorm(signals[,2]/2,lower.tail = F)
    colnames(signals)=c("feature","score")
  }else{
    colnames(signals)=c("feature","score")
  }
  
  ###heter diffuse
  print('Diffuse Scores')
  index=intersect(rownames(snet),signals[,1])
  snet = snet[index,index]
  signals=signals[match(index,signals[,1]),]
  snet=mat_norm(snet,'col')
  
  #diffusion
  #intialize
  p=as.matrix(signals$score)
  p1=p
  j=1
  
  #diffusion on network
  repeat{
    
    p=p1
    p1<-beta*eigenMapMatMult(snet,p)+(1-beta)*(signals$score)
    p_diff=sum(abs(p1-p))
    j=j+1
    
    if (j>iter){break}
    if (p_diff<difference) {break}
    
  }
    res=data.frame(feature=signals$feature,score=p1)
    res=res[order(res$score,decreasing = T),]
    
  return(res)
}

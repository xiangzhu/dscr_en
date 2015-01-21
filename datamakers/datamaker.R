#define your datamaker functions in .R files in the datamaker subdirectory
#each datamaker should take input seed (integer) and args (list), and output a list with names elements meta and input
#the format of the meta and input elements should be defined in the README
#
datamaker = function(seed,args){

  set.seed(seed)
  
  #here insert the meat of the function that needs to be defined for each dsc to be done
  #Your function should define the variables meta (a list) and input (a list)

  Ntrain = args$Ntrain # training sample size
  Ntestt = args$Ntestt # test sample size
  Nvalid = args$Nvalid # validation sample size
  design = args$design # design matrix type
  resstd = args$resstd # residual std (sigma) 
  mybeta = args$mybeta # true coefficient (beta)

  N = Ntrain + Ntestt + Nvalid
  p = length(mybeta)

  # 1. generate design matrix  
  if(design=="deccorr"){
	library(MASS)
	Sigma = 0.5^abs(outer(1:p, 1:p, FUN = "-"))	
	X = mvrnorm(n=N, rep(0, p), Sigma)
  }
  if(design=="eqlcorr"){
	library(MASS)
	Sigma = matrix(data=0.5, nrow=p, ncol=p)
	diag(Sigma) = 1
	X = mvrnorm(n=N, rep(0, p), Sigma)
  }
  if(design=="grouped"){
	X = matrix(data=0, nrow=N, ncol=p)
	q = round(p/4)
	Z = rnorm(3, mean=0, sd=1)
	E = matrix(data=rnorm(N*p, mean=0, sd=0.01), nrow=N, ncol=p)
	X[, 1:q] = Z[1] + E[, 1:q]
	X[, (q+1):(2*q)] = Z[2] + E[, (q+1):(2*q)]
	X[, (2*q+1):(3*q)] = Z[3] + E[, (2*q+1):(3*q)]
	X[, (3*q+1):p] = E[, (3*q+1):p]
	rm(E)   
  }

  # 2. generate response vector
  epsilon = rnorm(N, mean=0, sd=resstd)  
  Y = X %*% mybeta + epsilon

  # 3. split sample into train/test/validation set
  Xtrain = X[1:Ntrain, ]
  Xtestt = X[(Ntrain+1):(Ntrain+Ntestt), ]
  Xvalid = X[(Ntrain+Ntestt+1):N, ]

  Ytrain = Y[1:Ntrain]
  Ytestt = Y[(Ntrain+1):(Ntrain+Ntestt)]
  Yvalid = Y[(Ntrain+Ntestt+1):N] 

  # 4. aggregate output args
  meta = list(Xtestt=Xtestt, Ytestt=Ytestt, mybeta=mybeta)
  input = list(Xtrain=Xtrain, Ytrain=Ytrain, Xvalid=Xvalid, Yvalid=Yvalid)
 
  #end of meat of function
  
  data = list(meta=meta,input=input)
  
  return(data)

}

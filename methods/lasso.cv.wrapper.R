#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

lasso.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Mytune = args$Mytune
 
  p = dim(Xtrain)[2]
  Myiter = length(seq(1, p, 0.05));
 
  # decide tuning parameter
  lambda = 0;
  valid_mse = matrix(0, nrow=1, ncol=Myiter)
  
    # K-fold CV
      Xmerge = rbind(Xvalid, Xtrain)
      Ymerge = c(Yvalid, Ytrain)
      cvobj = cv.enet(Xmerge, Ymerge, K=Mytune, lambda, s=seq(1,1+(Myiter-1)*0.05,length=Myiter), mode="step", plot.it=FALSE, se=FALSE)
      optimS = (which.min(cvobj$cv)-1)*0.05+1
    
  # fit the model on training set
  myobj = enet(Xtrain, Ytrain, lambda)
  
  # output prediction function and point estimate
  predict <- function(Xnew){
    predict.enet(myobj, Xnew, s=optimS, type="fit", mode="step", naive=FALSE)
  }
  
  coefest = predict.enet(myobj, s=optimS, type="coef", mode="step", naive=FALSE)$coefficients 

  return(list(predict=predict, coefest=coefest))
}

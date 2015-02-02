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
  
    # the method used in Zou and Hastie (2005)
      testobj = enet(Xtrain, Ytrain, lambda)
      for(j in 1:Myiter){
        tuning = 1+(j-1)*0.05
        Yvalid_fitted = predict.enet(testobj, Xvalid, s=tuning, type="fit", mode="step")$fit
        valid_mse[j] = mean((Yvalid_fitted-Yvalid)^2)
      }
    optimS = (which(valid_mse == min(valid_mse), arr.ind = TRUE)[2]-1)*0.05+1
      
  # fit the model on training set
  myobj = enet(Xtrain, Ytrain, lambda)
  
  # output prediction function and point estimate
  predict <- function(Xnew){
    predict.enet(myobj, Xnew, s=optimS, type="fit", mode="step", naive=FALSE)
  }
  
  coefest = predict.enet(myobj, s=optimS, type="coef", mode="step", naive=FALSE)$coefficients 

  return(list(predict=predict, coefest=coefest))
}

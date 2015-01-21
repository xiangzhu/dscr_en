#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

lasso.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Xtestt = input$Xtestt
	
  # 1. select the tuning parameter using the validation set
  lambda = 1	

  # 2. fit the model using the training set 
  myobj = enet(Xtrain, Ytrain, lambda)
  CPath = myobj$Cp
  minCp = which.min(CPath)
  predict = predict.enet(myobj, Xtestt, s=minCp, type="fit", mode="step", naive=FALSE)$fit
  coefest = predict.enet(myobj, s=minCp, type="coef", mode="step", naive=FALSE)$coefficients 

  return(list(predict=predict, coefest=coefest))
}

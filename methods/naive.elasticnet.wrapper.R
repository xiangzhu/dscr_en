#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(elasticnet)

naive.elasticnet.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Xtestt = input$Xtestt
	
  # 1. select the tuning parameter using the validation set
  lambda_list = c(0, 0.01, 0.1, 1, 10, 100)
  num_list = length(lambda_list)
  cvmin_list = rep(0, num_list)
  for (j in 1:num_list){
	cvobj = cv.enet(Xvalid, Yvalid, K=10, lambda_list[j], s=seq(0,1,length=100), mode="fraction", plot.it=FALSE, se=FALSE)
	cvmin_list[j] = min(cvobj$cv)
  }
  lambda = lambda_list[which.min(cvmin_list)]	

  # 2. fit the model using the training set 
  myobj = enet(Xtrain, Ytrain, lambda)
  CPath = myobj$Cp
  minCp = which.min(CPath)
  predict = predict.enet(myobj, Xtestt, s=minCp, type="fit", mode="step", naive=TRUE)$fit
  coefest = predict.enet(myobj, s=minCp, type="coef", mode="step", naive=TRUE)$coefficients 

  return(list(predict=predict, coefest=coefest))
}

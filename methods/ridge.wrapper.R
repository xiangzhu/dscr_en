#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(glmnet)

ridge.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Mytune = args$Mytune
    
  # fit the model on training set
  Xmerge = rbind(Xvalid, Xtrain)
  Ymerge = c(Yvalid, Ytrain)
  myobj = cv.glmnet(Xmerge, Ymerge, family="gaussian", alpha=0, nfolds=Mytune,intercept=FALSE)
  
  # output prediction function and point estimate
  predict.func <- function(Xnew){
    predict(myobj, Xnew, s="lambda.min")
  }
  
  coefest = as.vector(coef(myobj, s="lambda.min")[-1])

  return(list(predict=predict.func, coefest=coefest))
}

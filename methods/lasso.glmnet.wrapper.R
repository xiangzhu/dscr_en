#define your methods in .R files like this one in the methods subdirectory
#each method should take arguments input and args, like the example
#the output should be a list of the appropriate "output" format (defined in the README)
library(glmnet)

lasso.glmnet.wrapper = function(input,args){

  Xvalid = input$Xvalid
  Yvalid = input$Yvalid
  Xtrain = input$Xtrain
  Ytrain = input$Ytrain
  Mytune = args$Mytune
    
  # fit the model on training set
  Xmerge = rbind(Xvalid, Xtrain)
  Ymerge = c(Yvalid, Ytrain)
  myobj = cv.glmnet(Xmerge, Ymerge, alpha=1, nfolds=Mytune, intercept=FALSE)
  
  # output prediction function and point estimate
  predict <- function(Xnew){
    predict(myobj, Xnew, s="lambda.min", type="response")
  }
  
  coefest = coef(myobj, s="lambda.min")

  return(list(predict=predict, coefest=coefest))
}

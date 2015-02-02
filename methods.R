sourceDir("methods")
methods=list()
#now for each method define a list with its name, function and arguments (if no additional arguments use NULL)
# like this: 
#methods[[1]] = list(name="methodname",fn = function,args=NULL)

methods[[1]] = list(name="Lasso", fn=lasso.wrapper, args=list(Mytune=NULL))
methods[[2]] = list(name="ElasticNet", fn=elasticnet.wrapper, args=list(Mytune=NULL))
methods[[3]] = list(name="NaiveElasticNet", fn=naive.elasticnet.wrapper, args=list(Mytune=NULL))

methods[[4]] = list(name="Lasso_10fold", fn=lasso.cv.wrapper, args=list(Mytune=10))
methods[[5]] = list(name="ElasticNet_10fold", fn=elasticnet.cv.wrapper, args=list(Mytune=10))
methods[[6]] = list(name="NaiveElasticNet_10fold", fn=naive.elasticnet.cv.wrapper, args=list(Mytune=10))

#methods[[7]] = list(name="Lasso_10fold_glmnet", fn=lasso.glmnet.wrapper, args=list(Mytune=10))
#methods[[8]] = list(name="ElasticNet_10fold_glmnet", fn=elasticnet.glmnet.wrapper, args=list(Mytune=10))
#methods[[9]] = list(name="Ridge_10fold_glmnet", fn=ridge.wrapper, args=list(Mytune=10))

sourceDir("methods")
methods=list()
#now for each method define a list with its name, function and arguments (if no additional arguments use NULL)
# like this: 
#methods[[1]] = list(name="methodname",fn = function,args=NULL)

methods[[1]] = list(name="Lasso", fn=lasso.wrapper,args=NULL)
methods[[2]] = list(name="ElasticNet", fn=elasticnet.wrapper,args=NULL)
methods[[3]] = list(name="NaiveElasticNet", fn=naive.elasticnet.wrapper,args=NULL)
 

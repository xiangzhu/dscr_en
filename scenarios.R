sourceDir("datamakers")
scenarios=list()

#Now, for each scenario create an element of scenarios of the following form
#scenarios[[1]]=list(name="",fn=,args,seed=1:100)

scenarios[[1]]=list(name="normal",fn=datamaker,args=list(disttype="normal",nsamp=1000),seed=1:100)
scenarios[[2]]=list(name="uniform",fn=datamaker,args=list(disttype="uniform",nsamp=1000),seed=1:100)
scenarios[[3]]=list(name="Cauchy",fn=datamaker,args=list(disttype="Cauchy",nsamp=1000),seed=1:100)
scenarios[[4]]=list(name="t4",fn=datamaker,args=list(disttype="t4",nsamp=1000),seed=1:100)

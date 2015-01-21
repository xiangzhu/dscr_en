sourceDir("datamakers")
scenarios=list()

#Now, for each scenario create an element of scenarios of the following form
#scenarios[[1]]=list(name="",fn=,args,seed=1:100)

beta1 = c(3, 1.5, 0, 0, 2, 0, 0, 0)
args_eg1 = list(Ntrain=20, Ntestt=200, Nvalid=20, design="deccorr", resstd=3, mybeta=beta1)

beta2 = rep(0.85, 8)
args_eg2 = list(Ntrain=20, Ntestt=200, Nvalid=20, design="deccorr", resstd=3, mybeta=beta2)

beta3 = rep(rep(c(0,2), each=10), 2)
args_eg3 = list(Ntrain=100, Ntestt=400, Nvalid=100, design="eqlcorr", resstd=15, mybeta=beta3)

beta4 = c(rep(3, 15), rep(0, 25))
args_eg4 = list(Ntrain=50, Ntestt=400, Nvalid=50, design="grouped", resstd=15, mybeta=beta4)

scenarios[[1]]=list(name="example_1", fn=datamaker, args=args_eg1, seed=1:100)
scenarios[[2]]=list(name="example_2", fn=datamaker, args=args_eg2, seed=1:100)
scenarios[[3]]=list(name="example_3", fn=datamaker, args=args_eg3, seed=1:100)
scenarios[[4]]=list(name="example_4", fn=datamaker, args=args_eg4, seed=1:100)

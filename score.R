#This file should define your score function

score = function(data, output){
#insert calculations here; return a named list of results
  squared_error = (data$meta$truemean-output$meanest)^2 
  abs_error = abs(data$meta$truemean-output$meanest)
  rootabs_error = sqrt(abs(data$meta$truemean-output$meanest))
  return(list(squared_error = squared_error, abs_error= abs_error, rootabs_error=rootabs_error))
}

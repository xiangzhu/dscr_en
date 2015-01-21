#This file should define your score function

score = function(data, output){
#insert calculations here; return a named list of results
 
  #prediction_mse = mean( (data$meta$Ytestt - output$predict)^2 )
  prediction_mse = mean( (data$meta$Xtestt %*% data$meta$mybeta - data$meta$Xtestt %*% output$coefest)^2 )
  estimation_mse = mean( (data$meta$mybeta - output$coefest)^2 )

  return(list(prediction_mse = prediction_mse, estimation_mse = estimation_mse))
}

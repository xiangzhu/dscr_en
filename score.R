#This file should define your score function

score = function(data, output){
#insert calculations here; return a named list of results
  
  truevalue = data$meta$Xtestt %*% data$meta$mybeta
  prediction = output$predict(data$meta$Xtestt)$fit
  
  prediction_mse = mean( (truevalue - prediction)^2 )
  
  estimation_mse = mean( (data$meta$mybeta - output$coefest)^2 )

  return(list(prediction_mse = prediction_mse, estimation_mse = estimation_mse))
}

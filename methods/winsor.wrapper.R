library(psych)
winsor.wrapper = function(input,args){
	return(list(meanest = winsor.mean(input$x,trim=0.2)))
}

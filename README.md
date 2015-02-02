# Goal

Dynamic statistical comparison of high-dimensional regression based on the simulation study of Elastic-Net (Zou and Hastie, 2005)

# Background 

For a general introduction to DSCs, see [here](https://github.com/stephens999/dscr/blob/master/intro.md).

Here provide general background on the problem that methods in this DSC are attempting to do.
Provide enough detail so that someone could work out whether their method might be appropriate to add to the DSC.

# Input, meta and output formats

This DSC uses the following formats:

`input: list(Xtrain = numeric matrix, Ytrain = numeric matrix, Xvalid = numeric matrix, Yvalid = numeric matrix)` # `(Xtrain, Ytrain)`: training set of (predictor, response); `(Xvalid, Yvalid)`: validation set of (predictor, response); 

`meta: list(Xtestt = numeric matrix, Ytestt = numeric matrix, mybeta = numeric vector, resstd = numeric scalar)` # `(Xtestt, Ytestt)`: testing set of (predictor, response); `mybeta`: true value of the regression coefficients; `resstd`: true value of residual standard deviation

`output: list(predict = R function, coefest = numeric vector)` # `predict`: prediction function; `coefest`: estimated regression coefficients

NB: the only input for the `predict` function is `Xtestt`; the output of `prediction` might varies but must be a list, with the predicted value store in `fit`. 

# Scores

Provide a summary of how methods are scored.

See [score.R](score.R).

# To add a method

To add a method there are two steps.

- add a `.R` file containing an R function implenting that method to the `methods/` subdirectory
- add the method to the list of methods in the `methods.R` file.

Each method function must take arguments `(input,args)` where `input` is a list with the correct format (defined above), and `args` is a list containing any additional arguments the method requires. Here `args=list(Mytune = numeric scalar)`, denoting the number of folds in cross validation (if applicable). 

Each method function must return `output`, where `output` is a list with the correct format (defined above).

# To add a scenario

To add a scenario there are two steps, the first of which can be skipped if you are using an existing datamaker function

- add a `.R` file containing an R function implenting a datamaker to the `datamakers/` subdirectory
- add the scenario to the list of scenarios in the `scenarios.R` file.

Each datamaker function must return a `list(meta,input)` where `meta` and `input` are each lists with the correct format
(defined above).


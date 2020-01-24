# Version: 2019-12-18, 5:35 am
# by Ho-Won Jung
# KUBS, 010-9447-1938, hwjung@korea.ac.kr
#---------------------------------------------------------

### Visualizations {caret}, https://topepo.github.io/caret/visualizations.html
visualizationFUN <- function(X, Y, g) {
  if (g == "scatter") {
    f=featurePlot(x = X, y = Y, plot = "pairs",   auto.key = list(columns = 3))    ## Add a key at the top
  } else if (g == "ell" | g == "ellipse") {
    f=featurePlot(x = X, y = Y, plot = "ellipse", auto.key = list(columns = 3))
  } else if (g == "density") {
    f=featurePlot(x = X, y = Y, plot = "density", auto.key = list(columns = 3), layout = c(4,1 ),
                  ## Pass in options to xyplot() to make it prettier
                  scales = list(x = list(relation="free"), y = list(relation="free")),  
                  adjust = 1.5, pch = "|")
  } else if (g == "box") {    
    f=featurePlot(x = X, y = Y, plot = "box",     auto.key = list(columns = 3), layout = c(4,1 ),
                  scales = list(y = list(relation="free"), x = list(rot = 90))   )
  }  
  return(f)
}

####################################
## data partition
dataPartitionFUN <- function(M) {
  library(caret)
  set.seed(123)
  trRN <- createDataPartition(M$Y, 
                                    p=0.7,       # training percentage 
                                    list = FALSE)   
  # (1) Training data
  trData <- M[trRN, ]
  dim(trData)  
  
  # (2) Testing data
  teData <- M[-trRN, ]
  dim(teData) 
  return(list(trData, teData))  
} 


####################################
test_rocFUN <- function(model, teData) {
  # This function is working for caret.
  # https://goo.gl/mw95Qf
  # Calculate the probability of new observations belonging to each class
  # predict.Y will be a matrix with dimensions data_set_size x number_of_classes
  Y.columnNumber <- which(names(teData) == "Y")
  predict.Y  <- predict(model, teData, type = "raw") 
  predict.Yp <- predict(model, teData, type = "prob")
  
  show(  confusionMatrix(predict.Y,  as.factor(teData$Y)))
  
  # Specify the different classes 
  classes <- levels(as.factor(teData$Y))
  
  # For each class
  auc.class <- vector(mode = "list", length = length(classes))
  
  for (i in 1:length(classes)) {
    # Define which observations belong to class[i]
    true_values <- ifelse(teData[, Y.columnNumber] == classes[i], 1, 0)
    # Assess the performance of classifier for class[i]
    pred <- prediction(predict.Yp[, i], true_values)
    perf <- performance(pred, "tpr", "fpr")
    if (i == 1) {
      plot(perf, main ="ROC Curve", 
           xlab = "(1-specificity: False Positive)", ylab = "Sensitivity: False Negative", col = i) 
    } else  {
      plot(perf, main = "ROC Curve", col = i, add = TRUE) 
    }
    # Calculate the AUC and print it to screen
    auc.perf <- performance(pred, measure = "auc")
    show(auc.perf@y.values)
  } # for
  legend(x = "bottomright", 
         legend = classes,
         fill   = 1:length(classes))
  return (invisible)
}

######################
# example: miningFUN("rf", M)
miningFUN <- function(method, M) {
  # M must include Y as class variable. as.factor(Y) if Y is numeric.
  cat("\n Method = ", method, "\n\n")
  cat("1. createDataPartition: 0.7\n\n")
  trRN <- createDataPartition(M$Y, 
                              p=0.7,         # training percentage 
                              list = FALSE)  # no list 
  cat("2. Training data\n\n")
  trData <- M[trRN, ]
  dim(trData)  
  
  cat("3. Testing data\n\n")
  teData <- M[-trRN, ]
  dim(teData)  
  
  cat("4. confirm the proportions of Y in M, trData, & teData \n\n")
  print(table(M$Y))
  print(table(trData$Y))
  print(table(teData$Y))
  
  cat("\n 5. modeling without scaling \n\n")
  # model.rf    <- caret::train(Y ~ ., method = "rf", data = trData) 
  eval(parse(text = paste0("ft_model <- caret::train(Y ~ ., method = \"", method, "\", data = trData)")))
  print(ft_model)
  
  cat("\n 6. variable importance \n\n")
  imp.rf <- varImp(ft_model) 
  print(imp.rf) 
  plot(imp.rf, top = 4)
  
  cat("\n 7. Testing\n\n")
  test.model <- test_rocFUN(ft_model, teData)
  return(invisible())
}



# Code to extract the sklearn results
# Based on https://github.com/WinVector/ExploreModels


options(gsubfn.engine="R")
library(sqldf)


PROBLEM_DESC = read.table('data/problemDescr.csv', header=TRUE, sep=',', stringsAsFactors=TRUE)
colnames(PROBLEM_DESC) = gsub('\\.', '_', colnames(PROBLEM_DESC) )
MODEL_RESULTS = read.table('data/modelres.csv.gz', header=TRUE, sep=',', stringsAsFactors=TRUE)
colnames(MODEL_RESULTS) = gsub('\\.', '_', colnames(MODEL_RESULTS) )
ALLMODELS = sort(unique(MODEL_RESULTS$Model_Name))     
ALL_BUT_GROUND = setdiff(ALLMODELS, c('ground truth'))

calculateAccuracyMatrix = function(modelres=MODEL_RESULTS) {
  # first, get the maximum probabilities --- change this to use ArgMaxIndicator column
  
  maxProbs = sqldf("select * from modelres
                   where ArgMaxIndicator=1
                   group by Problem_File_Name, Model_Name, Row_Number
                   order by Problem_File_Name, Model_Name, Row_Number")
  maxProbs$isRight = as.numeric(with(maxProbs,PredictionIndex==Correct_Answer))
  maxProbs
}
ACCURACY_MATRIX = calculateAccuracyMatrix()

calculateAccuracy = function(problemfilelist, modellist = ALL_BUT_GROUND, accmat=ACCURACY_MATRIX) {
  amat = subset(accmat, Problem_File_Name %in% problemfilelist & Model_Name %in% modellist)
  sqldf("select Model_Name, avg(isRight) accuracy
        from amat
        group by Model_Name
        order by Model_Name")
}


results_sklearn <- data.frame(id = 1:123, data="",  stringsAsFactors=FALSE)
for (j in 1:length(ALL_BUT_GROUND)){
  results_sklearn[, ALL_BUT_GROUND[j]] = 0
}
for (i in 1:dim(PROBLEM_DESC)[1]){
  results_sklearn[i, 2] <- lapply(PROBLEM_DESC$Relation_Name[i], as.character)
  results_sklearn[i, 3:9] <- calculateAccuracy(PROBLEM_DESC$Problem_File_Name[i])$accuracy
}
save(results_sklearn, file="data/results_sklearn.RDa")
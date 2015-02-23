library(shiny)
library(ggplot2)
library(gridExtra)

source("src/plot_best_algos.R")
source("src/plot_comparison_families.R")
source("src/plot_comparison_best.R")

load(file="data/algos_family.Rda")
load(file="data/results.Rda")
load(file="data/results_ranking.Rda")
load(file="data/info_tables.Rda")
load(file="data/stats_bin.Rda")
load(file="data/stats_all.Rda")



selected_algos = list("NNET - avNNet_caret" = "avNNet_caret", 
                      "BAG - Bagging_LibSVM_weka" = "Bagging_LibSVM_weka",
                      "BST - adaboost_R" = "adaboost_R",
                      "DT - C5.0_caret" = "C5.0_caret",
                      "BY - BayesNet_weka" = "BayesNet_weka",
                      "RF - parRF_caret" = "parRF_caret",
                      "DA - fda_caret" = "fda_caret",
                      "SVM - svm_C" = "svm_C",
                      "GLM - glmnet_R" = "glmnet_R",
                      "NN - knn_caret" = "knn_caret")
colors <- c("avNNet_caret" = "#FF7F00", 
            "Bagging_LibSVM_weka" = "#984EA3",
            "adaboost_R" = "black",
            "C5.0_caret" = "#4DAF4A",
            "BayesNet_weka" = "#FFFF33",
            "parRF_caret" = "#377EB8",
            "fda_caret" = "#A65628",
            "svm_C" = "#E41A1C",
            "glmnet_R" = "#F781BF",
            "knn_caret" =  "#999999")


shinyServer(function(input, output) {

  output$ui <- renderUI({
    switch(input$table_by,
           "Algorithm" =   selectInput("family", "Algorithm Family:", 
                                       choices = c("ALL", unique(algos_family$family))),
           "Family" = br()
    )
  })
  
  output$slides <- renderUI({
    tags$iframe(src = "slides.html",height=800, width=1124 )
  })
  
  # Filter data based on selections
  output$table_algos <- renderDataTable({
      temp <- algos_family
      temp[,"Algorithm"] = rownames(algos_family)
      if (input$family1 == "ALL"){
        temp
      }else{
        temp[which(temp$family == input$family1),]
      }
  }, options = list(paging = FALSE, pageLength = -1, searching = FALSE))
  
  output$table <- renderDataTable({
    if (input$filter_binary == "All"){
      temp <- stats_all
    } else {
      temp <- stats_bin
    }
    if (is.null(input$family))
      return(temp[, c(5,3,4,1,2)])
    if (input$family == "ALL"){
      temp[, c(5,3,4,1,2)]
    }else{
      temp[which(temp$Family == input$family), c(5,3,4,1,2)]
    }
  }, options = list(pageLength = 15, searching = FALSE))
  
  output$table_plot_family = renderPlot({
    plot_comparison_families(stats_all, stats_bin, input$filter_binary)
  })
  
  output$plot_per_best_acc = renderPlot({
    # a <- c("parRF_caret", "svm_C", "elm_kernel_matlab")
    a <- input$best_acc_by2
    plot_best_algos(a, results_ranking, info_tables, input$filter_binary, colors)
  })
  
  output$plot_comparison = renderPlot({
    a <- input$best_acc_by3
    plot_comparison_best(a,selected_algos,colors,results_ranking,info_tables,input$filter_binary)
  })
  
})




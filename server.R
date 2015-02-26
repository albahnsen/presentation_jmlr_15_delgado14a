# Launch from console
# R -e "shiny::runApp()"

library(shiny)
library(ggplot2)
library(gridExtra)

load(file="data/algos_family.Rda")
load(file="data/results.Rda")
load(file="data/results_ranking.Rda")
load(file="data/info_tables.Rda")
load(file="data/stats_bin.Rda")
load(file="data/stats_all.Rda")

source("src/plot_best_algos.R")
source("src/plot_comparison_families.R")
source("src/plot_comparison_best.R")
source("src/plot_weighted_acc.R")
source("src/plot_bin_multi_comparison.R")

load(file="data/algos.Rda")
selected_algos <- split(algos$Algorithm, algos$FullName)
colors <- setNames(as.vector(algos$color), algos$Algorithm)


shinyServer(function(input, output) {

  # Execute the slides.html in the intro
  output$slides <- renderUI({
    tags$iframe(src = "slides.html",height=800, width=1124 )
  })
  
  # Filter the algorithms by family and implementation
  output$table_algos <- renderDataTable({
      if ((input$family1 == "ALL") & (input$implementation1 == "ALL")){
          algos_family
      } else if (input$family1 == "ALL") {
          algos_family[which(algos_family$Implementation == input$implementation1),]
      }else if (input$implementation1 == "ALL"){
          algos_family[which(algos_family$Family == input$family1),]
      } else {
          algos_family[which((algos_family$Implementation == input$implementation1) & (algos_family$Family == input$family1)) ,]
      }
  }, options = list(paging = FALSE, pageLength = -1, searching = FALSE))
  
  # Render UI Results - Friedman ranking if results by family
  output$ui <- renderUI({
    switch(input$table_by,
           "Algorithm" =   selectInput("family2", h4("Algorithm Family:"), 
                                       choices = c("ALL", sort(unique(algos_family$Family)))),
           "Family" = br()
    )
  })
  output$ui2 <- renderUI({
    switch(input$table_by,
           "Algorithm" =   selectInput("implementation2", h4("Algorithm Implementation:"), 
                              choices = c("ALL", sort(unique(algos_family$Implementation)))),
           "Family" = br()
    )
  })
  
  # Friedman ranking results, filter by family
  output$table <- renderDataTable({
    if (input$filter_binary == "All"){
      temp <- stats_all
    } else {
      temp <- stats_bin
    }
    if (is.null(input$family2))
      return(temp[, c(5,3,4,1,2)])
    
    if ((input$family2 == "ALL") & (input$implementation2 == "ALL")){
      temp[, c(6,3,4,5,1,2)]
    } else if (input$family2 == "ALL") {
      temp[, c(6,3,4,5,1,2)][which(temp$Implementation == input$implementation2),]
    }else if (input$implementation2 == "ALL"){
      temp[, c(6,3,4,5,1,2)][which(temp$Family == input$family2),]
    } else {
      temp[, c(6,3,4,5,1,2)][which((temp$Implementation == input$implementation2) & (temp$Family == input$family2)) ,]
    }
  }, options = list(pageLength = 15, searching = FALSE))
  
  # Plot comparison algorithms and implementations
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
  
  output$plot_weighted = renderPlot({
    plot_weighted_acc(selected_algos,colors,results_ranking,info_tables,input$weighted,input$filter_binary)
  })
  
  output$plot_bin_multi = renderPlot({
    plot_bin_multi_comparison(stats_all, stats_bin, selected_algos,colors,input$comparison_by4)
  })
})









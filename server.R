library(shiny)
library(datasets)

load(file="data/algos_family.Rda")
load(file="data/results.Rda")
load(file="data/results_ranking.Rda")


stats <- data.frame(colMeans(t(apply(-results_ranking, 1, rank, ties.method='average'))))
colnames(stats) <- 'rank'
stats['accu']  <- colMeans(results, na.rm = TRUE)


# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Filter data based on selections
  output$table <- renderDataTable({
    out_table <- stats
    out_table['Algorithm'] <- rownames(stats)
    out_table['Family'] <- algos_family
    out_table[order(stats$rank)[1:input$obs], c(3,4,1,2)]
  }, options = list(paging = FALSE, searching = FALSE))
  
})
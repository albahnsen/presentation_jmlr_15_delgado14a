library(shiny)
library(ggplot2)
library(gridExtra)

load(file="data/algos_family.Rda")
load(file="data/results.Rda")
load(file="data/results_ranking.Rda")

stats <- data.frame(colMeans(t(apply(-results_ranking[,!names(results_ranking) %in% c("order","max")], 1, rank, ties.method='average'))))
colnames(stats) <- 'FriedmanRank'
stats['Accuracy']  <- colMeans(results, na.rm = TRUE)
stats['Algorithm'] <- rownames(stats)
stats['Family'] <- algos_family
stats <- stats[order(stats$FriedmanRank),]
stats['Rank'] <- c(1:dim(stats)[1])

results_ranking$max <- apply(results_ranking,1,max)
results_ranking$order[order(results_ranking$max)] <- 1:121

# stats_f <- data.frame(unique(algos_family$family))
# colnames(stats_f) <- "Family"
# stats_f.
# stats.aqggregate(stats, by=list(stats$Family))

# library(RColorBrewer)
# colors_ <- brewer.pal(9,"Set1")
colors <- c("elm_kernel_matlab" = "#FF7F00", 
             "Bagging_LibSVM_weka" = "#984EA3",
             "adaboost_R" = "black",
             "C5.0_caret" = "#4DAF4A",
             "BayesNet_weka" = "#FFFF33",
             "parRF_caret" = "#377EB8",
             "fda_caret" = "#A65628",
             "svm_C" = "#E41A1C",
             "glmnet_R" = "#F781BF",
             "knn_caret" =  "#999999")


# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {

  output$ui <- renderUI({
    switch(input$table_by,
           "Algorithm" =   selectInput("family", "Algorithm Family:", 
                                       choices = c("ALL", unique(algos_family$family))),
           "Family" = br()
    )
  })
  
  # Filter data based on selections
  output$table <- renderDataTable({
    if (is.null(input$family))
      return(stats[, c(5,3,4,1,2)])
    
    if (input$family == "ALL"){
      stats[, c(5,3,4,1,2)]
    }else{
      stats[which(stats$Family == input$family), c(5,3,4,1,2)]
    }
  }, options = list(pageLength = 15, searching = FALSE))
  
  output$table_plot_family = renderPlot({
    ggplot(stats, aes(x=reorder(stats$Family, stats$FriedmanRank), y=FriedmanRank, fill=Family)) + 
      geom_boxplot() + guides(fill=FALSE) + xlab("Family")
  })
  
  output$table_plot_family2 = renderPlot({
    ggplot(stats, aes(x=reorder(stats$Family, -stats$Accuracy), y=Accuracy, fill=Family)) + 
      geom_boxplot() + guides(fill=FALSE) + xlab("Family")
  })
  
  output$text_temp = renderPrint(input$table_by)

  output$plot_per_best_acc = renderPlot({
    # a <- c("parRF_caret", "svm_C", "elm_kernel_matlab")
    # a <- c("svm_C")
    a <- input$best_acc_by2
    
    # Create data frame for the per of max each algo
    temp <- data.frame(results_ranking[a[1]] / results_ranking$max * 100)
    colnames(temp) <- a[1]
    colors_= data.frame(a)
    colors_[1,'color'] = colors[a[1]]
    if (length(a) > 1){
      for (i in 2:length(a)){
        temp[,a[i]] <- data.frame(results_ranking[a[i]] / results_ranking$max * 100)
        colors_[i,'color'] = colors[a[i]]
      }
    }
    
    # create plots
    # plt1 is percentage of maximun
    plt1 <- ggplot(results_ranking[order(results_ranking$max),]) + ylim(0, 100) + xlab("Data set")+
      geom_line(colour="#999999", aes_string(x="order", y="max")) +
      geom_line(colour=colors[a[1]], aes_string(x="order", y=a[1])) 
    # plt2 is distribution of the percentage of maximun
    plt2 <- ggplot(temp) +  xlim(0,100) + xlab("Data set") + xlim(75,100) + ylim(0,0.17) +
      geom_density(aes_string(x=a[1],y="..density.."),  color=colors[a[1]], fill=colors[a[1]], alpha=0.3)
    
    if (length(a) > 1){
      for (i in 2:length(a)){
        plt1 <- plt1 + geom_line(colour=colors[a[i]], aes_string(x="order", y=a[i])) 
        plt2 <- plt2 + geom_density(aes_string(x=a[i], y="..density.."),  color=colors[a[i]], fill=colors[a[i]], alpha=0.3)
      }
    }
    
    # Create legend
    g_legend<-function(a.gplot){ 
      tmp <- ggplot_gtable(ggplot_build(a.gplot)) 
      leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box") 
      legend <- tmp$grobs[[leg]] 
      return(legend)} 
    # Temp histogram to extract the legend
    temp1 <- as.data.frame(t(results_ranking[1,a]))
    colnames(temp1) <- c("temp")
    temp1[,"color"] = colors_[,"color"]
    temp1[,"Algorithm"] = rownames(temp1)
    my_hist<- ggplot(temp1, aes(temp, fill=Algorithm)) + geom_bar() + theme(legend.position="bottom") + scale_fill_manual(values = colors)
    legend <- g_legend(my_hist)
    
    # Combine plots
    grid.arrange(arrangeGrob(plt1 + theme(legend.position="none"),
                             plt2 + theme(legend.position="none"),
                             nrow=2), legend, nrow=2,heights=c(10, 1))

  })
  
})

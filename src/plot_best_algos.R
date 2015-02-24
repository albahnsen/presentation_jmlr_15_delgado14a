plot_best_algos <- function(a,results_ranking, info_tables, results_by,colors) {
    
  if (results_by == "Binary"){
    filter_ = (info_tables[,"classes"] == 2)
    results_ranking <- results_ranking[filter_ == "TRUE",]
  }
    
  results_ranking$max <- apply(results_ranking,1,max)
  results_ranking$order[order(results_ranking$max)] <- 1:dim(results_ranking)[1]
  
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
    geom_line(colour="#999999", aes_string(x="order", y="max"), size=2) +
    geom_line(colour=colors[a[1]], aes_string(x="order", y=a[1])) 
  # plt2 is distribution of the percentage of maximun
  plt2 <- ggplot(temp) +  xlim(0,100) + xlab("Data set") + xlim(90,100) + 
    geom_density(aes_string(x=a[1],y="..density.."),  color=colors[a[1]], fill=colors[a[1]], alpha=0.3) +
    geom_vline(xintercept=mean(temp[,a[1]]), color=colors[a[1]], linetype="dashed", size=2)
  
  if (length(a) > 1){
    for (i in 2:length(a)){
      plt1 <- plt1 + geom_line(colour=colors[a[i]], aes_string(x="order", y=a[i])) 
      plt2 <- plt2 + geom_density(aes_string(x=a[i], y="..density.."),  color=colors[a[i]], fill=colors[a[i]], alpha=0.3) +
        geom_vline(xintercept=mean(temp[,a[i]]), color=colors[a[i]], linetype="dashed", size=2)
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
  my_hist<- ggplot(temp1, aes(temp, fill=Algorithm)) + geom_bar() + theme(legend.position="bottom") + scale_fill_manual(values = colors) + theme(text = element_text(size=20))
  legend <- g_legend(my_hist)
  
  # Combine plots
  grid.arrange(arrangeGrob(plt1 + theme(legend.position="none", text = element_text(size=20)),
                           plt2 + theme(legend.position="none", text = element_text(size=20)), ncol=1,
                           nrow=2), legend, ncol=1, nrow=2, heights=c(15, 1))
}

# a <- c("parRF_caret", "svm_C", "elm_kernel_matlab")
# plot_best_algos(a,results_ranking, info_tables, "ALL",colors)

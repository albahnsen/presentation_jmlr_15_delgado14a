plot_weighted_acc <- function(selected_algos,colors,results_ranking,info_tables,result_stat,results_by){

  if (results_by == "Binary"){
    filter_ = (info_tables[,"classes"] == 2)
    results_ranking <- results_ranking[filter_ == "TRUE",]
    info_tables <- info_tables[filter_ == "TRUE",]
  }
  
  a <- unlist(selected_algos)
  
  Nd = dim(results_ranking)[1]
  Nc = dim(results_ranking)[2]
  
  res <- data.frame(um=colMeans(results_ranking[,a]))
  
  res[,"Algorithm"] <- a
  # Weighted by difficult of database
  max_ <- apply(results_ranking,1,max)
  wc = Nd*(1-max_) / (Nd - sum(max_))
  res[,"uj"] <- colMeans(results_ranking[,a] * wc)
  
  # Weighted increasing # patterns
  wp = Nd * info_tables[,"obs"]/ sum(info_tables[,"obs"])
  res[,"up"] <- colMeans(results_ranking[,a] * wp)
  
  # Weighted decreasing # patterns
  wd = Nd * (max(info_tables[,"obs"]) - info_tables[,"obs"]) / (sum(info_tables[,"obs"]+max(info_tables[,"obs"])))
  res[,"ud"] <- colMeans(results_ranking[,a] * wd)
  
  # Wighted by number of classes
  wl = Nd*info_tables[,'classes'] / sum(info_tables[,"classes"])
  res[,"ul"] <- colMeans(results_ranking[,a] * wl)
  
  # Wighted by number of features
  wi = Nd*info_tables[,'features'] / sum(info_tables[,"features"])
  res[,"ui"] <- colMeans(results_ranking[,a] * wi)
  
  
  accu <- list("Average accuracy" = "um",
               "Weighted accuracy difficulty" = "uj",
               "Weighted accuracy # patterns" = "up",
               "Weighted accuracy dec # patterns" = "ud",
               "Weighted accuracy # classes" = "ul",
               "Weighted accuracy # features" = "ui"
  )
  
  # Always order by um
  res$order[order(-res[,"um"])] <- 1:length(a)

  ggplot(res, aes(x=reorder(Algorithm,-um), y=um)) +  
    geom_bar(width = 0, alpha=0, fill="black", stat="identity") +
    theme(text = element_text(size=20),legend.position="none", axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_line(linetype="dashed", alpha=0.2, aes(x=order,y=um)) + geom_point(alpha=0.3, size=3, aes(x=order,y=um),color="#FF0000FF",shape=19) +
    geom_line(linetype="dashed", aes_string(x="order",y=result_stat)) + 
    geom_point(alpha=0.5, size=7,  color="#FF0000FF",shape=19, aes_string(x="order",y=result_stat)) + 
    ylim(min(res$um,res[,result_stat]),max(res$um,res[,result_stat])) +
    xlab("Algorithm") + ylab(names(accu)[match(result_stat, accu)]) + 
    ggtitle("Accuracy and weighted accuracy of selected classifiers")
  
#   ggplot(res[order(-res[,result_stat]),], aes_string(x="order", y=result_stat) ) +  
#     geom_line(linetype="dashed") + geom_point(alpha=0.5, size=7, aes(color=Algorithm),shape=19) + scale_color_manual(values = colors) +
#     xlab("Algorithm") + ylab(names(accu)[match(result_stat, accu)]) + scale_x_discrete(breaks = 1:length(selected_algos), aes(limit=Algorithm)) +
#     geom_line(linetype="dashed", alpha=0.2, aes(x=order,y=um)) + geom_point(alpha=0.3, size=3, aes(x=order,y=um,color=Algorithm),shape=19) + 
#     theme(text = element_text(size=20)) + ggtitle("Accuracy and weighted accuracy of selected classifiers")
#   
}

# plot_weighted_acc(selected_algos,colors,results_ranking,info_tables,"ui","All")

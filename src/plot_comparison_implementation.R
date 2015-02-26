plot_comparison_implementation <- function(stats_all, stats_bin, results_by, by_family5){
  if (results_by == "All"){
    temp <- stats_all
  } else {
    temp <- stats_bin
  }
  
  if (by_family5 != "ALL"){
    temp <- temp[which(temp$Family == by_family5),]
  }
  
  temp1 <- aggregate(FriedmanRank ~ Implementation, temp, function(x) min(x))
  temp1$order[order(temp1$FriedmanRank)] <- 1:length(unique(temp$Implementation))
 
  plt1 <- ggplot(temp1, aes(x=reorder(Implementation, FriedmanRank), y=FriedmanRank)) + 
    geom_bar(width = 0.5, alpha=0.5, color="black", fill="#0066FFFF", stat="identity") +
    theme(text = element_text(size=20),legend.position="none", axis.text.x = element_text(angle = 45, hjust = 1)) +
    coord_cartesian(ylim=c(floor(min(temp1$FriedmanRank)/2.5)*2.5,ceiling(max(temp1$FriedmanRank)/2.5)*2.5)) + xlab("")+
    ggtitle(paste0("Comparison of the implementations for family '",by_family5, "'"))
  
  temp1 <- aggregate(Accuracy ~ Implementation, temp, function(x) max(x))
  temp1$order[order(-temp1$Accuracy)] <- 1:length(unique(temp$Implementation))
  
  plt2 <- ggplot(temp1, aes(x=reorder(Implementation, -Accuracy), y=Accuracy)) + xlab("Implementation") +
    theme(text = element_text(size=20),legend.position="none", axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_bar(width = 0.5, alpha=0.5, color="black", fill="#0066FFFF", stat="identity") + 
    coord_cartesian(ylim=c(floor(min(temp1$Accuracy)/2.5) *2.5,ceiling(max(temp1$Accuracy)/2.5) *2.5))
  
  grid.arrange(plt1, plt2, ncol=1 , nrow=2)
}

# plot_comparison_implementation(stats_all, stats_bin, "All", "BAG")


plot_comparison_families <- function(stats_all, stats_bin, results_by){
  if (results_by == "All"){
    temp <- stats_all
  } else {
    temp <- stats_bin
  }
  plt1 <- ggplot(temp, aes(x=reorder(Family, FriedmanRank), y=FriedmanRank, fill=Family)) + 
    geom_boxplot() + guides(fill=FALSE) + xlab("Family")
  plt2 <- ggplot(temp, aes(x=reorder(Family, -Accuracy), y=Accuracy, fill=Family)) + 
    geom_boxplot() + guides(fill=FALSE) + xlab("Family")
  grid.arrange(plt1+theme(text = element_text(size=20)) , plt2+theme(text = element_text(size=20)), ncol=1 , nrow=2)
}

# plot_comparison_families(stats_all, stats_bin, "All")

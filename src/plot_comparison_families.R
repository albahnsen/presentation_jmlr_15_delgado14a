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
  grid.arrange(plt1 , plt2 , nrow=2, height=15)
}
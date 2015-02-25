plot_bin_multi_comparison <- function(stats_all, stats_bin, selected_algos,colors,comparison_by4){
  if (comparison_by4 == "friedman"){
      stat = "FriedmanRank" 
  } else{
      stat = "Accuracy"
  }
  
  res_t2 <- data.frame(All=1:length(selected_algos), Binary=0 , Algorithm="", stringsAsFactors=FALSE)
  
  for (i in 1:length(selected_algos)){
    res_t2[i, c(1,3)] = stats_all[which(stats_all$Algorithm==selected_algos[i]), c(stat,"Algorithm")]
    res_t2[i, 2] = stats_bin[which(stats_bin$Algorithm==selected_algos[i]), stat]
  }
  
  if (comparison_by4 == "friedman"){
    res_t2$order[order(res_t2[,"All"])] <- 1:length(selected_algos)
    plt <- ggplot(res_t2, aes(x=reorder(Algorithm, All), y=All))
  } else {
    res_t2$order[order(-res_t2[,"All"])] <- 1:length(selected_algos)
    plt <- ggplot(res_t2, aes(x=reorder(Algorithm, -All), y=All))
  }
    
  plt <- plt + 
    theme(text = element_text(size=20),legend.position="none", axis.text.x = element_text(angle = 45, hjust = 1)) +
    geom_bar(width = 0.5, alpha=0.5, color="black", fill="#0066FFFF", stat="identity") + 
    xlab("") + ylab(stat) +
    geom_line(linetype="dashed", alpha=0.4, aes(x=order, y=Binary)) + geom_point(alpha=1, size=4, color="#FF0000FF", aes(y=Binary),shape=19) + 
    ggtitle("Comparison All databases versus Binary databases")
  if (comparison_by4 == "friedman"){
    plt + coord_cartesian(ylim=c(30,70))
  } else {
    plt + coord_cartesian(ylim=c(75,85))
  }
}

# plot_bin_multi_comparison(stats_all, stats_bin, selected_algos,colors,"friedman")


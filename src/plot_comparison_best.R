plot_comparison_best <- function(a,selected_algos,colors,results_ranking,info_tables,results_by){
  if (results_by == "Binary"){
    filter_ = (info_tables[,"classes"] == 2)
    results_ranking <- results_ranking[filter_ == "TRUE",]
  }
  
  # res_t <- data.frame(t_test=1:length(selected_algos), CI_low=0, CI_high=0)
  # rownames(res_t) <- selected_algos
  
  n_sets = dim(results_ranking)[1]
  res_t2 <- data.frame(diff=1:(length(selected_algos) *n_sets) , algo="", stringsAsFactors=FALSE)
  
  for (i in 1:length(selected_algos)){
    #   temp <- t.test(results_ranking[,a], results_ranking[,selected_algos[[i]]])
    #   res_t[i,1] <- temp$statistic
    #   res_t[i,2] <- temp$conf.int[1]
    #   res_t[i,3] <- temp$conf.int[2]
    res_t2[((i-1)*n_sets+1):(i*n_sets),1] = results_ranking[,a] - results_ranking[,selected_algos[[i]] ]
    res_t2[((i-1)*n_sets+1):(i*n_sets),2] = selected_algos[[i]]
  }
  
  ggplot(res_t2, aes(x=reorder(factor(algo), diff), diff, fill=algo)) +  
    geom_boxplot(outlier.shape = NA,alpha=0.3) + guides(fill=FALSE) + 
    xlab("Algorithm") + ylim(-5,10) + scale_fill_manual(values = colors) + 
    theme(text = element_text(size=20), axis.text.x = element_text(angle = 45, hjust = 1)) + 
    ggtitle("T-Test comparing the selected algorithms and the others\n H0: acc_selected == acc_algorithm")
}

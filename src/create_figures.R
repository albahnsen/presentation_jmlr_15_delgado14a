
library(gridExtra)
library(ggplot2)

load(file="data/algos_family.Rda")

# Figures of datasets
g1 <- ggplot(info_tables, aes(x=majority))  + geom_density() + 
  geom_histogram(aes(y=..density..), binwidth=5, color="black", fill="firebrick", alpha=0.5) +
  geom_vline(aes(xintercept=mean(majority)), size=1, linetype="dashed")

g2 <- ggplot(info_tables, aes(x=features))  + geom_density() + 
  geom_histogram(aes(y=..density..), binwidth=5, color="black", fill="firebrick", alpha=0.5) +
  geom_vline(aes(xintercept=mean(features)), size=1, linetype="dashed")

g3 <- ggplot(info_tables, aes(x=obs))  + geom_density() + 
  geom_histogram(aes(y=..density..), binwidth=500, color="black", fill="firebrick", alpha=0.5) +
  geom_vline(aes(xintercept=mean(obs)), size=1, linetype="dashed") +
  xlim(0,10000)

g4 <- ggplot(info_tables, aes(x=classes))  + geom_density() + 
  geom_histogram(aes(y=..density..), binwidth=1, color="black", fill="firebrick", alpha=0.5) +
  geom_vline(aes(xintercept=mean(classes)), size=1, linetype="dashed") +
  xlim(2,25)

png("www/fig_datasets_properties.png", width = 900, height=600, units="px")
grid.arrange(g3+theme(text = element_text(size=20)),g4+theme(text = element_text(size=20)),g1+theme(text = element_text(size=20)),g2+theme(text = element_text(size=20)), ncol=2)
dev.off()

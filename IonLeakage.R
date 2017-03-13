rm(list=ls())

## install.packages("ggplot2")
## install.packages("doBy")

library(ggplot2)
library(doBy)

##set working directory and read datafile
setwd("~/Documents/Work/Ion Leakage")
marijn <- read.table("240217caffeine.csv",
                     header = T,
                     sep = ";",
                     dec = ","
)

##summarizing data
cmarijn <- summaryBy(Conductivity ~ Timepoint + Construct, data=marijn, FUN=c(length,mean,sd))
cmarijn

##drawing plot=Mean values incl, stdev.
p1 <- ggplot(cmarijn, aes(x=Timepoint, y=Conductivity.mean,colour=Construct)) + 
  geom_errorbar(aes(ymin=Conductivity.mean-Conductivity.sd, ymax=Conductivity.mean+Conductivity.sd), width=.1) +
  geom_line() +
  geom_point()+
  scale_color_brewer(name="Coat Protein\n+/-25mg/ml Caffeine", palette="Paired")
p1

##enhancing plot design
#changing labels and titles
p2 <- p1 + labs(title='Rx1-induced Ion-leakage', 
                x='Time after 20 \U03BCM Dexamethasone treatment (hours)', 
                y='Conductivity (\U03BCS)'
                )
p2

#changing Theme
p3 <- p2 + theme(
  plot.title = element_text(color="black", size=20, face="bold"),
  axis.title.x = element_text(color="black", size=18, face="bold"),
  axis.title.y = element_text(color="black", size=18, face="bold"),
  legend.position = c(0.12, 0.8), 
  panel.background = element_rect(fill = "#f3f9ef",
                                  colour = "#f3f9ef",
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "white"), 
  panel.grid.minor = element_blank(),
  text = element_text(size=16)
)
p3

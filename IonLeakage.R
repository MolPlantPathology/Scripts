rm(list=ls())

##install libraries below, if needed
## install.packages("ggplot2")
## install.packages("doBy")
## install.packages("rstudioapi")
library(ggplot2)
library(doBy)
library(rstudioapi)

##set working directory to location of this .R file and read datafile
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
iondata <- read.table("240217caffeine.csv", ##change to your *.csv
                     header = T,
                     sep = ";",
                     dec = ","
)

##insert plot title, axis titles, legend text etc. here
plottitle=    "Rx1-induced ion leakage"
plotsubtitle= "Coat Protein +/- 25mg/ml Caffeine"
legendtitle=  "Constucts"
xaxislabel=   "Time after 20 \U03BCM Dexamethasone treatment (hours)"
yaxislabel=   "Conductivity (\U03BCS)"
legendname1=  "CP105"
legendname2=  "CP105 + Caffeine"
legendname3=  "CP106"
legendname4=  "CP106 + Caffeine"
##legendname works for 4 entries, change code at p1 to change number

##summarizing data
data <- summaryBy(Conductivity ~ Timepoint + Construct, data=iondata, FUN=c(length,mean,sd))
data

##drawing plot > Mean values incl. stdev.
#line graph with dots, slightly transparent (alpha)
# set position dodge to move data pounts slightly
pd <- position_dodge(0.04)
p1 <- ggplot(data, aes(x=Timepoint, y=Conductivity.mean,color= Construct)) + 
  geom_errorbar(aes(ymin=Conductivity.mean-Conductivity.sd, ymax=Conductivity.mean+Conductivity.sd), width=0.2, position=pd, alpha = 0.4) +
  geom_line(size=1, position = pd) +
  geom_point(size=3, fill="white", alpha = 0.4, position = pd) +
  scale_color_brewer(name=legendtitle, 
                     palette="Paired", 
                     breaks=c("CP105", "CP105+Caffeine", "CP106", "CP106+Caffeine"),
                     labels=c(legendname1, legendname2, legendname3, legendname4)
  )
p1

##enhancing plot design
#setting labels and titles
p2 <- p1 + labs(x=xaxislabel, 
                y=yaxislabel,
                title = plottitle,
                subtitle = plotsubtitle) +
                ggtitle(bquote(atop(.(plottitle), atop(.(plotsubtitle), "")))
               )
p2

#changing Theme
p3 <- p2 +theme(
  plot.title = element_text(hjust = 0.5, color="black", size=20, face="bold"),
  axis.title.x = element_text(color="black", size=16, face="bold"),
  axis.title.y = element_text(color="black", size=16, face="bold"),
  panel.background = element_rect(fill = "#f5f8f1",
                                  colour = "#f5f8f1",
                                  size = 0.5, linetype = "solid"),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "white"), 
  panel.grid.minor = element_blank(),
  text = element_text(size=14, face = "bold"), 
  legend.position = c(0.15, 0.75),
  legend.key = element_blank(),  ## Get rid of the legend box 
  legend.text = element_text(size = 10),
  legend.background = element_rect(fill=alpha(0.0001))
)
p3


# save to file
ggsave(filename = "Ion-leakagePlot.png",plot = p3,width = 7,height = 5,dpi = 600)
ggsave(filename = "Ion-leakagePlot.pdf",plot = p3,width = 7,height = 5,dpi = 600)



###Data Visualization 2###

library(tidyverse)

install.packages("ggpubr")
install.packages("ggrepel")

#be consistent with figures across a manuscript

#color blind friendly color pallet with Arial Font
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#Figures should be a single concept or point 

sample.data.bac <- read.csv("C:/Users/djter/Downloads/BacterialAlpha.csv", na.strings = "na")
sample.data.bac$Time_Point <- as.factor(sample.data.bac$Time_Point)
sample.data.bac$Crop <- as.factor(sample.data.bac$Crop)
sample.data.bac$Crop <- factor(sample.data.bac$Crop, levels = c("Soil", "Cotton", "Soybean"))

str(sample.data.bac)

bac.even <- ggplot(sample.data.bac, aes(x = Time_Point, y = even, color = Crop))+
  geom_boxplot(position = position_dodge(0.85))+ 
  geom_point(position = position_jitterdodge(0.05))+
  ylab("Pielou's evenness")+
  xlab("Hours post sowing")+
  scale_color_manual(values = cbbPalette, name = "", labels = c("Soil no seeds", "Cotton spermosphere", "Soybean spermosphere"))+
  theme_classic()
bac.even



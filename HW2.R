###HW2###
install.packages("ggplot2")
library(tidyverse)

mtcars
ggplot(mtcars, aes(x=wt, y=mpg))+
  geom_point()+
  geom_smooth(method=lm, se=FALSE)

ggplot(mtcars, aes(x=wt, y=mpg,))+
  geom_smooth(method=lm, se=FALSE)+
  geom_point(aes(size = hp, color = hp))+
  xlab("weight (tons)")+
  ylab("Miles per gallon")+
  scale_color_gradient(low = "green", high="red")
 
#connect layers with +, can add trend lines, seemingly limitless
#geoms inherit from the previous line

bull.richness<-read.csv("Bull_richness.csv")

ggplot(bull.richness, aes(x=GrowthStage, y= richness, fill = Fungicide, color=Fungicide))+
  geom_boxplot()+
  geom_point(position = position_jitterdodge())+
  scale_fill_manual(values =c("#E87722", "#0C2340"))+
  scale_color_manual(values =c("black", "black"))

ggplot(bull.richness, aes(x=GrowthStage, y= richness, fill = Fungicide))+
  stat_summary(fun=mean, geom = "line", position = "dodge")+
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")+
  scale_fill_manual(values =c("#E87722", "#0C2340"))

#bars w/ SE errors bars
ggplot(bull.richness, aes(x=GrowthStage, y= richness, color = Fungicide))+
  stat_summary(fun=mean, geom = "line")+
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar")+
  scale_color_manual(values =c("#E87722", "#0C2340"))

#Facetting 
ggplot(bull.richness, aes(x=GrowthStage, y= richness, group = Fungicide, color = Fungicide))+
  stat_summary(fun=mean, geom = "line")+
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar")+
  facet_wrap(~Treatment*Crop, scales = "free")

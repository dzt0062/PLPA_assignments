#Coding Challenge 2#

#1
#A: What three elements do you need to produce a ggplot?
##you need data, an x and y variable for plotting, and the shape of the plot

#B: What is a geom?
##A geom refers to the type of plot, ie box, bar, line etc..

#C: What is a facet?
##A facet allows you to plot multiple plots by splitting data into subsets

#D: Explain the concept of layering.
##Layering allows you to place multiple geoms onto a data set to add different visual representations of the data,
##Ie you have a scatter plot geom_point but want more so you add a layer geom_smooth to show a trend line through the data

#E: Where do you add x and y variables and map different shapes, colors, and other attributes to the data?
##within the aes() function


cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

###2
data.toxin <- read.csv("C:/Users/djter/Downloads/MycotoxinData.csv", na.strings = "na")

toxin.box <- ggplot(data.toxin, aes(x = Treatment, y = DON, color = Cultivar))+
  geom_boxplot()+
  ylab("DON (ppm)")+
  xlab("")
toxin.box

###3
toxin.bar1 <- ggplot(data.toxin, aes(x = Treatment, y = DON, color = Cultivar))+
  stat_summary(fun = mean, geom = "bar", position = position_dodge())+
  stat_summary(fun.data = mean_se, geom = "errorbar", position = position_dodge())+
  ylab("DON (ppm)")+
  xlab("")
toxin.bar1

###4
toxin.bar2 <- ggplot(data.toxin, aes(x = Treatment, y = DON, color = Cultivar))+
  stat_summary(fun = mean, geom = "bar", position = position_dodge())+
  stat_summary(fun.data = mean_se, geom = "errorbar", position = position_dodge())+
  geom_point(position = position_jitterdodge(0.05))+
  ylab("DON (ppm)")+
  xlab("")+
  scale_color_manual(values = cbbPalette, name = "", labels = c())+
  theme_classic()
toxin.bar2

toxin.box1 <- ggplot(data.toxin, aes(x = Treatment, y = DON, color = Cultivar))+
  geom_boxplot()+
  ylab("DON (ppm)")+
  geom_point(position = position_jitterdodge(0.05))+
  xlab("")+
  scale_color_manual(values = cbbPalette, name = "", labels = c())+
  theme_classic()
toxin.box1

###5
toxin.bar3 <- ggplot(data.toxin, aes(x = Treatment, y = DON, color = Cultivar))+
  geom_jitter(width = 0.5, alpha = 0.5)+
  stat_summary(fun = mean, geom = "bar", aes(group = Cultivar))+
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .5)+
  ylab("DON (ppm)")+
  xlab("")+
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[1]]), name = "", labels = c("", ""))+
  theme_classic()+
  theme(strip.background = element_blank(), legend.position = "right")+
  facet_wrap(~Cultivar, scales = "free")
toxin.bar3

###6
toxin.bar4<- ggplot(data.toxin, aes(x = Treatment, y = DON, fill = Cultivar))+
  geom_boxplot(color= "#000000", position = position_dodge(width = 0.85))+
  scale_fill_manual(values = c("#000000", "#E69F00"))+
  geom_point(shape = 21, color = "#000000", alpha = 0.5, position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.85))+
  ylab("DON (ppm)")+
  xlab("")+
  scale_color_manual(values = c(cbbPalette[[1]], cbbPalette[[2]]), name = "Cultivar", labels = c("Ambassador", "Wheaton"))+
  theme_classic()+
  facet_wrap(~Cultivar)
toxin.bar4


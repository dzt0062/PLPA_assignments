#Coding Challenge 3#

#load color blind colors#
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

##2 This is changing factor order level so that the treatment “NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 
data.toxin <- read.csv("MycotoxinData.csv", na.strings = "na")
data.toxin$Treatment <- factor(data.toxin$Treatment, levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))
str(data.toxin)

data.toxin
##1##
toxin.box4<- ggplot(data.toxin, aes(x = Treatment, y = DON, fill = Cultivar))+ #boxplot of DON by Treatment#
  geom_boxplot(color= "#000000", position = position_dodge(width = 0.85))+ 
  scale_fill_manual(values = c("#56B4E9", "#009E73"))+ #cbbPallette
  geom_point(shape = 21, color = "#000000", alpha = 0.6, position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.85))+ #Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete 
  ylab("DON (ppm)")+ #labeling y axis
  xlab("")+ #no label for x axis
  scale_color_manual(values = c(cbbPalette[[3]], cbbPalette[[4]]), name = "Cultivar", labels = c("Ambassador", "Wheaton"))+
  theme_classic()+ #theme of plot to be classic
  facet_wrap(~Cultivar) #faceted by cultivar
toxin.box4

##3##
toxin.box5<- ggplot(data.toxin, aes(x = Treatment, y = X15ADON, fill = Cultivar))+ #changing the y variable plot to X15ADON#
  geom_boxplot(color= "#000000", position = position_dodge(width = 0.85))+
  scale_fill_manual(values = c("#56B4E9", "#009E73"))+
  geom_point(shape = 21, color = "#000000", alpha = 0.6, position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.85))+
  ylab("DON (ppm)")+
  xlab("")+
  scale_color_manual(values = c(cbbPalette[[3]], cbbPalette[[4]]), name = "Cultivar", labels = c("Ambassador", "Wheaton"))+
  theme_classic()+
  facet_wrap(~Cultivar)
toxin.box5

toxin.box6<- ggplot(data.toxin, aes(x = Treatment, y = MassperSeed_mg, fill = Cultivar))+ #changing the y variable plot to MassperSeed_mg
  geom_boxplot(color= "#000000", position = position_dodge(width = 0.85))+
  scale_fill_manual(values = c("#56B4E9", "#009E73"))+
  geom_point(shape = 21, color = "#000000", alpha = 0.6, position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.85))+
  ylab("DON (ppm)")+
  xlab("")+
  scale_color_manual(values = c(cbbPalette[[3]], cbbPalette[[4]]), name = "Cultivar", labels = c("Ambassador", "Wheaton"))+
  theme_classic()+
  facet_wrap(~Cultivar)
toxin.box6

#R objects are toxin.box4, toxin.box5, toxin.box6#

##4## cobining the 3 R objexts into one figure with a single legend
toxin.box7<- ggarrange(toxin.box4, toxin.box5, toxin.box6,
                       labels = "auto",
                       nrow = 1,
                       ncol= 3,
                       common.legend = TRUE)
toxin.box7


##5## added t test and significance using geom_pwc and saved as a fourth Robject toxin.box8
toxin.box8<-ggarrange((toxin.box4+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}")),
  toxin.box5+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}"),
  toxin.box6+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}"),
  labels = "auto",
  nrow = 1,
  ncol = 3,
  common.legend = TRUE)
toxin.box8
  

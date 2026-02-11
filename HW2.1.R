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

#Plot 1
bac.even <- ggplot(sample.data.bac, aes(x = Time_Point, y = even, color = Crop))+
  geom_boxplot(position = position_dodge(0.85))+ 
  geom_point(position = position_jitterdodge(0.05))+
  ylab("Pielou's evenness")+
  xlab("Hours post sowing")+
  scale_color_manual(values = cbbPalette, name = "", labels = c("Soil no seeds", "Cotton spermosphere", "Soybean spermosphere"))+
  theme_classic()
bac.even

#plot 2

sample.data.bac.nosoil <- subset(sample.data.bac, Crop != "Soil")

water.imbibed <- ggplot(sample.data.bac.nosoil, aes(Time_Point, 1000 * Water_Imbibed, color = Crop))+
  geom_jitter(width = 0.5, alpha = 0.5)+
  stat_summary(fun = mean, geom = "line", aes(group = Crop))+
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5)+
  xlab("Hours post sowing")+
  ylab("Water Imbibed (mg)")+
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("", ""))+
  theme_classic()+
  theme(strip.background = element_blank(), legend.position = "none")+
  facet_wrap(~Crop, scales = "free")
water.imbibed

#plot 3

water.imbibed.cor <- ggplot(sample.data.bac.nosoil, aes(y = even, x = 1000 * Water_Imbibed, color = Crop))+
  geom_point(aes(shape = Time_Point))+ 
  geom_smooth(se = FALSE, method = lm)+ 
  xlab("Water Imbibed (mg)")+
  ylab("Pielou's evenness")+
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("Cotton", "Soybean"))+
  scale_shape_manual(values = c(15, 16, 17, 18), name = "", labels = c("0 hrs", "6 hrs", "12 hrs", "18 hrs"))+
  theme_classic()+
  theme(strip.background = element_blank(), legend.position = "none")+
  facet_wrap(~Crop, scales = "free")
water.imbibed.cor

figure2<- ggarrange(
  water.imbibed,
  bac.even,
  water.imbibed.cor,
  labels = "auto",
  nrow = 3,
  ncol= 1,
  legend = FALSE
)

libcurlVersion(ggpubr)
install.packages("ggpubr")
install.packages("ggrepel")
install.packages("tidyverse")
library("ggpubr")
library("ggrepel")

figure2<- ggarrange(
  water.imbibed,
  bac.even,
  water.imbibed.cor,
  labels = "auto",
  nrow = 3,
  ncol= 1,
  legend = FALSE)

figure2

#Stats
bac.even+
  stat_compare_means(method="anova")

bac.even+
  geom_pwc(aes(group = Crop), method = "t.test", label= "p.adj.format")

bac.even+
  geom_pwc(aes(group = Crop), method = "t_test", label = "p.adj.signif")

bac.even+ 
  geom_pwc(aes(group = Crop), method = "t_test", label = "{p.adj.format}{p.adj.signif}")

#Correlation
water.imbibed.cor+ 
  stat_cor()

water.imbibed.cor+ 
  stat_cor(label.y = 0.7)+
  stat_regline_equation()


diff.abund<-read.csv("C:/Users/djter/Downloads/diff_abund.csv")
diff.abund

str(diff.abund)

diff.abund$log10_pvalue <- -log10(diff.abund$p_CropSoybean)

diff.abund.label <- diff.abund[diff.abund$log10_pvalue > 30,]

ggplot()+ 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean))+ 
  theme_classic()+ 
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label))+
  scale_color_manual(values = cbbPalette, name="Significant")+
  theme_classic() + 
  xlab("Log fold change Soil vs. Soybean") +
  ylab("-log10 p-value")

volcano <- ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue)) + 
  geom_point(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue), color = "red", shape = 17, size = 4) +
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, label = Label), color = "red") + 
  theme_classic() + 
  xlab("Log fold change Soil vs. Soybean") +
  ylab("-log10 p-value")
volcano










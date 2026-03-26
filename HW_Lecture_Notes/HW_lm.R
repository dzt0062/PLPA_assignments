#Lecture notes for Linear modeling

library(tidyverse)
library(lme4)
library(emmeans)
library(multcomp)

install.packages("emmeans")
install.packages("multcompview")
install.packages("multcomp")

data("mtcars")

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "grey") +
  geom_point(aes(color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon") +
  scale_colour_gradient(low = "forestgreen", high = "black") +
  theme_classic()

lm(mpg ~ wt, data = mtcars) #linear model, gives estimates for intercept and slope or beta

lm1 <- lm(mpg ~ wt, data = mtcars)
summary(lm1)

anova(lm1)
cor.test(mtcars$wt, mtcars$mpg)

#all give the same p value because they are running a linear regression
#Remember the assumptions y is continuous, error is normally distributed, relationship is linear, homoskedasticity, sigma is consistent, independent samples

model <- lm(mpg~wt, data = mtcars)

ggplot(model, aes(y = .resid, x = .fitted)) +
  geom_point() +
  geom_hline(yintercept = 0)

bull.rich <- read.csv("Data/Bull_richness.csv")
bull.rich

#Categorical variables

bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.") %>%
  ggplot(aes(x = Fungicide, y = richness)) + 
  geom_boxplot()

bull.rich.sub <- bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.")

t.test(richness ~ Fungicide, data = bull.rich.sub)

t.test(richness~Fungicide, data = bull.rich.sub, var.equal = TRUE)

summary(lm(richness~Fungicide, data = bull.rich.sub))

anova(lm(richness~Fungicide, data = bull.rich.sub))

#multiple ways to get to the same p value

#ANOVAs
bull.rich.sub2 <- bull.rich %>%
  filter(Fungicide == "C" & Treatment == "Conv." & Crop == "Corn")

bull.rich.sub2$GrowthStage <- factor(bull.rich.sub2$GrowthStage, levels = c("V6", "V8", "V15"))

ggplot(bull.rich.sub2, aes(x = GrowthStage, y = richness)) +
  geom_boxplot()

lm.growth <- lm(richness ~ GrowthStage, data = bull.rich.sub2)

summary(lm.growth)

anova(lm.growth) #report the table

summary(aov(richness ~ GrowthStage, data = bull.rich.sub2))

lsmeans <- emmeans(lm.growth, ~GrowthStage)

results_lsmeans <- cld(lsmeans, alpha = 0.05, details = TRUE)


###Interactions

bull.rich.sub3 <- bull.rich %>%
  filter(Treatment == "Conv." & Crop == "Corn")

lm.interaction <- lm(richness ~ GrowthStage*Fungicide, data = bull.rich.sub3)
summary(lm.interaction)
anova(lm.interaction)

bull.rich.sub3 %>%
  ggplot(aes(x = GrowthStage, y = richness, fill = Fungicide)) +
  geom_boxplot()

install.packages("multcompView")
lsmeans <- emmeans(lm.interaction, ~Fungicide|GrowthStage) # estimate lsmeans of variety within siteXyear
Results_lsmeans <- multcomp::cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE) # contrast with Tukey ajustment
Results_lsmeans


###Mixed effects models
#fixed vs random are factors that effect variance vs mean respectively. Year is a good example of a random effect. Generalize the variation over.
library(lme4) # gives us lmer function


lme0 <- lm(richness ~ GrowthStage*Fungicide, data = bull.rich.sub3)
lme1 <- lmer(richness ~ GrowthStage*Fungicide + (1|Rep), data = bull.rich.sub3) #parenthese bar variable specifies the randomn effect


summary(lm.interaction)



summary(lme0)
summary(lme1)

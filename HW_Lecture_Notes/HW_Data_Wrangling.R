#seamless data wrangling
#manipulating messy data

library(tidyverse)

microbiome.fungi <- read.csv("Data/Bull_richness.csv")
str(microbiome.fungi)

microbiome.fungi2 <- select(microbiome.fungi, SampleID, Crop, Compartment:Fungicide, richness)

head(filter(microbiome.fungi2, Treatment == "Conv."))
head(filter(microbiome.fungi2, Treatment == "Conv." & Fungicide == "C"))
head(filter(microbiome.fungi2, Sample == "A" | Sample == "B"))

head(mutate(microbiome.fungi2, logRich = log(richness)))
head(mutate(microbiome.fungi2, Crop_Treatment = paste(Crop, Treatment)))

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  head() # displaying the first six rows

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness))%>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich))

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(), 
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n))

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  group_by(Treatment, Fungicide) %>% 
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(), 
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n))

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  group_by(Treatment, Fungicide) %>% 
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(), 
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  ggplot(aes(x = Fungicide, y = Mean.rich)) + # adding in a ggplot
  geom_bar(stat="identity") +
  geom_errorbar( aes(x=Fungicide, ymin=Mean.rich-std.err, ymax=Mean.rich+std.err), width=0.4) +
  theme_minimal() +
  xlab("") +
  ylab("Log Richness") +
  facet_wrap(~Treatment)

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns  filter(Class == "Sordariomycetes") %>%
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats by group
  summarise(Mean = mean(richness)) # calculates the mean per Treatment and Fungicide

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns  filter(Class == "Sordariomycetes") %>%
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats by group
  summarise(Mean = mean(richness)) %>% # calculates the mean per Treatment and Fungicide 
  pivot_wider(names_from = Fungicide, values_from = Mean) # pivot to wide format

microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns  filter(Class == "Sordariomycetes") %>%
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats by group
  summarise(Mean = mean(richness)) %>% # calculates the mean per Treatment and Fungicide 
  pivot_wider(names_from = Fungicide, values_from = Mean) %>% # pivot to wide format
  mutate(diff.fungicide = C - F) # calculate the difference between the means. 


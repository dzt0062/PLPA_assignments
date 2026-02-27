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
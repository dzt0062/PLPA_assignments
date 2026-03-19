###Iterations and Functions

install.packages("drc")

library(ggplot2)
library(tidyverse)
library(drc)

str()

(5*degree_f - 32)/9

(5*(32 - 32))/9
(5*(212 - 32))/9

#This may cause copy paste errors

F_to_C <- function(f_temp){
  celsius <- (5*(f_temp-32)/9)
  return(celsius)
}

F_to_C(212)

#Celsius to farhenheiht
C_to_F <- function(c_temp){
  fahrenheiht <-(c_temp*(9/5)+32)
  return(fahrenheiht)
}

C_to_F(0)

#iterations functions in base R

rep("A", 3)

rep(c("A", "B", "C"), 10)

#many ways to rep ie "each" groups and then repeats

seq(from =1 , to =7)

LETTERS

seq_along(LETTERS)

#The for loop

for (i in 1:10){
  print(i*2)
}

for (i in -30:100){
  result <- F_to_C(i)
  print(result)
}

#Making iterations usable
#Step 1. Set a R object to NULL
#Step 2. Set your for loop
#Step 3. Save the result of your for loop into a dataframe each iteration
#Step 4. append one row of the dataframe to the null object each iteration of the loop.

EC50.data <- read.csv("Data/EC50_all.csv")
head(EC50.data)

isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == "ILSO_5-41c"] ~ 
                  EC50.data$conc[EC50.data$is == "ILSO_5-41c"], 
                fct = LL.4(fixed = c(NA, NA, NA, NA), 
                           names = c("Slope", "Lower", "Upper", "EC50")), 
                na.action = na.omit)
# outputs the summary of the paramters including the estimate, standard
# error, t-value, and p-value outputs it into a data frame called
# summary.mef.fit for 'summary of fit'
summary.fit <- data.frame(summary(isolate1)[[3]])
# outputs the summary of just the EC50 data including the estimate, standard
# error, upper and lower bounds of the 95% confidence intervals around the
# EC50
EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
           interval = "delta")[[1]]

EC50.ll4 <- NULL
nm <- unique(EC50.data$is) #finds unique values within a vector

for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]] ~ 
                    EC50.data$conc[EC50.data$is == nm[[i]]], 
                  fct = LL.4(fixed = c(NA, NA, NA, NA), 
                             names = c("Slope", "Lower", "Upper", "EC50")), 
                  na.action = na.omit)
  # outputs the summary of the paramters including the estimate, standard
  # error, t-value, and p-value outputs it into a data frame called
  # summary.mef.fit for 'summary of fit'
  summary.fit <- data.frame(summary(isolate1)[[3]])
  # outputs the summary of just the EC50 data including the estimate, standard
  # error, upper and lower bounds of the 95% confidence intervals around the
  # EC50
  EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
             interval = "delta")[[1]]
  EC50
  isolate.ec_i <- data.frame(nm[[i]], EC50) # create a one row dataframe containing just the isolate name and the EC50
  colnames(isolate.ec_i) <- c("Isolate", "EC50") # change the column names
  
  # Then we need to append our one row dataframe to our null dataframe we created before
  # and save it as EC50.ll4. 
  EC50.ll4 <- rbind.data.frame(EC50.ll4, isolate.ec_i)
}

EC50.ll4

ggplot(EC50.ll4, aes(x = EC50)) + geom_histogram() + theme_classic()

###MAPPING in tdyvers
EC50.data %>%
  group_by(is) %>% #grouping what we want to loop
  nest() %>% #all the data for each isolate we want to collapse that into a column called data
  mutate(ll.4.mod = map(data, ~drm(.$relgrowth ~ .$conc, #create a new column that will be the new iteration
                                   fct = LL.4(fixed = c(NA, NA, NA, NA), 
                                              names = c("Slope", "Lower", "Upper", "EC50"))))) %>%
  mutate(ec50 = map(ll.4.mod, ~ED(., 
                                  respLev = c(50), 
                                  type = "relative",
                                  interval = "delta")[[1]])) %>% #mutate again to estimate the EC50 for each fitted model contained within the ll.4.mod column
  unnest(ec50) #to estimate the EC50 for each fitted model contained within the ll.4.mod column


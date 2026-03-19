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










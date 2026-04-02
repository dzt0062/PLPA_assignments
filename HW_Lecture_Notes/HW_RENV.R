#RENV – Notes
# All functions and code is stored on the computer when packages are installed
#renv stores packages relative 
#writes a lockfile that is then uploaded to GitHub
#pulling from Git will restore the necessary packages and version that are necessary for the project
#update = Save
#renv::init()

#Steps to demonstrate
#1 Create a new repository in Git

library(ggplot2)
library(dplyr)
install.packages("renv")

#Write in the console directly
#renv::init()

#we want git to ignore this directory; library

#the .lib path shows where the R packages are being pulled from

#changes where the libraries are loaded from

#Ensures that the project can be used with the versions of packages that were used at the time the project was conducted


install.packages("MASS")

#check renv.lock to see if mass was loaded

install.packages("paletteer")

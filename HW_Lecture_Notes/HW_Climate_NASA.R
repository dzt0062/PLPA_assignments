#Getting Climate Data from NASA

#pulling weather variables at specific timeframes at specific coordinates collected by NASA power

#creating a for loop for weather data three days after planting across 400+ trials

install.packages("nasapower")
library(nasapower)
library(tidyverse)

install.packages("nasapower", repos = "https://ropensci.r-universe.dev")

daily.g <- get_power(community = "ag", lonlat = c(151.81, -27.48), pars = c("RH2M", "T2M", "PRECTOTCORR"), dates = "1985-01-01",   temporal_api = "daily")

daily.g

daily.auburn <-get_power(community = "ag", lonlat = c(32.5920, -85.4752), pars = c("RH2M", "T2M", "PRECTOTCORR"), dates = "2026-01-01",   temporal_api = "daily")

daily.auburn


#this can allow you to pair weather events events that might influence your data
#If I am understadning this correctly; For example, I ran a project from May 2021 to August 2021 where I ran outdoor graded exercise test on a 400m track utilizing portable metabolic cart
# I recorded ambient weather date manually, but this could serve as a more relaible method if it could provide acute weather conditions down to the hour, ie temp, wet buldb, humidity, wind.

daily.ftcampbell <- get_power(
  community = "ag",
  lonlat = c(36.6500, -87.4667),
  pars = c("T2M", "RH2M", "T2MWET", "WS2M"),
  dates = c("20210501", "20210831"),
  temporal_api = "daily"
)

head(daily.ftcampbell)

#I would then join this to the dates in which I conducted tests with Join
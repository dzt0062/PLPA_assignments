#additional learning
# creating a radar plaot for a "readiness assessment with fake data"

library(ggplot2)
library(dplyr)
library(tidyr)

#fake data
data <- data.frame(
  VO2 = 52,
  Grip = 55,
  BF = 25,
  FFMI = 20,
  RHR = 40
)

percentile <- function(x, ref) ecdf(ref)(x) * 100

# Example reference 
ref <- data.frame(
  VO2 = rnorm(100, 50, 5),
  Grip = rnorm(100, 50, 10),
  BF = rnorm(100, 20, 5),
  FFMI = rnorm(100, 19, 2),
  RHR = rnorm(100, 65, 10)
)

#normalizing to percentiles to have equal weight
scores <- data.frame(
  VO2 = percentile(data$VO2, ref$VO2),
  Grip = percentile(data$Grip, ref$Grip),
  BF = 100 - percentile(data$BF, ref$BF),   # lower is better
  FFMI = percentile(data$FFMI, ref$FFMI),
  RHR = 100 - percentile(data$RHR, ref$RHR) # lower is better
)

#trying to make a closeed geometric shape
radar_df_closed <- scores %>%
  pivot_longer(cols = everything(),
               names_to = "Metric",
               values_to = "Value")

ggplot(radar_df_closed, aes(x = Metric, y = Value, group = 1)) +
  geom_polygon(fill = "blue", alpha = 0.3, color = "blue") +
  geom_point(size = 3) +
  coord_polar() +
  ylim(0, 100) +
  theme_minimal() +
  labs(title = "Physiological Readiness Radar Plot",
       y = "Percentile")

radar_df_closed$Metric <- factor(
  radar_df_closed$Metric,
  levels = c("VO2", "RHR", "Grip", "FFMI", "BF")
)
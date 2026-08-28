library(tidyverse)
source("R/moving-average.R")

# Reading in all the raw data
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")

# Filtering site data for each site to the relevant time frame
filtered_prm <- prm_data |> 
  filter(year(Sample_Date) %in% c(1986:1995))
filtered_bq1 <- bq1_data |> 
  filter(year(Sample_Date) %in% c(1986:1995)) 
filtered_bq2 <- bq2_data |> 
  filter(year(Sample_Date) %in% c(1986:1995))
filtered_bq3 <- bq3_data |> 
  filter(year(Sample_Date) %in% c(1986:1995))

# Calling the stored moving average function to calculate moving average for each site
prm_average <- moving_average(filtered_prm)
bq1_average <- moving_average(filtered_bq1)
bq2_average <- moving_average(filtered_bq2)
bq3_average <- moving_average(filtered_bq3)

#Combining the results from moving average into one tibble including the site names
combined_data <- rbind(
  prm_average |> mutate(Site = as.factor("PRM")),
  bq1_average |> mutate(Site = as.factor("BQ1")),
  bq2_average |> mutate(Site = as.factor("BQ2")),
  bq3_average |> mutate(Site = as.factor("BQ3")) 
)

#Pivot longer to prepare the data frame for plotting
longer_combined <- combined_data |> 
  pivot_longer(
    cols = c(k_mgl, no3_ugl, mg_mgl, ca_mgl, nh4_ugl), 
    values_to = "Concentration",
    names_to = "Ion"
  ) 

  write_csv(longer_combined, "output/clean_data.csv")

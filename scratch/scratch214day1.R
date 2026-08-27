library(tidyverse)
source("R/moving-average.R")

# Goal: Figure with each Ion represented separately (facet wrap) for years 1988 to 1995
# Reading in all the data
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")

# Filtering site data
filtered_bq1 <- bq1_data |> 
  filter(year(Sample_Date) %in% c(1988:1995)) 
filtered_bq2 <- bq2_data |> 
  filter(year(Sample_Date) %in% c(1988:1995))
filtered_bq3 <- bq3_data |> 
  filter(year(Sample_Date) %in% c(1988:1995))
filtered_prm <- prm_data |> 
  filter(year(Sample_Date) %in% c(1988:1995))

#moving average function
bq1_smoothed <- moving_average(filtered_bq1)
bq2_smoothed <- moving_average(filtered_bq2)
bq3_smoothed <- moving_average(filtered_bq3)
prm_smoothed <- moving_average(filtered_prm)

#Combining into one large tibble
combined_data <- rbind(
  bq1_smoothed |> mutate(site = as.factor("BQ1")),
  bq2_smoothed |> mutate(site = as.factor("BQ2")),
  bq3_smoothed |> mutate(site = as.factor("BQ3")),
  prm_smoothed |> mutate(site = as.factor("PRM")) 
)


#Pivot longer
longer_combined <- pivot_longer(data = combined_data,
    cols = c(k_mgl, no3_ugl, mg_mgl, ca_mgl, nh4_ugl), 
    values_to = "Concentration",
    names_to = "Ion"
  ) 

ggplot(longer_combined,
    mapping = aes(
      x = window_start, 
      y = Concentration,
      linetype = "site"
    )
  ) + geom_line() +
  facet_wrap("Ion", scales = "free", ncol = 1) +
  labs(title = "Figure 3")


# Using combined data frame
# Combining into one data frame (not running right now)
combined_data <- rbind(clean_bq1, clean_bq2, clean_bq3, clean_prm)
filtered_combined_data <- combined_data |> 
  filter(year(Sample_Date) %in% c(1988:1995))




# Plotting the concentration over years (moving average not calculated yet) - Day 1 Activity
filtered_smoothed <- filtered_combined_data |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`), 
    values_to = "Concentration",
    names_to = "Ion"
  ) |> 
  ggplot(
    mapping = aes(
      x = Sample_Date, 
      y = Concentration,
      shape = Ion,
      colour = Ion
    )
  ) + geom_line()
print(filtered_smoothed)


clean_bq1 <- bq1_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq2 <- bq2_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq3 <- bq3_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_prm <- prm_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))
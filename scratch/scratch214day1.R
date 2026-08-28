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
prm_smoothed <- moving_average(filtered_prm)
bq1_smoothed <- moving_average(filtered_bq1)
bq2_smoothed <- moving_average(filtered_bq2)
bq3_smoothed <- moving_average(filtered_bq3)

#Combining the results from moving average into one tibble including the site names
combined_data <- rbind(
  prm_smoothed |> mutate(Site = as.factor("PRM")),
  bq1_smoothed |> mutate(Site = as.factor("BQ1")),
  bq2_smoothed |> mutate(Site = as.factor("BQ2")),
  bq3_smoothed |> mutate(Site = as.factor("BQ3")) 
)

#Pivot longer to prepare the data frame for plotting
longer_combined <- combined_data |> 
  pivot_longer(
    cols = c(k_mgl, no3_ugl, mg_mgl, ca_mgl, nh4_ugl), 
    values_to = "Concentration",
    names_to = "Ion"
  ) 

# Plotting the data
ggplot(longer_combined,
    mapping = aes(
      x = window_start, 
      y = Concentration,
      linetype = Site
    )
  ) + geom_line() +
  facet_wrap("Ion", scales = "free", ncol = 1, strip.position = "left") +
  geom_vline(xintercept = ymd('1989-09-17'), linetype = "dashed") +
  labs(title = "Concentrations in Bisley, Puerto Rico Streams before and after Hurricane Hugo", x = "Years", y = "Concentration of Ions")



# Safety blanket code

# Combining into one data frame
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


library(tidyverse)
source("R/moving-average.R")

# Goal: Figure with each Ion represented separately (facet wrap) for years 1988 to 1995
# Reading in all the data
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")

# Extracting only the relevant columns to the figure
clean_bq1 <- bq1_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq2 <- bq2_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq3 <- bq3_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_prm <- prm_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

#Checking number of NAs
print(sum(is.na(bq1_data$`NO3-N`)))

# Filtering site data
filtered_bq1 <- clean_bq1 |> 
  filter(year(Sample_Date) %in% c(1986:1995)) 
filtered_bq2 <- clean_bq2 |> 
  filter(year(Sample_Date) %in% c(1986:1995)) 

#moving average function
moving_average(filtered_data)

#Pivot longer
longer_average <- moving_average(filtered_data =) |> pivot_longer(
    cols = c(K_mgl, `NO3-N_ugl`, Mg_mgl, Ca_mgl, `NH4-N_ugl`), 
    values_to = "Concentration",
    names_to = "Ion"
  ) 

ggplot(longer_average,
    mapping = aes(
      x = window_start, 
      y = Concentration,
      shape = Ion,
      colour = Ion
    )
  ) + geom_line() +
  facet_wrap("Ion", scales = "free") +
  labs(title = "BQ2")


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

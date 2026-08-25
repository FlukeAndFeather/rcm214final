library(tidyverse)

# Goal: Figure with each Ion represented separately (facet wrap) for years 1988 to 1995
# Reading in all the data
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
b1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")

# Extracting only the relevant columns to the figure
clean_bq1 <- b1_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq2 <- bq2_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_bq3 <- bq3_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

clean_prm <- prm_data |> 
  select(c(Sample_ID, Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`))

#Checking number of NAs
print(sum(is.na(b1_data$`NO3-N`)))

# Combining into one data frame
combined_data <- rbind(clean_bq1, clean_bq2, clean_bq3, clean_prm)
filtered_combined_data <- combined_data |> 
  filter(year(Sample_Date) %in% c(1988:1995))


# Plotting the concentration over years (moving average not calculated yet)
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






# Processing the moving average with a 9 week window
average_table <- tibble(
  window_start = seq(
    ymd(filtered_combined_data$Sample_Date[1]),
    ymd(filtered_combined_data$Sample_Date[nrow(filtered_combined_data)]),
    by = "9 weeks"
  ),
  K_mgl = NA,
  `NO3-N_ugL` = NA,
  Mg>mgl = NA,
  Ca_mgl = NA,
  `NH4-N_ugl`= NA
)

for (i in 1:nrow(average_table)) {
  w1 <- average_table$window_start[i]

  w2 <- w1 + 

  K_values <- qs_data$k_mgl[
    qs_data$sample_date >= w1 &
      qs_data$sample_date < w2
  ]
  print(K_values)
  Mg_values <- qs_data$mg_mgl[
    qs_data$sample_date >= w1 &
      qs_data$sample_date < w2
  ]

  mean_K <- mean(K_values)
  qs_smoothed$k_mgl[i] <- mean_K
  mean_Mg <- mean(Mg_values)
  qs_smoothed$mg_mgl[i] <- mean_Mg
}
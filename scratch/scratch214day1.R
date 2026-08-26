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


# Processing the moving average with a 9 week window for one site

filtered_bq2 <- clean_bq2 |> 
  filter(year(Sample_Date) %in% c(1988:1995)) 

average_table <- tibble(
  window_start = seq(
    ymd(filtered_bq2$Sample_Date[1]),
    ymd(filtered_bq2$Sample_Date[nrow(filtered_bq2)]),
    by = "9 weeks"
  ),
  K_mgl = NA,
  `NO3-N_ugl` = NA,
  Mg_mgl = NA,
  Ca_mgl = NA,
  `NH4-N_ugl`= NA
)

for (i in 1:nrow(average_table)) {
  w1 <- average_table$window_start[i]

  w2 <- w1 + weeks(9)

  K_values <- filtered_bq2$K[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
  
  NO3_values <- filtered_bq2$`NO3-N`[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
   
Mg_values <- filtered_bq2$Mg[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
  
  Ca_values <- filtered_bq2$Ca[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
  
  NH4N_values <- filtered_bq2$`NH4-N`[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
  
  average_table$K_mgl[i] <- mean(K_values, na.rm = TRUE)
  
  average_table$`NO3-N_ugl`[i] <- mean(NO3_values, na.rm = TRUE)
 
  average_table$Mg_mgl[i] <- mean(Mg_values, na.rm = TRUE)
  
  average_table$Ca_mgl[i] <- mean(Ca_values, na.rm = TRUE)
 
  average_table$`NH4-N_ugl`[i] <- mean(NH4N_values, na.rm = TRUE)
}

longer_average <- average_table |> pivot_longer(
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





for (i in 1:nrow(average_table)) {
  w1 <- average_table$window_start[i]

  w2 <- w1 + weeks(9)

  K_values <- filtered_bq2$K[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
  
  NO3_values <- filtered_bq2$`NO3-N`[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2
  ]
   
Mg_values <- filtered_bq2$Mg[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2]
  
  Ca_values <- filtered_bq2$Ca[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2]
  
  NH4N_values <- filtered_bq2$`NH4-N`[
    filtered_bq2$Sample_Date >= w1 &
      filtered_bq2$Sample_Date < w2]
  
  mean_K <- mean(K_values)
  average_table$K_mgl[i] <- mean_K
  mean_No3 <- mean(NO3_values)
  average_table$`NO3-N_ugl`[i] <- mean_No3
  mean_Mg <- mean(Mg_values)
  average_table$Mg_mgl[i] <- mean_Mg
  mean_Ca <- mean(Ca_values)
  average_table$Ca_mgl[i] <- mean_Ca
  mean_NH4N <- mean(Ca_values)
  average_table$`NH4-N_ugl`[i] <- mean_NH4N
}
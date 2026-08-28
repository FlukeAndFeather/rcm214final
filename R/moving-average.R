# The input to this function should be a data frame containing stream chemistry data
library(tidyverse)
moving_average <- function(filtered_data) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(ymd(filtered_data$Sample_Date[1]), ymd(filtered_data$Sample_Date[nrow(filtered_data)]), by = "9 weeks"),
    site = filtered_data$Sample_ID[1], # This line will create a site column in your tibble, which will be populated accordingly by each of the filtered dataframes when you run the for loop
    k_mgl = NA,
    mg_mgl = NA,
  no3_ugl = NA,
  ca_mgl = NA,
  nh4_ugl= NA
    # Fill in the rest of the ions
  )

  
  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(9)
    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- filtered_data$Sample_Date >= w1 &
      filtered_data$Sample_Date < w2

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- filtered_data$K[in_window]
    mg_window <- filtered_data$Mg[in_window]
    no3_window <- filtered_data$`NO3-N`[in_window]
    ca_window <- filtered_data$Ca[in_window]
    nh4_window <- filtered_data$`NH4-N`[in_window]
    
    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgl[i] <- mean(k_window)
    result$mg_mgl[i] <- mean(mg_window)
    result$no3_ugl[i] <- mean(no3_window)
    result$ca_mgl[i] <- mean(ca_window)
    result$nh4_ugl[i] <- mean(nh4_window)
  }
  
  return(result)
  # Return the result
}

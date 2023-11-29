library(jsonlite)

url <- "https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=2&browser_zone=Eastern+Standard+Time"
data <- fromJSON(url)
print(data, pretty = TRUE)

# Extract the first row
first_row <- data$rows$c[[1]]

# Extract date and maximum UV index
date_values <- first_row$v[[1]]
date <- paste(date_values, collapse = ", ")
maximum <- first_row$v[[2]]

# Print the results
print(paste("Date:", date))
print(paste("Maximum UV Index:", maximum))

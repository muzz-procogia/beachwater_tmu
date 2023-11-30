library(jsonlite)

# # Extract the first row
# first_row <- data$rows$c[[1]]
#
# # Extract date and maximum UV index
# date_values <- first_row$v[[1]]
# date <- paste(date_values, collapse = ", ")
# maximum <- first_row$v[[2]]
#
# # Print the results
# print(paste("Date:", date))
# print(paste("Maximum UV Index:", maximum))

### functions:


# Function call maxUV:

fetchDataUV <- function(url) {
     data <- jsonlite::fromJSON(url)
     first_row <- data$rows$c[[1]]
     value <- first_row$v[[2]]
     return(value)
}

# function call avgwspd

# Helper Function to fetch and parse data from a JSON URL
fetchDataAvgwspd <- function(url) {
     data <- jsonlite::fromJSON(url)
     first_row <- data$rows$c[[1]]
     value <- first_row$v[[3]]
     return(value)
}

# function call rain48

# Helper Function to fetch and parse data from a JSON URL
fetchDataRain48 <- function(url) {
     data <- jsonlite::fromJSON(url)
     first_row <- data$rows$c[[1]]
     second_row <- data$rows$c[[2]]
     value <- first_row$v[[2]] + second_row$v[[2]]
     # Check if either of the values is NULL
     if (is.null(first_row$v[[2]]) || is.null(second_row$v[[2]])) {
          return("NULL (Please manually enter a value)")
     } else {
          value <- first_row$v[[2]] + second_row$v[[2]]
          return(value)
     }
}

# function call meantemp24

# Helper Function to fetch and parse data from a JSON URL
fetchDataMeantemp <- function(url) {
     data <- jsonlite::fromJSON(url)
     first_row <- data$rows$c[[1]]
     value <- first_row$v[[3]]
     return(value)
}

maxUV_url <- "https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=2&browser_zone=Eastern+Standard+Time"
maxUV_data <- fromJSON(maxUV_url)
print(maxUV_data, pretty = TRUE)

fetchDataUV(maxUV_url)

avgwpsd_url <- "https://niagarafalls.weatherstats.ca/data/wind_speed-daily.json?refresh_count=3&browser_zone=Eastern+Standard+Time"
avgwspd_data <- fromJSON(avgwpsd_url)
print(avgwspd_data, pretty = TRUE)

fetchDataAvgwspd(avgwpsd_url)

rain48_url <- "https://toronto.weatherstats.ca/data/rain-daily.json?refresh_count=2&browser_zone=Eastern+Standard+Time"
rain48_data <- fromJSON(rain48_url)
print(rain48_data, pretty = TRUE)

fetchDataRain48(rain48_url)

meantemp_url<- "https://niagarafalls.weatherstats.ca/data/temperature-daily.json?refresh_count=2&browser_zone=Eastern+Standard+Time"
meantemp_data <- fromJSON(meantemp_url)
print(meantemp_data, pretty = TRUE)

fetchDataMeantemp(meantemp_url)

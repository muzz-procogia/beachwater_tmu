library(jsonlite)

url <- "https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=2&browser_zone=Eastern+Standard+Time"
data <- fromJSON(url)
print(data, pretty = TRUE)

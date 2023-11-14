library(xml2)
library(httr)

url <- "https://dd.meteo.gc.ca/citypage_weather/xml/ON/s0000458_e.xml"
response <- httr::GET(url)
content <- httr::content(response, as = "text")

xml_data <- xml2::read_xml(content)

# Navigate to the UV node within the forecast node
uv_nodes <- xml_find_all(xml_data, ".//forecastGroup//forecast//uv")

# Extract the category attribute and index value from each UV node
uv_data <- lapply(uv_nodes, function(node) {
     category <- xml_attr(node, "category")
     index <- xml_text(xml_find_first(node, "./index"))
     list(category = category, index = index)
})

# Print the extracted data
print(uv_data)

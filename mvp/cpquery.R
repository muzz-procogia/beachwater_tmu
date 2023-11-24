#install.packages("C:/Users/Toadstool/Documents/R/beachwater_tmu_procogia/bnlearn_4.9-20230518.tar.gz", repos = NULL, type = "source")

library(bnlearn)
library(tidyverse)
# CORRECT SYNTAX FOR BNLEARN::CPQUERY

# I dont think you should created the pred_tables, just get what you need from the .net file


# Load .net file into bayesian network object
baynet <- read.net("datasets/Nov15NiagaraModel.net")


# these logical values are condition statements:
# cpquery(baynet,
#         event = (geomean200 == "true"), # in the data, this is either TRUE or FALSE,
#         evidence = (Max24UV == "[0,5.98]")) # these conditions are either TRUE or FALSE)

# Multiple evidence statements
# cpquery(baynet,
#         event = (geomean200 == "true"), # in the data, this is either TRUE or FALSE,
#         evidence = (avgwspd == "(5.6,11.1]" & rain48 == "[0,2.5]")) # these conditions are either TRUE or FALSE)


# and you can get the actual table of numbers like this
# table(cpdist(baynet, "Max24UV", (avgwspd == "(5.6,11.1]")))



### testing a dynamic value for shiny implement

# Function to determine the increment for Max24UV
determineMax24UVIncrement <- function(value) {
     if (value >= 0 && value <= 5.98) {
          return("[0,5.98]")
     } else if (value > 5.98 && value <= 7.1) {
          return("(5.98,7.1]")
     } else if (value > 7.1 && value <= 7.92) {
          return("(7.1,7.92]")
     } else if (value > 7.92 && value <= 12) {
          return("(7.92,12]")
     } else {
          return(NA) # or handle out-of-range values as needed
     }
}

# Example usage
uv_dummy <- 2
max24UV_increment <- determineMax24UVIncrement(uv_dummy)

# Use cpquery with dynamic evidence
cpquery(baynet,
       event = (geomean200 == "true"),
       evidence = (Max24UV == max24UV_increment)
)




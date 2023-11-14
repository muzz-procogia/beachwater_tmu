install.packages("C:/Users/Toadstool/Documents/R/beachwater_tmu_procogia/bnlearn_4.9-20230518.tar.gz", repos = NULL, type = "source")

library(bnlearn)
library(tidyverse)
# CORRECT SYNTAX FOR BNLEARN::CPQUERY

# I dont think you should created the pred_tables, just get what you need from the .net file


# Load .net file into bayesian network object
baynet <- read.net("Nov14NiagaraModel.net")

nodes <- names(baynet) # these are the nodes of the network
baynet[["geomean200"]] %>% names()
  baynet[["geomean200"]]$node  # node name, same as the baynet name "Max24UV"
  baynet[["geomean200"]]$parents # parent nodes: "rain48", "avwspd", "avgwh24"
  baynet[["geomean200"]]$children # children nodes: "geomean24", "meantemp24", "watertemp"
  baynet[["geomean200"]]$prob


cpquery(fitted = baynet,
        event = logical(),
        evidence = logical())

# these logical values are condition statements:
cpquery(baynet,
  event = (Max24UV == "[0,5.98]"), # in the data, this is either TRUE or FALSE,
  evidence = (avgwspd == "(5.6,11.1]")) # these conditions are either TRUE or FALSE)

# Multiple evidence statements
cpquery(baynet,
        event = (Max24UV == "[0,5.98]"), # in the data, this is either TRUE or FALSE,
        evidence = (avgwspd == "(5.6,11.1]" & rain48 == "[0,2.5]")) # these conditions are either TRUE or FALSE)


# and you can get the actual table of numbers like this
table(cpdist(baynet, "Max24UV", (avgwspd == "(5.6,11.1]")))



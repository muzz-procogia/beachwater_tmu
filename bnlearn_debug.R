library(bnlearn)

# Load .net file into bayesian network object
baynet <- read.net("NiagaraModel.net")
View(baynet)

# Rachel mentioned the geomean200 should be the 'event' for the cpquery()
## the solutions they tried was inserting a select few of geomean200's parameters into event
## it seems to me that they aren't sure which parameter they need/is appropriate for event
?cpquery()

# baynet is a list of lists, with an S3 table for prob
## What I tried was isolating the geomean200 prob S3 table
pred_tables <- baynet[[7]][[4]][,,1 , , , ]
View(pred_tables)

# my best guess is the Freq are the values that should be inserted into event
## here is the next relevant code from their end


geomean200_range <- c(0, 1)

# I am hardcoding values to circumvent Shiny
evidence <- list(
     Max24UV = as.numeric(unlist(strsplit("0 - 5.98", " - "))),
     avgvwh24 = as.numeric(unlist(strsplit("0 - 0.19", " - "))),
     waveheight = as.numeric(unlist(strsplit("0 - 5", " - "))),
     avgwspd = as.numeric(unlist(strsplit("0 - 3.15", " - "))),
     geomean24 = as.numeric(unlist(strsplit("1 - 50", " - "))),
     rain48 = as.numeric(unlist(strsplit("0 - 2.5", " - "))),
     watertemp = as.numeric(unlist(strsplit("0 - 15", " - "))),
     turbidity = as.numeric(unlist(strsplit("0 - 5", " - "))),
     meantemp24 = as.numeric(unlist(strsplit("7.3 - 17.2", " - ")))
)

prediction <- cpquery(baynet,
                      event = (
                           geomean200 >= geomean200_range[1] &
                           geomean200 <= geomean200_range[2]),
                      evidence = evidence)

# the solution for the error:
     ## Error in sampling(fitted = fitted, event = event, evidence = evidence,  :
     ## evidence must evaluate to a logical vector
## is unrelated to event, however, Rachel still thinks event is an issue to solve as well as
## not knowing how to fix the evidence error

# Why is it looking for a TRUE or FALSE from these inputs?
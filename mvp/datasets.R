#Load datasets from file
BeachEcoli <- read.csv("datasets/BeachEcoli.csv")
BeachLocation <- read.csv("datasets/BeachLocation.csv")
AllWeather <- read.csv("datasets/AllWeather.csv")
baynet <- bnlearn::read.net("datasets/Nov15NiagaraModel.net")

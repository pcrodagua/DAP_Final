########### Galgo with Logistic regression ###########
library(galgo)
data <- read.csv(file='../data/clean/anemia_balanced_clean.csv')
data <- data.frame(data)

datosgalgo<-t(data[,1:(ncol(data)-1)])

clases <- data$ANEMIA

anemia_gg<-configBB.VarSel(data=datosgalgo,
                              classes=factor(unlist(clases)),
                              classification.method="nearcent",
                              saveVariable="anemia_gg",
                              saveFrequency=5,
                              saveFile="anemia_gg.Rdata",
                              goalFitness=0.95,
                              maxBigBangs=300,
                              maxGenerations=500, # for each BigBangs how generation will evolve the system 
                              scale=FALSE)


blast(anemia_gg)
plot(anemia_gg)

plot(anemia_gg, type="fitness")

####

fsm <- forwardSelectionModels(anemia_gg)
fsm$models

colnames(data[c(1,  6,  8,  9, 15)])

par(mfrow=c(2,1))
plot(anemia_gg, type="fitness", filter="solutions")
plot(anemia_gg, type="fitness", filter="nosolutions")
plot(anemia_gg, type="confusion")

  
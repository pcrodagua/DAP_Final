x_values <- read.csv(file='demo_caries_x.csv', stringsAsFactors=FALSE)
y_values <- read.csv(file='demo_caries_y.csv', stringsAsFactors=FALSE)

# as dataframe
data_x <- data.frame(x_values)
data_y <- data.frame(y_values)
library(galgo)
bb.nc <- configBB.VarSel(
	data=data_x,
	classes=data_y$OUTPUT,
	classification.method="nearcent",
	chromosomeSize=5,
	maxSolutions=1000,
	goalFitness = 0.90,
	main="Caries",
	saveVariable="bb.nc",
	saveFrequency=5,
	saveFile="bb.nc.Rdata"
)

blast(bb.nc)

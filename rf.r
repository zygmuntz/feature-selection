# source( 'rf.r' )

# run random forest on filtered datasets with selected features

ntrees = 400

library( randomForest )
library( caTools )

# setwd( '/full/path/to/the/script/dir/' )

train_file = 'data/train_mrmr.csv'
validation_file = 'data/validation_mrmr.csv'

train <- read.csv( train_file )
validation <- read.csv( validation_file )

###

rf <- randomForest( train[,-1], as.factor( train[,1] ), ntree = ntrees, do.trace = 10 )  # mtry = nvars,
p <- predict( rf, validation[,-1], type = 'prob' )
p_binary <- predict( rf, validation[,-1] )
probs =  p[,2]

###

accuracy = sum( p_binary == validation[,1] ) / length( p_binary )
cat( "accuracy:", accuracy, "\n" )

auc = colAUC( probs, ( validation[,1] + 1 ) / 2 )
auc = auc[1]

cat( "auc:", auc, "\n" )

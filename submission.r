# source( 'submission.r' )

# prepare submission files for the feature selection challenge

ntrees = 400

library( randomForest )
library( caTools )

# setwd( '/full/path/to/the/script/dir/' )

train_file = 'data/train_mrmr.csv'
validation_file = 'data/validation_mrmr.csv'
test_file = 'data/test_mrmr.csv'

train <- read.csv( train_file )
validation <- read.csv( validation_file )
test <- read.csv( test_file )

x_train = train[,-1]
x_validation = validation[,-1]
x_test = test

y_train = train[,1]
y_validation = validation[,1]

###

combined_x_train = rbind( x_train, x_validation)
combined_y_train = as.factor( rbind( as.matrix( y_train ), as.matrix( y_validation )))

rf <- randomForest( combined_x_train, combined_y_train, ntree = ntrees, do.trace = 10 )

# training set predictions
train_p <- predict( rf, x_train, type = 'prob' )
train_probs =  train_p[,2]
train_p_binary <- predict( rf, x_train )

# validation set predictions
valid_p <- predict( rf, x_validation, type = 'prob' )
valid_probs =  valid_p[,2]
valid_p_binary <- predict( rf, x_validation )

# test set predictions
test_p <- predict( rf, x_test, type = 'prob' )
test_probs =  test_p[,2]
test_p_binary <- predict( rf, x_test )

# compute confidence values from probabilities
train_conf = abs( train_probs - 0.5 ) * 2;
valid_conf = abs( valid_probs - 0.5 ) * 2;
test_conf = abs( test_probs - 0.5 ) * 2;

# output files
write.table( train_p_binary, 'madelon_train.resu', col.names = F, row.names = F, quote = F )
write.table( valid_p_binary, 'madelon_valid.resu', col.names = F, row.names = F, quote = F )
write.table( test_p_binary, 'madelon_test.resu', col.names = F, row.names = F, quote = F )

write.table( train_conf, 'madelon_train.conf', col.names = F, row.names = F, quote = F )
write.table( valid_conf, 'madelon_valid.conf', col.names = F, row.names = F, quote = F )
write.table( test_conf, 'madelon_test.conf', col.names = F, row.names = F, quote = F )

###

# validation metrics
accuracy = sum( valid_p_binary == y_validation ) / length( valid_p_binary )
cat( "validation accuracy:", accuracy, "\n" )

auc = colAUC( valid_probs, ( y_validation + 1 ) / 2 )
auc = auc[1]
cat( "validation auc:", auc, "\n" )

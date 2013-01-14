# source( 'sets_mrmr.r' )

# construct data sets based on chosen features (discard the rest)

mrmr_indexes = c( 339, 242, 476, 337, 65, 473, 443, 129, 106, 49, 454, 494, 379  )

output_train_file = "data/train_mrmr.csv"
output_validation_file = "data/validation_mrmr.csv"
output_test_file = "data/test_mrmr.csv"

# setwd( '/full/path/to/the/script/dir/' )

train_file = 'data/madelon_train.data'
train_labels = 'data/madelon_train.labels'

validation_file = 'data/madelon_valid.data'
validation_labels = 'data/madelon_valid.labels'

test_file = 'data/madelon_test.data'
test_labels = 'data/madelon_test.labels'

###

x_train <- read.table( train_file, sep = " " )
x_validation <- read.table( validation_file, sep = " " )
x_test <- read.table( test_file, sep = " " )

y_train = as.numeric( readLines( train_labels ))
y_validation = as.numeric( readLines( validation_labels ))

###

x_combined = rbind( x_train, x_validation, x_test );
x_combined = x_combined[, 1:500]

train_rows = nrow( x_train )
validation_rows = nrow( x_validation )
test_rows = nrow( x_test )

####

x2_combined = x_combined[, mrmr_indexes]

# now split back
x2_train = x2_combined[1 : train_rows,]
x2_validation = x2_combined[ (train_rows+1) : (train_rows+validation_rows),]
x2_test = x2_combined[(train_rows+validation_rows+1) : (train_rows+validation_rows+test_rows),]

# add labels at the fron
train2  = cbind( as.data.frame( y_train ), x2_train )
validation2 = cbind( as.data.frame( y_validation ), x2_validation )

write.csv( train2, output_train_file, row.names = F, quote = F )
write.csv( validation2, output_validation_file, row.names = F, quote = F )
write.csv( x2_test, output_test_file, row.names = F, quote = F )


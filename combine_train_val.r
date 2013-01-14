# source( 'combine_x.r' )

# combine train and validation into one file

output_file = "data/combined_train_val.csv"

# setwd( '/full/path/to/the/script/dir/' )

train_file = 'data/madelon_train.data'
train_labels = 'data/madelon_train.labels'

validation_file = 'data/madelon_valid.data'
validation_labels = 'data/madelon_valid.labels'

x_train <- read.table( train_file, sep = " " )
x_validation <- read.table( validation_file, sep = " " )

x_combined = rbind( x_train, x_validation );
x_combined = x_combined[, 1:500]

y_train = as.numeric( readLines( train_labels ))
y_validation = as.numeric( readLines( validation_labels ))
y_combined = append( y_train, y_validation )

train_val_combined = cbind( as.data.frame( y_combined ), x_combined )

write.csv( train_val_combined, output_file, row.names = F, quote = F )


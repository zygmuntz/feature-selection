Feature selection
=================

See [http://fastml.com/feature-selection-in-practice/](http://fastml.com/feature-selection-in-practice/) for description.

	data/ - original and transformed Madelon sets
	combine_train_val.r - combine train and validation into one file (input for feature selection)
	rf.r - Run random forest on datasets with selected features (prepared with sets_mrmr.r)
	sets_mrmr.r - Prepare datasets with selected features only
	submission.r - Write submission files for http://www.nipsfsc.ecs.soton.ac.uk/
	
	
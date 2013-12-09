function [ experiments ] = experiment(features,labels,K,feature_type,classifier )
    tic;
    [n_runs, run_len] = size(features);
    results = cell(K,1);
    folds = crossvalind('Kfold',n_runs,K);
    times.train_times = zeros(K,1);
    times.test_times = zeros(K,1);
    tic;
    for k = 1:K
	[feature_type.model,feature_train] = feature_selection(features(folds~=k,:),feature_type,1);
	[~,feature_test] = feature_selection(features(folds==k,:),feature_type,0);
	tic;
	model = train(feature_train,labels(folds~=k),classifier);
        times.train_times(k) = toc;
        tic;
        [results{k}.confusion, results{k}.error] = ...
            test(model,feature_test,labels(folds==k),classifier);
        times.test_times(k) = toc;
	clear model;
	'one eval'
    end
    times.tottal_tt_end = toc;
    times.experiment_time = toc;
    experiments.times = times;
    experiments.results = results;
end


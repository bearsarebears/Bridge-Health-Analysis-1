function [ experiments ] = experiment(features,labels,K,classifier )
    tic;
    results = cell(K,1);
    folds = crossvalind('Kfold',size(features,2),K);
    times.train_times = zeros(K,1);
    times.test_times = zeros(K,1);
    tic;
    for k = 1:K
        tic;
	model = train(features(:,folds ~= k),labels(folds~=k),classifier);
        times.train_times(k) = toc;
        tic;
        [results{k}.confusion, results{k}.error] = ...
            test(model,features(:,folds==k),labels(folds==k),classifier);
        times.test_times(k) = toc;
    end
    times.tottal_tt_end = toc;
    times.experiment_time = toc;
    experiments.times = times;
    experiments.results = results;
end


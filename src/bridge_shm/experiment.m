function [ results,times ] = experiment(rfeatures,labels,K,classifier )
    tic;
    results = cell(K,1);
    folds = crossvalind('Kfold',size(rfeatures,2),K);
    times.train_times = zeros(K,1);
    times.test_times = zeros(K,1);
    tic;
    for k = 1:K
        tic;
        model = train(rfeatures(:,folds ~= k),labels(folds~=k),classifier);
        times.train_times(k) = toc;
        tic;
        [results{k}.confusion, results{k}.error] = ...
            test(model,rfeatures(:,folds==k),labels(folds==k),classifier);
        times.test_times(k) = toc;
    end
    times.tottal_tt_end = toc;
    times.experiment_time = toc;
end


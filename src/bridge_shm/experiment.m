function [ models,results,times ] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type )
    tic;tic;
    rdata = load(data_file);
    rdata = rdata.rdata;

    models = cell(K,1);
    results = cell(K,1);

    times.load_end = toc;

    tic;
    rfeatures = feature_compute(rdata,f0,f1,f2,f3,feature_type,depth);
    times.feature_time_end = toc;

    folds = kfold_traintest(rfeatures,f0,f1,f2,K);

    times.train_times = cell(K,1);
    times.test_times = cell(K,1);
    tic;
    for k = 1:K
        train_ind = find(folds ~= k);
        test_ind = find(folds == k);
        tic;models{k} = train(rfeatures,f0,f1,f2,classifier_type,train_ind);
        times.train_times{k} = toc;
        tic;[results{k}.confusion, results{k}.error] = ...
            test(models{k},rfeatures,f0,f1,f2,classifier_type,test_ind);
        times.test_times{k} = toc;
    end
    times.tottal_tt_end = toc;
    times.end_time = toc;
end


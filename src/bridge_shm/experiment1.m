%% ENVIRONMENT INITIALIZATION

clear all; close all;clc;
feature_type = 'haar';
classifier_type = 'svm';
tic;
%% LOAD DATA


tic;
K = 11;
rdata = load('resampled_data');
rdata = rdata.rdata;

% select features
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f1 = {'S3','S4','S5','S6'};
f2 = {'F'};
f3 = {'WF','WB','SF', 'SB'};
models = cell(K,1);
results = cell(K,1);

load_end = toc;

%% COMPUTE FEATURES
tic;
rfeatures = feature_compute(rdata,f0,f1,f2,f3,feature_type);
feature_time_end = toc;

folds = kfold_traintest(rfeatures,f0,f1,f2,K);

%% TRAIN FOR EACH SET K WITHHELD THEN TEST ON K

train_times = cell(K,1);
test_times = cell(K,1);
total_tt_start = tic;


for k = 1:K
    train_ind = find(folds ~= k);
    test_ind = find(folds == k);
    tic;
    models{k} = train(rfeatures,f0,f1,f2,'svm',train_ind);
    train_times{k} = toc;
    tic;
    [results{k}.confusion, results{k}.error] = ...
        test(models{k},rfeatures,f0,f1,f2,'svm',test_ind);
    test_times{k} = toc;
end

tottal_tt_end = toc;
end_time = toc;

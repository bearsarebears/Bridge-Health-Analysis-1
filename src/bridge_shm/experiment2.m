
clc; close all; clear all;
data_file = 'resampled_data';
K = 8;

feature_type = 'haar';
depth = 5;

classifier_type = 'svm';

n_experiments = 7;
experiments.models = cell(n_experiments,1);
experiments.results = cell(n_experiments,1);


load(data_file);
%% Compute All Features;
tic;
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f1 = {'S3','S4','S5','S6'};
f2 = {'F','B'};
f3 = {'WF','WB','SF', 'SB'};
rfeatures = feature_compute(rdata,f0,f1,f2,f3,feature_type,depth);
feature_time = toc;
clear rdata;

%% 1
f1 = {'S3','S4','S5','S6'};
f2 = {'F'};

[feature_matrix,class_labels] = load_matrix(rfeatures,f0,f1,f2,[]);

[experiment.models{1},experiment.results{1},experiment.times{1}] = ...
    experiment(feature_matrix,class_labels,K,classifier_type);
clear feature_matrix;clear class_labels; pack;

%% 2
f1 = {'S3','S4','S5','S6'};
f2 = {'F','B'};

[experiment.models{2},experiment.results{2},experiment.times{2}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 3
f1 = {'S3','S4','S5','S6'};
f2 = {'B'};

[experiment.models{3},experiment.results{3},experiment.times{3}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 4
f1 = {'S3'};
f2 = {'F'};

[experiment.models{4},experiment.results{4},experiment.times{4}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 5
f1 = {'S4'};
f2 = {'F'};

[experiment.models{5},experiment.results{5},experiment.times{5}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 6
f1 = {'S5'};
f2 = {'F'};

[experiment.models{6},experiment.results{6},experiment.times{6}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 7
f1 = {'S7'};
f2 = {'F'};

[experiment.models{7},experiment.results{7},experiment.times{7}] = ...
    experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

save('experiments.mat');

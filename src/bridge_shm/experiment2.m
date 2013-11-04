
clc; close all; clear all;
data_file = 'resampled_data';
K = 11;
feature_type = 'haar';
classifier_type = 'svm';
depth = 7;
n_experiments = 7;
experiments.models = cell(n_experiments,1);
experiments.results = cell(n_experiments,1);
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f3 = {'WF','WB','SF', 'SB'};

%% 1
f1 = {'S3','S4','S5','S6'};
f2 = {'F'};


[experiment.models{1},experiment.results{1},experiment.times{1}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 2
f1 = {'S3','S4','S5','S6'};
f2 = {'F','B'};

[experiment.models{2},experiment.results{2},experiment.times{2}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 3
f1 = {'S3','S4','S5','S6'};
f2 = {'B'};

[experiment.models{3},experiment.results{3},experiment.times{3}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 4
f1 = {'S3'};
f2 = {'F'};

[experiment.models{4},experiment.results{4},experiment.times{4}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 5
f1 = {'S4'};
f2 = {'F'};

[experiment.models{5},experiment.results{5},experiment.times{5}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 6
f1 = {'S5'};
f2 = {'F'};

[experiment.models{6},experiment.results{6},experiment.times{6}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

%% 7
f1 = {'S6'};
f2 = {'F'};

[experiment.models{6},experiment.results{6},experiment.times{6}] = experiment(data_file,f0,f1,f2,f3,K,feature_type,depth,classifier_type);

save('experiments.mat');
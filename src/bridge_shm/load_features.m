c = who('rfeatures');
if numel(c) == 0
	clc; close all; clear all;
data_file = 'resampled_data';
K = 8;

feature_type = 'haar';
depth = 5;

classifier_type = 'svm';

n_experiments = 1;
experiments.models = cell(n_experiments,1);
experiments.results = cell(n_experiments,1);

%% Compute All Features;
load(data_file);
tic;
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f1 = {'S3','S4','S5','S6'};
f2 = {'F','B'};
f3 = {'WF','WB','SF', 'SB'};
rfeatures = feature_compute(rdata,f0,f1,f2,f3,feature_type,depth)
feature_time = toc;
clear rdata;
end
